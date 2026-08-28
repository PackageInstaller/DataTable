--
-- Author:luqucheng
-- Date: 2019-11-07 11:09:35
--
---@class RecordMgr
local RecordMgr = {}
local Tree = import('Game.Utils.Tree')
local TreeNode = import('Game.Utils.TreeNode')

RecordMgr.index = nil

RecordMgr.recTree = nil--整个录像树
RecordMgr.nodeStack = nil--当前压入栈的节点们

RecordMgr.SkillRecord = import('Game.Battle.Record.SkillRecord')
RecordMgr.AddBuffRecord = import('Game.Battle.Record.AddBuffRecord')
RecordMgr.DamageRecord = import('Game.Battle.Record.DamageRecord')
RecordMgr.RemoveBuffRecord = import('Game.Battle.Record.RemoveBuffRecord')
RecordMgr.SkillEffectRecord = import('Game.Battle.Record.SkillEffectRecord')
RecordMgr.TriggerRecord = import('Game.Battle.Record.TriggerRecord')
RecordMgr.ActionRecord = import('Game.Battle.Record.ActionRecord')
RecordMgr.TurnEndRecord = import('Game.Battle.Record.TurnEndRecord')
RecordMgr.TurnStartRecord = import('Game.Battle.Record.TurnStartRecord')
RecordMgr.UnitSkillCardRecord = import('Game.Battle.Record.UnitSkillCardRecord')
RecordMgr.PushSkillCardRecord = import('Game.Battle.Record.PushSkillCardRecord')
RecordMgr.PushCatSkillCardRecord = import('Game.Battle.Record.PushCatSkillCardRecord')
RecordMgr.MoveSkillCardRecord = import('Game.Battle.Record.MoveSkillCardRecord')
RecordMgr.UseSkillCardRecord = import('Game.Battle.Record.UseSkillCardRecord')
RecordMgr.InitRecord = import('Game.Battle.Record.InitRecord')
RecordMgr.RemoveSkillCardRecord = import('Game.Battle.Record.RemoveSkillCardRecord')
RecordMgr.RequireInputRecord = import('Game.Battle.Record.RequireInputRecord')
RecordMgr.GameEndRecord = import('Game.Battle.Record.GameEndRecord')
RecordMgr.TagRecord = import('Game.Battle.Record.TagRecord')
RecordMgr.ChangeBuffRecord = import('Game.Battle.Record.ChangeBuffRecord')
RecordMgr.SyncSkillCardRecord = import('Game.Battle.Record.SyncSkillCardRecord')
RecordMgr.AIChooseSkillRecord = import('Game.Battle.Record.AIChooseSkillRecord')
RecordMgr.UltraPointChangeRecord = import('Game.Battle.Record.UltraPointChangeRecord')
RecordMgr.ChangeSkillCardRecord = import('Game.Battle.Record.ChangeSkillCardRecord')
RecordMgr.ChangeWaveRecord = import('Game.Battle.Record.ChangeWaveRecord')
RecordMgr.ChangeShieldRecord = import('Game.Battle.Record.ChangeShieldRecord')
RecordMgr.ElementBreakRecord = import('Game.Battle.Record.ElementBreakRecord')
RecordMgr.WeakExposeRecord = import('Game.Battle.Record.WeakExposeRecord')
RecordMgr.WeakRecord = import('Game.Battle.Record.WeakRecord')
RecordMgr.CreateRoleRecord = import('Game.Battle.Record.CreateRoleRecord')
RecordMgr.CreateSkillCatRecord = import('Game.Battle.Record.CreateSkillCatRecord')
RecordMgr.SyncRoleDataRecord = import('Game.Battle.Record.SyncRoleDataRecord')
RecordMgr.InputFinishedRecord = import('Game.Battle.Record.InputFinishedRecord')
RecordMgr.SyncRoleStatusRecord = import('Game.Battle.Record.SyncRoleStatusRecord')
RecordMgr.ChangeElementRecord = import('Game.Battle.Record.ChangeElementRecord')
RecordMgr.ChangeWaveEndRecord = import('Game.Battle.Record.ChangeWaveEndRecord')
RecordMgr.ChangeMergeSkillRecord = import('Game.Battle.Record.ChangeMergeSkillRecord')
RecordMgr.ConditionUpdateRecord = import('Game.Battle.Record.ConditionUpdateRecord')
RecordMgr.RoleDeadRecord = import('Game.Battle.Record.RoleDeadRecord')
RecordMgr.ChangeMaxHpRecord = import('Game.Battle.Record.ChangeMaxHpRecord')
RecordMgr.RoleExitRecord = import('Game.Battle.Record.RoleExitRecord')
RecordMgr.PlayerInputRecord = import('Game.Battle.Record.PlayerInputRecord')
RecordMgr.ChangeSkillCardQueueRecord = import('Game.Battle.Record.ChangeSkillCardQueueRecord')
RecordMgr.SkillFailedRecord = import('Game.Battle.Record.SkillFailedRecord')
RecordMgr.RoleRemoveRecord = import('Game.Battle.Record.RoleRemoveRecord')
RecordMgr.UltraPointMaxChangeRecord = import('Game.Battle.Record.UltraPointMaxChangeRecord')
RecordMgr.SPTypeChangeRecord = import('Game.Battle.Record.SPTypeChangeRecord')
RecordMgr.RegisterValueChangeRecord = import('Game.Battle.Record.RegisterValueChangeRecord')




