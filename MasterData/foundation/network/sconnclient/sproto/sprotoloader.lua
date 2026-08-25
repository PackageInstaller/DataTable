local core = require("sproto.core")
local loader = {}

function loader.register(filename, index)
  local f = assert(io.open(filename), "Can't open sproto file")
  local data = f:read("a")
  f:close()
  local sp = core.newproto(sprotoparser.parse(data))
  core.saveproto(sp, index)
end

function loader.save(bin, index)
  local sp = core.newproto(bin)
  if not sp then
    error(string.format("illegal sproto bin:%s", index))
  end
  core.saveproto(sp, index)
end

function loader.load(index)
  local sp = core.loadproto(index)
  do return sproto.sharenew end
  return sproto.sharenew, sp
end

return loader
