local Constants = {
  HEADER_CHUNK_TYPE = {
    77,
    84,
    104,
    100
  },
  HEADER_CHUNK_LENGTH = {
    0,
    0,
    0,
    6
  },
  HEADER_CHUNK_FORMAT0 = {0, 0},
  HEADER_CHUNK_FORMAT1 = {0, 1},
  HEADER_CHUNK_DIVISION = {0, 128},
  TRACK_CHUNK_TYPE = {
    77,
    84,
    114,
    107
  },
  META_EVENT_ID = 255,
  META_TEXT_ID = 1,
  META_COPYRIGHT_ID = 2,
  META_TRACK_NAME_ID = 3,
  META_INSTRUMENT_NAME_ID = 4,
  META_LYRIC_ID = 5,
  META_MARKER_ID = 6,
  META_CUE_POINT = 7,
  META_TEMPO_ID = 81,
  META_TIME_SIGNATURE_ID = 88,
  META_KEY_SIGNATURE_ID = 89,
  META_END_OF_TRACK_ID = {47, 0},
  PROGRAM_CHANGE_STATUS = 192,
  NOTES = nil,
  STR_NOTES = nil,
  METADATA_TYPES = {
    "Text",
    "Copyright",
    "Name",
    "Instrument",
    "Lyric",
    "Marker",
    "Cue Point",
    [81] = "Tempo",
    [88] = "Time Signature",
    [89] = "Key Signature"
  }
}
local table_notes = {
  {"C", "B#"},
  {"C#", "Db"},
  {"D"},
  {"D#", "Eb"},
  {"E", "Fb"},
  {"F", "E#"},
  {"F#", "Gb"},
  {"G"},
  {"G#", "Ab"},
  {"A"},
  {"A#", "Bb"},
  {"B", "Cb"}
}
if Constants.NOTES == nil then
  Constants.NOTES = {}
  Constants.STR_NOTES = {}
  local counter = 0
  for i = -1, 9 do
    for tone, note in ipairs(table_notes) do
      for _, notation in ipairs(note) do
        Constants.NOTES[notation .. i] = counter
      end
      counter = counter + 1
    end
  end
  for key, value in pairs(Constants.NOTES) do
    if Constants.STR_NOTES[value] == nil then
      Constants.STR_NOTES[value] = {}
      Constants.STR_NOTES[value].firstNote = key
    else
      Constants.STR_NOTES[value].secondNote = key
    end
  end
end

local function read(stream, count)
  local result = ""
  while #result ~= count do
    result = result .. assert(stream:read(count), "missing value")
  end
  return result
end

local function readVLQ(stream)
  local value = 0
  local length = 0
  repeat
    local byte = assert(stream:read(1), "incomplete or missing variable length quantity"):byte()
    value = value << 7
    value = value | byte & 127
    length = length + 1
  until byte < 128
  return value, length
end

local midiEvent = {
  [128] = function(stream, callback, channel, fb)
    local key, velocity = ("I1I1"):unpack(fb .. stream:read(1))
    callback("noteOff", channel, key, velocity / 127)
    return 2
  end,
  [144] = function(stream, callback, channel, fb)
    local key, velocity = ("I1I1"):unpack(fb .. stream:read(1))
    callback("noteOn", channel, key, velocity / 127)
    return 2
  end,
  [160] = function(stream, callback, channel, fb)
    local key, pressure = ("I1I1"):unpack(fb .. stream:read(1))
    callback("keyPressure", channel, key, pressure / 127)
    return 2
  end,
  [176] = function(stream, callback, channel, fb)
    local number, value = ("I1I1"):unpack(fb .. stream:read(1))
    if number < 120 then
      callback("controller", channel, number, value)
    else
      callback("modeMessage", channel, number, value)
    end
    return 2
  end,
  [192] = function(stream, callback, channel, fb)
    local program = fb:byte()
    callback("program", channel, program)
    return 1
  end,
  [208] = function(stream, callback, channel, fb)
    local pressure = fb:byte()
    callback("channelPressure", channel, pressure / 127)
    return 1
  end,
  [224] = function(stream, callback, channel, fb)
    local lsb, msb = ("I1I1"):unpack(fb .. stream:read(1))
    callback("pitch", channel, (lsb | msb << 7) / 8192 - 1)
    return 2
  end
}

local function sysexEvent(stream, callback, fb)
  local manufacturer = fb:byte()
  local data = {}
  repeat
    local char = stream:read(1)
    table.insert(data, char)
  until char:byte() == 247
  callback("sysexEvent", data, manufacturer, table.concat(data))
  return 1 + #data
end

local function makeForwarder(name)
  return function(data, callback)
    callback(name, data)
  end
end