function RecordMgr:AddRecordStart( rec )
    local node = TreeNode.New(rec:ToData())
    self:GetNowNode():AddChild(node)
    table.insert( self.nodeStack, node )
    return node
end

function RecordMgr:ResetNodeData( node, data )
    node.data = data
    return node
end

function RecordMgr:AddRecord( rec )
    if not rec then
        return
    end
    return self:AddRecordData(rec:ToData())
end

function RecordMgr:AddTagRecordStart( recordType )
    self:AddRecordStart(self.TagRecord.New(recordType))
end

--- 记录结算战报
--- 如果buff触发树过程中如果触发gameover，触发树还未构建完成，GameEndRecord会写到触发树的子节点中，这时候如果GetRecordString，因为不会遍历子节点，会导致结算战报丢失
--- 使用这个函数保存结算战报，保证结算战报可以写入到树的最外层
function RecordMgr:AddGameEndRecord( rec )
    if not rec then
        return
    end
    local recData = rec:ToData()
    local node = TreeNode.New(recData)
    self.recTree.root:AddChild(node)
    return node
end

function RecordMgr:AddRecords( recs )
    for i,v in ipairs(recs) do
        self:AddRecord(v)
    end
end

function RecordMgr:AddRecordDatas( recDatas )
    for i,v in ipairs(recDatas) do
        self:AddRecordData(v)
    end
end

function RecordMgr:AddRecordData( recData )
    -- print("[流程] add record:", Constants.RecordTypeName[recData.r])
    local node = TreeNode.New(recData)
    self:GetNowNode():AddChild(node)
    return node
end

function RecordMgr:AddRecordEnd(  )
    self:GetNodeData(self:GetNowNode())
    table.remove( self.nodeStack )
end

