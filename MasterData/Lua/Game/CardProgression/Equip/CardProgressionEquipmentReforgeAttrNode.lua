
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local cardConfMgr = CardConfMgr:GetInstance()
--endregion

--region define
local SetActive = CfUtils.SetActive

local AttrNodeAniName = {
    UNLOCK = "CultivateOverseaEquipmentReforgeDialog_Unlock",
    LOCKING = "CultivateOverseaEquipmentReforgeDialog_Locking",
    UNLOCK_DEFAULT = "CultivateOverseaEquipmentReforgeDialog_UnlockDefault",
    LOCKING_DEFAULT = "CultivateOverseaEquipmentReforgeDialog_LockingDefault",
}

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEquipmentReforgeDialog.prefab > name: SubAttrNode1
---@class CardProgressionEquipmentReforgeAttrNode
---@field Env                           	CardProgressionEquipmentReforgeAttrNode 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBaseBg                     	Game.Native.Common.UISwitchImage        	@ 0    
---@field Slider                        	UnityEngine.UI.Slider                   	@ 1    
---@field ImgBgRare                     	UnityEngine.UI.Extensions.Gradient2     	@ 2    
---@field ImgPointRare                  	Game.Native.Common.UISwitchImage        	@ 3    
---@field AttrNumText                   	TMPro.TextMeshProUGUI                   	@ 4    
---@field AttrNameText                  	UnityEngine.UI.Text                     	@ 5    
---@field LockNode                      	UnityEngine.RectTransform               	@ 6    
---@field LockNodeTxtState              	UnityEngine.UI.Text                     	@ 7    
---@field ButtonSelect                  	UnityEngine.RectTransform               	@ 8    
---@field ButtonSelectLock              	UnityEngine.RectTransform               	@ 9    
---@field ButtonSelectUnlock            	UnityEngine.RectTransform               	@ 10   
---@field LayoutRadius                  	UnityEngine.RectTransform               	@ 11   
---@field TxtRadius                     	UnityEngine.UI.Text                     	@ 12   
---@field MaxGroup                      	UnityEngine.RectTransform               	@ 13   
---@field UIFX_RefreshGlow              	UnityEngine.RectTransform               	@ 14   
---@field AnimComp                      	UnityEngine.Animation                   	@ 15   
---@field AttrNodeAnimComp              	UnityEngine.Animation                   	@ 16   
local CardProgressionEquipmentReforgeAttrNode = Class('CardProgressionEquipmentReforgeAttrNode')

function CardProgressionEquipmentReforgeAttrNode:__init()
    self._isLock = false
    self._isUnlockAttr = nil
end


function CardProgressionEquipmentReforgeAttrNode:__delete()

end


function CardProgressionEquipmentReforgeAttrNode:Awake()
    self:RefreshEffectShowState(false)
end


function CardProgressionEquipmentReforgeAttrNode:Start()
    SetButtonAction(self.ButtonSelect, function (event)
        if not self._handlerCheckIsCanLock(self._index) then
            GameUtils.Toast(localize("每次只能锁定一条属性"))
            return
        end
        self._isLock = not self._isLock
        self:RefreshLockState()
        if self._handlerOnChangeLock then
            self._handlerOnChangeLock(self._attr, self._index, self._isLock)
        end
        
    end)
end


function CardProgressionEquipmentReforgeAttrNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 

function CardProgressionEquipmentReforgeAttrNode:Init(_handlerOnChangeLock, handlerCheckIsCanLock)
    if self.isInit then
        return false
    end
    self.isInit = true
    self._handlerOnChangeLock = _handlerOnChangeLock
    self._handlerCheckIsCanLock = handlerCheckIsCanLock

    return true
end

--endregion 


--region logic 

---@param attr LadderRiseAttr
---@param index number
function CardProgressionEquipmentReforgeAttrNode:RefreshUI(attr, index, isFirst, equipDojo)
    self._attr = attr
    self._index = index

    self.Slider.value = attr.attrProgress

    local attrId = attr.attrId
    local attrVo = cardConfMgr:GetBasicAttrAdditionById(attrId)
    self.AttrNameText.text = attrVo.attrAdditionName

    local isUnlock = attr.isUnlock
    SetActive(self.AttrNumText, isUnlock)
    SetActive(self.ImgBgRare, isUnlock)
    SetActive(self.ImgPointRare, isUnlock)
    SetActive(self.LockNode, not isUnlock)
    SetActive(self.LayoutRadius, isUnlock)

    local num1 = attribute_format(attrVo.isConversion, attr.min)
    local num2 = attribute_format(attrVo.isConversion, attr.max)
    self.TxtRadius.text = localize("重铸范围 _num1_-_num2_", {_num1_ = num1, _num2_ = num2})

    if isUnlock then
        local quality = attr.quality
        EquipUtils.SwitchSubAttrColorByQuality(self.ImgBgRare, quality)
        self.ImgPointRare.Status = quality

        local attrNum = attr.num
        self.AttrNumText.text = attribute_format(attrVo.isConversion, attrNum)

        SetActive(self.MaxGroup, attr.num >= attr.max)


    else
        self.LockNodeTxtState.text = EquipUtils.GetUnlockAttrText(attr.unlockLimitId, equipDojo)
    end

    -- self:RefreshLockState()

    if isFirst then
        self.AttrNodeAnimComp:Play(AttrNodeAniName.UNLOCK_DEFAULT)
    end

    -- self._isUnlockAttr = isUnlock
end

function CardProgressionEquipmentReforgeAttrNode:RefreshLockState()
    self.AttrNodeAnimComp:Play(self._isLock and AttrNodeAniName.LOCKING or AttrNodeAniName.UNLOCK)
    -- SetActive(self.ButtonSelectLock, self._isLock)
    -- SetActive(self.ButtonSelectUnlock, not self._isLock)
end

function CardProgressionEquipmentReforgeAttrNode:PlayRestAni(lockIndex)
    if lockIndex == self._index or not self._attr.isUnlock then
        return
    end
    self:RefreshEffectShowState(true)
    self.AnimComp:Play("CultivateOverseaEquipmentClearDialogReset")
end

function CardProgressionEquipmentReforgeAttrNode:RefreshEffectShowState(isShowEffect)
    SetActive(self.UIFX_RefreshGlow, isShowEffect)
end




--endregion 


--region get/set 




---endregion 


--region handler 


---endregion 


return CardProgressionEquipmentReforgeAttrNode
