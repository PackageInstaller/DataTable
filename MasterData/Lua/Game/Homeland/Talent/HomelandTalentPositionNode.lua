
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type HomelandTalentConstants
local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")

--endregion

--region define

local TalentTypeAniName = {
    HomelandTalentConstants.AnimNames.BigNodeRed,
    HomelandTalentConstants.AnimNames.BigNodeGreen,
    HomelandTalentConstants.AnimNames.BigNodeBlue,
}

local NodeStatus2AnimName = {
    [HomelandTalentConstants.TalentNodeStatus.Lock]        = HomelandTalentConstants.AnimNames.BigNodeLock,
    [HomelandTalentConstants.TalentNodeStatus.SystemLock]  = HomelandTalentConstants.AnimNames.BigNodeLock,
    [HomelandTalentConstants.TalentNodeStatus.Max]         = HomelandTalentConstants.AnimNames.BigNodeMax,
    [HomelandTalentConstants.TalentNodeStatus.Active]      = HomelandTalentConstants.AnimNames.BigNodeActive,
    [HomelandTalentConstants.TalentNodeStatus.ActiveUnmet] = HomelandTalentConstants.AnimNames.BigNodeActiveUnmet,
}


local TalentTypeAniNameSmall = {
    HomelandTalentConstants.AnimNames.SmallNodeRed,
    HomelandTalentConstants.AnimNames.SmallNodeGreen,
    HomelandTalentConstants.AnimNames.SmallNodeBlue,
}

local NodeStatus2AnimNameSmall = {
    [HomelandTalentConstants.TalentNodeStatus.Lock]        = HomelandTalentConstants.AnimNames.SmallNodeLock,
    [HomelandTalentConstants.TalentNodeStatus.SystemLock]  = HomelandTalentConstants.AnimNames.SmallNodeLock,
    [HomelandTalentConstants.TalentNodeStatus.Max]         = HomelandTalentConstants.AnimNames.SmallNodeMax,
    [HomelandTalentConstants.TalentNodeStatus.Active]      = HomelandTalentConstants.AnimNames.SmallNodeActive,
    [HomelandTalentConstants.TalentNodeStatus.ActiveUnmet] = HomelandTalentConstants.AnimNames.SmallNodeActiveUnmet,
}
--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentPositionSmallNode.prefab > name: HomelandTalentPositionSmallNode
---@class HomelandTalentPositionNode
---@field Env                           	HomelandTalentPositionNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Lock                          	UnityEngine.RectTransform               	@ 0    
---@field LockImgBg2                    	UnityEngine.RectTransform               	@ 1    
---@field ImgLock                       	UnityEngine.RectTransform               	@ 2    
---@field Active                        	UnityEngine.RectTransform               	@ 3    
---@field ActiveImgBg2                  	UnityEngine.RectTransform               	@ 4    
---@field StatusNormal                  	UnityEngine.RectTransform               	@ 5    
---@field StatusNormalImgBg             	UnityEngine.RectTransform               	@ 6    
---@field StatusMax                     	UnityEngine.RectTransform               	@ 7    
---@field StatusMaxImgBg                	UnityEngine.RectTransform               	@ 8    
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 9    
---@field ImgIconSwitch                 	UnityEngine.RectTransform               	@ 10   
---@field Desc                          	UnityEngine.RectTransform               	@ 11   
---@field TextDesc                      	CustomText                              	@ 12   
---@field TextDescSwitch                	Game.Native.Common.UISwitchText         	@ 13   
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  	@ 14   
---@field ImgSelect                     	UnityEngine.RectTransform               	@ 15   
---@field Root                          	UnityEngine.Animation                   	@ 16   
---@field TalentType                    	UnityEngine.Animation                   	@ 17   
---@field UIFX_HomelandTalent_Upgrade   	UnityEngine.RectTransform               	@ 18   
---@field UIFX_HomelandTalent_Active    	UnityEngine.RectTransform               	@ 19   
local HomelandTalentPositionNode = Class('HomelandTalentPositionNode')

