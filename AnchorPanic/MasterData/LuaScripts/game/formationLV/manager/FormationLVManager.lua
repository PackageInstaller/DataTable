--[[ 
-----------------------------------------------------
@filename       : FormationLVManager
@Description    : 锚驴
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module("formationLV.FormationLVManager", Class.impl(Manager))

--构造函数
function ctor(self)
	super.ctor(self)
	self:__initData()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__initData()
end

function __initData(self)
    --服务器驴信息
	self.mLVVoDic = {}
    --配置表驴信息
    self.mConfigLVDic = {}
end

-- 解析服务器驴消息
function praseMsg(self, msg)
	self.mLVVoDic = {}
    self.mLVVoDic = msg.pet_id_list
end

function praseConfig(self)
	self.mConfigLVDic = {}
    local baseData = RefMgr:getData("pet_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(formationLV.FormationLVVo)
		vo:parseData(id, data)
		self.mConfigLVDic[id] = vo
    end
end

function unlockPet(self, petId)
    table.insert(self.mLVVoDic, petId)
end

function getAllIUnlockLV(self)
    return self.mLVVoDic
end

function getAllLVConfigVo(self)
    if self.mConfigLVDic ~= {} then 
        self:praseConfig()
    end
    return self.mConfigLVDic
end

function getLVConfigVo(self, id)
    return self:getAllLVConfigVo()[id]
end

function getIsUnlock(self, id)
    return table.indexof(self.mLVVoDic, id)
end

function getHasRed(self)
    for k,v in pairs(self:getAllLVConfigVo()) do
        local unlock = self:getIsUnlock(v.mId)
        local stageUnlock = v.mStage == 0 and true or battleMap.MainMapManager:isStagePass(v.mStage)
        if(not unlock and v.mLevel <= role.RoleManager:getRoleVo():getPlayerLvl() and stageUnlock) then 
            return true
        end
    end
    return false
end

--析构函数
function dtor(self)
end

return _M