function RecordMgr:GetNowNode(  )
    if #self.nodeStack > 0 then
        return self.nodeStack[#self.nodeStack]
    end

    return self.recTree.root
end

function RecordMgr:GetFlatRecordData()
    local len = #self.recTree.root.children
    local data = {}
    for i=1,len do
        local child = self.recTree.root.children[i]
        -- child.data.name = table.getKey(Constants.RecordType, child.data.recordType)
        table.insert(data, child.data)
    end

    return data
end

function RecordMgr:GetData(  )
    -- self.recTree.root:ToData()
    --最外层不做折叠，直接数组拜访
    local d = self.recTree.root.data
    local len = #self.recTree.root.children
    local data = {}
    for i=self.index,len do
        local child = self.recTree.root.children[i]
        -- child.data.name = table.getKey(Constants.RecordType, child.data.recordType)
        table.insert( data, DeepCopy(child.data)  )
    end
    -- Tools.writefile("record.txt", table.serialize(self.recTree.root.data))
    self.index = len + 1


    return data
    --遍历树做数据重组
    --技能相关的数据放在技能内
end

function RecordMgr:GetLastRoundData(  )
    -- self.recTree.root:ToData()
    --最外层不做折叠，直接数组拜访
    local d = self.recTree.root.data
    local len = #self.recTree.root.children
    local data = {}

    local startIndex = 1
    for i,v in fipairs(self.recTree.root.children) do
        local child = self.recTree.root.children[i]
        if child.data.r == Constants.RecordType.TurnStart and child.data.c == Constants.Camp.One then
            startIndex = i
            break
        end
    end

    for i=startIndex,len do
        local child = self.recTree.root.children[i]
        -- child.data.name = table.getKey(Constants.RecordType, child.data.recordType)
        table.insert(data, DeepCopy(child.data))
    end
    return data
end

function RecordMgr:DropAll(  )
    self.index = #self.recTree.root.children + 1
end

function RecordMgr:SaveRecord(  )
    local File = CS.System.IO.File
    local Directory = CS.System.IO.Directory
    local path = CS.UnityEngine.Application.persistentDataPath .. "/Record/"
    local recordName = os.date("%Y-%m-%d %H-%M-%S",os.time())
    local fullPath = path .. recordName
    print("[SaveRecord]:".. fullPath)

    if not Directory.Exists(path) then
        Directory.CreateDirectory(path)
    end

    if not File.Exists(fullPath) then
        local fs = File.Create(fullPath);
        fs:Close();
        fs = nil
    end
   
    CS.System.IO.File.WriteAllText(fullPath, self:GetRecordString());
end

function RecordMgr:GetRecordString(  )
    local ind = self.index
    self.index = 1
    local data = {}
    data.initData = BattleMgr.initData
    data.recordData = self:GetData()
    local s = table.serialize(data)
    self.index = ind
    return s
end

function RecordMgr:GetNodeData( node )

    local data = node.data
    local damages = {}
    local addBuffs = {}
    local removeBuffs = {}
    local effects = {}
    local skills = {}

    --只处理叶子子节点
    local switch = {
        -- [Constants.RecordType.Trigger] = function (n)
        --     for k,v in pairs(Constants.TriggerMainType) do
        --         if v == n.data.t then
        --             data[k] = n.data
        --             -- printInfo(table.toString(n.data,"~~~~~~~~~~~~~~~~~~~~~~~~~node"))
        --         end
        --     end
        -- end,
    }

    for i,child in ipairs(node.children) do
        local recordType = child.data.r
        if #child.children <= 0 and (recordType == Constants.RecordType.Skill 
        -- or recordType == Constants.RecordType.Effect 
        or recordType == Constants.RecordType.Trigger)  then
            --复合类型没有子数据，直接不加入
        else
            local func = switch[child.data.r]
            if func then
                func(child)
            else
                --默认的数据录入方式
                --把对应key的数据塞到一个以key为命名的数组中
                -- local key = table.getKey(Constants.RecordType, child.data.r)
                local key = 'subs'
                local v = data[key]
                if not v then
                    data[key] = {}
                    v = data[key]
                end
                table.insert( v, child.data )
            end
        end

    end

    -- node.data.skills = #skills > 0 and skills or nil
    -- node.data.effects = #effects > 0 and effects or nil
    -- node.data.damages = #damages > 0 and damages or nil
    -- node.data.addBuffs = #addBuffs > 0 and addBuffs or nil
    -- node.data.removeBuffs = #removeBuffs > 0 and removeBuffs or nil
end

function RecordMgr:GetLastRecordData()
    local num = #self.recTree.root.children
    return self.recTree.root.children[num].data
end


function RecordMgr:Clear(  )
    self.recTree = Tree.New( TreeNode.New({}) )
    self.nodeStack = {}
    self.index = 1
end

return  RecordMgr