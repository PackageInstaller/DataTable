--- 养成-档案界面-剧情cell

------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------
local NodeStatus = CardProgressionConstants.NodeStatus

local AnimationNameLockLoop = "CultivateOverseaIllustratedHandbook_LockLoop"
local AnimationNameUnlock = "CultivateOverseaIllustratedHandbook_UnLock"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIllustratedHandbookAndFetter.prefab
---@class CardProgressionIllustratedStoryCell
---@field Env                           	CardProgressionIllustratedStoryCell     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Cell                          	UnityEngine.Animation                   
---@field redPoint                      	UnityEngine.RectTransform               
---@field TxtName                       	TMPro.TextMeshProUGUI                   
---@field ImgLock                       	UnityEngine.RectTransform               
---@field New                           	UnityEngine.RectTransform               
---@field Background                    	Game.Native.Common.UISwitchImage        
---@field AnimRoot                      	UnityEngine.RectTransform               
local CardProgressionIllustratedStoryCell = Class('CardProgressionIllustratedStoryCell')

function CardProgressionIllustratedStoryCell:__init()
    self._isInitialize = false
end

function CardProgressionIllustratedStoryCell:__delete()

end

function CardProgressionIllustratedStoryCell:Awake()
    KTool.SetActive(self.ImgLock.gameObject, true)
end

function CardProgressionIllustratedStoryCell:Start()
    SetButtonAction(self.AnimRoot.gameObject, Bind(self, self.OnClickBtnAction))
end

function CardProgressionIllustratedStoryCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionIllustratedStoryCell:FreshUI(storyData, index)
    self._storyData = storyData
    -- self._desc = desc
    self._index = index
    
    local status =  storyData.status
    local isUnlock = NodeStatus.Unlock == status
    
    KTool.SetActive(self.TxtName.gameObject, isUnlock)

    GameUtils.UpdateUIShowState(self.ImgLock.gameObject, not isUnlock)
    -- if isUnlock then
        self.TxtName.text = string.format("<size=30>#</size>%s", index)
    -- end

    local isCanUnlock = status == NodeStatus.CanUnlock
    self:FreshRedPoint(isCanUnlock)
    if isCanUnlock then
        self:PlayAnimationLockLoop()
    else
        self.Cell.enabled = false
        -- self.Cell:Stop()
    end
    
end

function CardProgressionIllustratedStoryCell:FreshRedPoint(isShowRedPoint)
    local redPointGo = GameUtils.GetRedPointGo(self.controller.gameObject)
    if isNotNull(redPointGo) then
        KTool.SetActive(redPointGo, isShowRedPoint == true)
    end
end

function CardProgressionIllustratedStoryCell:FreshSelectState(isSelect)
    self.Background.Status = isSelect and 1 or 2
end

function CardProgressionIllustratedStoryCell:PlayAnimationLockLoop()
    self.Cell.enabled = true
    self.Cell:Play(AnimationNameLockLoop)
end

function CardProgressionIllustratedStoryCell:PlayAnimationUnlock()
    self.Cell.enabled = true
    GameUtils.PlayAndWaitForAnim(self.Cell.gameObject, AnimationNameUnlock, function() 
        KTool.SetActive(self.TxtName.gameObject, true)
        self.Cell.enabled = false
    end, "CardProgressionIllustratedStoryCell.PlayAnimationUnlock")
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionIllustratedStoryCell:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionIllustratedStoryCell:OnClickBtnAction(callback)
    if self._callback then
        self._callback(self._storyData, self._index)
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionIllustratedStoryCell
