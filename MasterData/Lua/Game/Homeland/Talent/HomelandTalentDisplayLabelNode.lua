
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

local CELL_ANIM_NAME = {
    HIDE = 'HomelandTalentDisplayDialog_LabeINode_Hide',
    IDLE = 'HomelandTalentDisplayDialog_LabeINode_Idle',
    SHOW = 'HomelandTalentDisplayDialog_LabeINode_Entry',
    WAIT = 'HomelandTalentDisplayDialog_LabeINode_Wait',
}

--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentDisplayDialog.prefab > name: LabelNode
---@class HomelandTalentDisplayLabelNode
---@field Env                           	HomelandTalentDisplayLabelNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LabelNode                     	UnityEngine.Animation                   	@ 0    
---@field BtnNode                       	UnityEngine.RectTransform               	@ 1    
---@field Select                        	UnityEngine.Animation                   	@ 2    
---@field ImgIconLock                   	Engine.UI.ImageAlterable                	@ 3    
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 4    
---@field TextDescSwitch                	Game.Native.Common.UISwitchText         	@ 5    
---@field TextDesc                      	CustomText                              	@ 6    
---@field redPoint                      	UnityEngine.RectTransform               	@ 7    
local HomelandTalentDisplayLabelNode = Class('HomelandTalentDisplayLabelNode')

function HomelandTalentDisplayLabelNode:__init()

end


function HomelandTalentDisplayLabelNode:__delete()

end


function HomelandTalentDisplayLabelNode:Awake()
    self:PlayAnimByHide()
end


function HomelandTalentDisplayLabelNode:Start()
    self._isStart = true
    if self._aniCb then
        self._aniCb()
        self._aniCb = nil
    end
    SetButtonAction(self.BtnNode, Bind(self, self.OnClickButtonAction))
end


function HomelandTalentDisplayLabelNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param labelVo HomelandTalentLabelVo 标签数据
---@param labelType number 标签类型
---@param pos number cell在列表的数据下标
function HomelandTalentDisplayLabelNode:FreshUI(labelVo, labelType, pos)
    self._pos = pos
    self._labelVo = labelVo

    local isUnlock = GameUtils.IsUnlockedSingle(labelVo.unlockId, labelVo.unlockNum)
    self._isUnlock = isUnlock
    CfUtils.SetActive(self.ImgIconLock, not isUnlock)
    CfUtils.SetActive(self.ImgIcon, isUnlock)
    local ImgIcon = isUnlock and self.ImgIcon or self.ImgIconLock
    if labelVo.icon then
        ImgIcon:LoadSprite(labelVo.icon)
    end

    self.TextDesc.text = labelVo.name

end

function HomelandTalentDisplayLabelNode:FreshSelectState(isSelect)
    CfUtils.SetActive(self.Select, isSelect)
end

function HomelandTalentDisplayLabelNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.LabelNode.gameObject, CELL_ANIM_NAME.HIDE)
end


function HomelandTalentDisplayLabelNode:PlayAnimByIdle()
    if not self._isStart then
        self._aniCb = function() 
            CfUtils.PlayAnimation(self.LabelNode.gameObject, CELL_ANIM_NAME.IDLE)
        end
        return
    end
    self._aniCb = nil
    CfUtils.PlayAnimation(self.LabelNode.gameObject, CELL_ANIM_NAME.IDLE)
end


function HomelandTalentDisplayLabelNode:PlayDelayAnimByShow(delayIndex)
    if not self._isStart then
        self._aniCb = function ()
            CfUtils.PlayDelayShowAnimation(self.LabelNode.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
        end
        return
    end
    self._aniCb = nil
    CfUtils.PlayDelayShowAnimation(self.LabelNode.gameObject, delayIndex, CELL_ANIM_NAME.SHOW, CELL_ANIM_NAME.WAIT)
end

--endregion 


--region get/set 

function HomelandTalentDisplayLabelNode:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function HomelandTalentDisplayLabelNode:OnClickButtonAction()
    if not self._isUnlock then
        local labelVo = self._labelVo
        local desc = GameUtils.GetUnlockDescr(labelVo.unlockId, labelVo.unlockNum)
        GameUtils.Toast(desc)
        return
    end
    if self._callback then
        local res = self._callback(self._pos)
        if res then
            self:FreshSelectState(true)
        end
    end
end

---endregion 


return HomelandTalentDisplayLabelNode