local metaEvents = {
  [0] = makeForwarder("sequenceNumber"),
  [1] = makeForwarder("text"),
  [2] = makeForwarder("copyright"),
  [3] = makeForwarder("sequencerOrTrackName"),
  [4] = makeForwarder("instrumentName"),
  [5] = makeForwarder("lyric"),
  [6] = makeForwarder("marker"),
  [7] = makeForwarder("cuePoint"),
  [32] = makeForwarder("channelPrefix"),
  [47] = makeForwarder("endOfTrack"),
  [81] = function(data, callback)
    local rawTempo = (">I3"):unpack(data)
    callback("setTempo", 6.0E7 / rawTempo)
  end,
  [84] = makeForwarder("smpteOffset"),
  [88] = function(data, callback)
    local numerator, denominator, metronome, dotted = (">I1I1I1I1"):unpack(data)
    callback("timeSignature", numerator, 1 << denominator, metronome, dotted)
  end,
  [89] = function(data, callback)
    local count, minor = (">I1I1"):unpack(data)
    callback("keySignature", math.abs(count), count < 0 and "flat" or 0 < count and "sharp" or "C", minor == 0 and "major" or "minor")
  end,
  [127] = makeForwarder("sequenceEvent")
}

local function metaEvent(stream, callback, fb)
  local event = fb:byte()
  local length, vlqLength = readVLQ(stream)
  local data = read(stream, length)
  local handler = metaEvents[event]
  if handler then
    handler(data, callback)
  end
  return 1 + vlqLength + length
end

local function readChunkInfo(stream)
  local chunkInfo = stream:read(8)
  if not chunkInfo then
    return false
  end
  assert(#chunkInfo == 8, "incomplete chunk info")
  return (">c4I4"):unpack(chunkInfo)
end

local function readHeader(stream, callback, chunkLength)
  local header = read(stream, chunkLength)
  assert(header and #header == 6, "incomplete or missing header")
  local format, tracks, division = (">I2I2I2"):unpack(header)
  callback("header", format, tracks, division)
  return format, tracks
end

local function processEvent(stream, callback, runningStatus)
  local firstByte = assert(stream:read(1), "missing event")
  local status = firstByte:byte()
  local length = 0
  if status < 128 then
    status = assert(runningStatus, "no running status")
  else
    firstByte = stream:read(1)
    length = 1
    runningStatus = status
  end
  if 128 <= status and status < 240 then
    length = length + midiEvent[status & 240](stream, callback, (status & 15) + 1, firstByte)
  elseif status == 240 then
    length = length + sysexEvent(stream, callback, firstByte)
  elseif status == 242 then
    length = length + 2
  elseif status == 243 then
    length = length + 1
  elseif status == 255 then
    length = length + metaEvent(stream, callback, firstByte)
  else
    callback("ignore", status)
  end
  return length, runningStatus
end

local function readTrack(stream, callback, chunkLength, track)
  callback("track", track)
  local runningStatus
  while 0 < chunkLength do
    local ticks, vlqLength = readVLQ(stream)
    if 0 < ticks then
      callback("deltatime", ticks)
    end
    local readChunkLength
    readChunkLength, runningStatus = processEvent(stream, callback, runningStatus)
    chunkLength = chunkLength - readChunkLength - vlqLength
  end
end

local function process(stream, callback, onlyHeader, onlyTrack)
  callback = callback or function()
  end
  local format, tracks
  local track = 0
  while true do
    local chunkType, chunkLength = readChunkInfo(stream)
    if not chunkType then
      break
    end
    if chunkType == "MThd" then
      assert(not format, "only a single header chunk is allowed")
      format, tracks = readHeader(stream, callback, chunkLength)
      assert(tracks == 1 or format ~= 0, "midi format 0 can only contain a single track")
      assert(not onlyTrack or 1 <= onlyTrack and onlyTrack <= tracks, "track out of range")
      if onlyHeader then
        break
      end
    elseif chunkType == "MTrk" then
      track = track + 1
      assert(format, "no header chunk before the first track chunk")
      assert(tracks >= track, "found more tracks than specified in the header")
      assert(track == 1 or format ~= 0, "midi format 0 can only contain a single track")
      if not onlyTrack or track == onlyTrack then
        readTrack(stream, callback, chunkLength, track)
        if onlyTrack then
          break
        end
      else
        stream:seek("cur", chunkLength)
      end
    else
      local data = read(chunkLength)
      callback("unknownChunk", chunkType, data)
    end
  end
  if not onlyHeader and not onlyTrack then
    assert(track == tracks, "found less tracks than specified in the header")
  end
  return tracks
end

local function processHeader(stream, callback)
  return process(stream, callback, true)
end

local function processTrack(stream, callback, track)
  return process(stream, callback, false, track)
end

local function get_str_pitch(pitch)
  local numberPitch = tonumber(pitch)
  if numberPitch == nil then
    return nil
  end
  if numberPitch < 0 or 127 < numberPitch then
    return nil
  end
  return Constants.STR_NOTES[numberPitch]
end

return {
  process = process,
  processHeader = processHeader,
  processTrack = processTrack,
  processEvent = processEvent,
  get_str_pitch = get_str_pitch
}
