_class("PRecordInfo", Object)
PRecordInfo = PRecordInfo

function PRecordInfo:Constructor()
  self.stackindex = 1
  self.name = ""
  self.use_tick = 0
  self.begin_tick = 0
end

function PRecordInfo._LessComparer(nItemIDA, nItemIDB)
  local a = nItemIDA._info
  local b = nItemIDB._info
  if a.stackindex < b.stackindex then
    return 1
  elseif a.stackindex > b.stackindex then
    return -1
  elseif a.use_tick > b.use_tick then
    return 1
  elseif a.use_tick < b.use_tick then
    return -1
  else
    return 0
  end
end

_class("ProfilerNode", Object)
ProfilerNode = ProfilerNode

function ProfilerNode:Constructor()
  self._info = nil
  self._parent_node = nil
  self._child_node_list = nil
end

local LuaProfiler = _ENV.LuaProfiler
_class("ProfilerRecord", Object)
ProfilerRecord = ProfilerRecord
_class("CustomProfiler", Object)
CustomProfiler = CustomProfiler

function CustomProfiler:Constructor()
  self._profiler_run = false
  self._stack_space = {}
  self._stack_space[1] = "\t"
  for i = 2, 100 do
    self._stack_space[i] = self._stack_space[i - 1] .. "\t"
  end
  self:Init()
  self._frame_count = 1
end

function CustomProfiler:Init()
  self._curStackIndex = 1
  self._profiler_data_list = ArrayList:New()
  self._profiler_tree_head = self:NewNode("ProflierBegin")
  self._profiler_tree_head._info.stackindex = 0
  self._cur_node = nil
end

function CustomProfiler:ClearFrameData()
  self._profiler_tree_head = self:NewNode("ProflierBegin")
  self._profiler_tree_head._info.stackindex = 0
  self._curStackIndex = 1
  self._cur_node = nil
end

function CustomProfiler:Start()
  Log.prof("CustomProfiler:Start")
  self._profiler_run = true
  self._frame_count = 1
  self:ClearFrameData()
end

function CustomProfiler:Print()
  if self._profiler_run == false then
    Log.error("[AutoProfile] CustomProfiler not running")
    return
  end
  local framecount = self._profiler_data_list:Size()
  Log.prof("[AutoProfile] profile data list size=", framecount)
  for i = 1, framecount do
    local treeData = self._profiler_data_list:GetAt(i)
    self:PrintNodeData(treeData, i)
  end
end

function CustomProfiler:PrintNodeData(treeData, frameindex)
  local sorted_array = SortedArray:New(Algorithm.COMPARE_CUSTOM, PRecordInfo._LessComparer)
  sorted_array:AllowDuplicate()
  local node = treeData
  self:PrintInfo(node._info, frameindex)
  if node._child_node_list == nil then
    return
  end
  for _, childNode in pairs(node._child_node_list) do
    sorted_array:Insert(childNode)
  end
  local n = sorted_array:Size()
  for i = 1, n do
    local cnode = sorted_array:GetAt(i)
    self:PrintNodeData(cnode, frameindex)
  end
end

function CustomProfiler:PrintInfo(info, frameindex)
  if info.stackindex > 0 and info.use_tick >= 1 then
    Log.prof("[profiler] frame ", frameindex, " ", self._stack_space[info.stackindex], info.name, " use: ", info.use_tick)
  end
end

function CustomProfiler:StoreSamepleData()
  if self._profiler_run == false then
    return
  end
  self._profiler_data_list:PushBack(self._profiler_tree_head)
  self:ClearFrameData()
  self._frame_count = self._frame_count + 1
end

function CustomProfiler:Stop()
  self:Print()
  self:ClearFrameData()
  self._profiler_run = false
  self._profiler_data_list = ArrayList:New()
  Log.prof("CustomProfiler:Stop")
end

function CustomProfiler:NewNode(samplename)
  local info = PRecordInfo:New()
  info.name = samplename
  info.begin_tick = os.clock()
  info.stackindex = self._curStackIndex
  local node = ProfilerNode:New()
  node._info = info
  return node
end

function CustomProfiler:BeginSample(samplename)
  if self._profiler_run == false then
    return
  end
  if self._cur_node == nil then
    self._cur_node = self._profiler_tree_head
  end
  local node
  if self._cur_node._child_node_list ~= nil then
    node = self._cur_node._child_node_list[samplename]
  else
    self._cur_node._child_node_list = {}
  end
  if node == nil then
    node = self:NewNode(samplename)
    self._cur_node._child_node_list[samplename] = node
    node._parent_node = self._cur_node
  else
    node._info.begin_tick = os.clock()
  end
  self._cur_node = node
  self._curStackIndex = self._curStackIndex + 1
end

function CustomProfiler:EndSample()
  if self._profiler_run == false then
    return
  end
  local node = self._cur_node
  if node == nil then
    return
  end
  local curTick = os.clock()
  node._info.use_tick = node._info.use_tick + (curTick - node._info.begin_tick) * 1000
  self._cur_node = self._cur_node._parent_node
  if self._curStackIndex > 0 then
    self._curStackIndex = self._curStackIndex - 1
  end
end