function HomelandTalentPositionNode:__init()

end


function HomelandTalentPositionNode:__delete()

end


-- function HomelandTalentPositionNode:Awake()
-- end


function HomelandTalentPositionNode:Start()
    self._start = true
    SetButtonAction(self.Root, Bind(self, self.OnClickBtnAction))

    if self._talentTypeCallback then
        self._talentTypeCallback()
    end

    if self._nodeStatueCallback then
        self._nodeStatueCallback()
    end
end


function HomelandTalentPositionNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param data { vo: HomelandTalentVo, status: HomelandTalentConstants.TalentNodeStatus, talentLV: number, maxLv: number }
---@param isBig     boolean 是否是大点
---@param labelType number 战略强化切页表 id
---@param position  number 列表下标
---@param dataIndex number 数据下标
function HomelandTalentPositionNode:FreshUI(data, isBig, labelType, position, dataIndex)
    self._data      = data
    self._isBig     = isBig
    self._position  = position
    self._dataIndex = dataIndex
    self:FreshTalentType(labelType)

    ---@type HomelandTalentConstants.TalentNodeStatus
    local status = data.status
    self:FreshNodeStatus(status)

    local textStatus = status <= HomelandTalentConstants.TalentNodeStatus.ActiveUnmet and status or (labelType + 2)
    ---@type HomelandTalentVo
    local vo           = data.vo
    self.TextDesc.text = vo.name
    self.TextDescSwitch.Status = textStatus

    self.TextNumber.text = string.format("%s/%s", data.talentLv, data.maxLv)
    self.TextDescSwitch.Status = textStatus

    -- local iconStatus = status <= HomelandTalentConstants.TalentNodeStatus.Lock and status or 1
    self.ImgIcon:LoadSprite(vo.icon)
    -- self.ImgIconSwitch.Status = iconStatus

end

function HomelandTalentPositionNode:FreshTalentType(labelType)
    local talentTypeCallback = function() 
        local AnimNames = self._isBig and TalentTypeAniName or TalentTypeAniNameSmall
        local aniName = AnimNames[labelType]
        if labelType == nil then
            
        end
        -- print("aniName", self._isBig, aniName, labelType, debug.traceback())
        self.TalentType:Play(aniName)
    end
    if self._start then
        talentTypeCallback()
    else
        self._talentTypeCallback = talentTypeCallback
    end
end

function HomelandTalentPositionNode:FreshNodeStatus(status)
    local nodeStatueCallback = function ()
        local AnimNames = self._isBig and NodeStatus2AnimName or NodeStatus2AnimNameSmall
        local aniName = AnimNames[status]
        if aniName then
            self.Root:Play(aniName)
        end
        
    end
    if self._start then
        nodeStatueCallback()
    else
        self._nodeStatueCallback = nodeStatueCallback
    end
end

function HomelandTalentPositionNode:OnDisable()
    local particleSystems = self._particleSystems
    if isNull(particleSystems) then
        return
    end
    CardProgressionUtils.EnabledParticleSystemsEmission(particleSystems, false)
end

function HomelandTalentPositionNode:PlayUpgradeEffect()
    local particleSystems = self._particleSystems
    if particleSystems == nil then
        local gameObject = self.UIFX_HomelandTalent_Upgrade.gameObject
        CfUtils.SetActive(gameObject, true)
        self._particleSystems = gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
    else
        CardProgressionUtils.EnabledParticleSystemsEmission(particleSystems, true)
    end
    
end

function HomelandTalentPositionNode:FreshSelectState(isSelect)
    CfUtils.SetActive(self.ImgSelect, isSelect)
end

--endregion 


--region get/set 
function HomelandTalentPositionNode:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function HomelandTalentPositionNode:OnClickBtnAction()
    if self._callback then
        self._callback(self._data, self._position, self._dataIndex, self)
    end
end

---endregion 


return HomelandTalentPositionNode
