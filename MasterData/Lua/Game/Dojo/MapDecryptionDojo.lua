---@class MapDecryptionDojo
local MapDecryptionDojo = Class('MapDecryptionDojo')

local checkNumber = checkNumber

local FixMap = function(map)
    local t = {}
    for key, value in pairs(map) do
        t[checkNumber(key)] = value
    end
    return t
end

function MapDecryptionDojo:__init()

    self.redPacketId = 0 --- 当天红包id
    self.redPacketReceiveStatus = 0 --- 红包领取状态 1 已领取 0 未领取
    self.nowPoolId = 0 --- 当前的转盘id
    self.allRotaryTableNumInfo = {
        -- [poolId] = { --- 转盘id
        --      [rewardId] = { --- 奖励id
        --              num  --- 已抽取的数量
        --              pos  --- 奖励位置
        --      }       
        -- }
    } --- 所有转盘信息
    self.maps = { --- 地图信息
        --- [id] = {
        ---     id = 0,              ---解密地图表id 
        ---     unlockDay = 0,       ---解密地图表解锁时间
        ---     unlockTimeLeft = 0,  ---地图剩余解锁时间
        ---     rewards = {},        ---奖励
        ---     isUnlock = 0,        ---地图是否解锁
        ---     status = 0,          ---地图总奖励领取状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
        ---     tasks  = {
        ---          id = 0,         ---任务id
        ---          status = 0,     ---任务领取状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
        ---          progress = 0,   ---任务进度
        ---          desc = "",       ---任务描述
        ---          rewards = {},   ---奖励信息
        ---          taskType = 0,   ---任务类型
        ---          targetId = 0,   ---任务参数id
        ---          targetNum = 0,  ---任务数量
        ---     }
        --- },
    }

    self.trackingQuests = { ---追踪关卡信息
        --- [id] = {
        --      id = 0,             追踪关卡表id
        --      star = {},           追踪关卡通关星级
        --      isUnlock = 0        是否解锁
        -- }
    }

    self.antiques = {    --- 古物信息
        --- [id] = { --- 古物修复表id 
        --      0,   --- 是否修复
        --      status = 0    --- 古物状态 0:未获得 1:未修复 2:已修复
        -- }
    }

    self.talk = { --- 闲聊配置表 key 闲聊id
        --- [id] = {
        --      people = 0,  --- 角色id 
        --      talkId = 0,  --- 闲聊id
        --      time = 0,    --- 解锁时间
        -- }
    }

    self.isFirst = 0
    self.mapPassedInfo = {} --- key 地图id value 通关的最新章节
    self.playerMapDecryption = { --- 地图迷宫信息
        -- isFirst 
        -- currentGroupId -- 若为空, 则要调用后端的 enterMap() 函数
    } 

    -- 最开始 playerMapQuestInfo 是一个空的 {}
    self.playerMapQuestInfo = {
        -- eventInfo   -- list<string>
        -- puzzleData  -- string
    }

    self.redPacketTips = -1
    ---------------------------------------
    --- local data
    self.isActivityEnd   = false
    self.isActivityClose = false

    self.starInfo = {}
end

function MapDecryptionDojo:__delete()

end

---Fill
---填充数据
---@param jsonData table
function MapDecryptionDojo:Fill(jsonData)
    for key, value in pairs(jsonData) do
        --只更新自己关心的数据
        if isSet(jsonData,key) and table.haskey(self, key) then
            self[key] = value
        end
    end

    self.maps           = FixMap(self.maps)
    self.trackingQuests = FixMap(self.trackingQuests)
    self.talk           = FixMap(self.talk)
    self.antiques       = FixMap(self.antiques)
    self.mapPassedInfo  = FixMap(self.mapPassedInfo)


    -- 可以直接访问 self.playerMapDecryption 下的各种数据, 比如: self.playerMapDecryption.isFirst

    for questId, v in pairs(self.trackingQuests) do
        local _, conditions = QuestConfMgr:GetInstance():GetQuestConditions(questId)
        if conditions then
            local _t = {}
            local count = 0
            local starValues = table.values(v.star)
            for m, cdt in pairs(conditions) do
                count = count + 1
                _t[checkString(cdt.id)] = (table.keyof(starValues, count) and 1 or 0) 
            end
            self.starInfo[tostring(questId)] = _t
        end


    end
    -- print("MapDecryptionDojo", table.toString(self.starInfo))

    local seconds = os.time()
    for k, v in pairs(self.maps) do
        -- v.unlockTimeLeft = checkNumber(v.unlockTimeLeft)
        v.unlockDay = seconds + v.unlockTimeLeft
    end

    return self
end


return MapDecryptionDojo
