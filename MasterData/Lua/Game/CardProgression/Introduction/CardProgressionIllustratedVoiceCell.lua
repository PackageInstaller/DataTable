--- 养成-档案界面-音频cell

------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type UnityEngine.Animator
local Animator         = CS.UnityEngine.Animator
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------
local VoiceStatus = CardProgressionConstants.VoiceStatus
local PlayHash    = Animator.StringToHash("ArmedVoicePlay")
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIllustratedHandbookAndFetter.prefab
---@class CardProgressionIllustratedVoiceCell
---@field Env                           	CardProgressionIllustratedVoiceCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtContentLock                	UnityEngine.UI.Text                     
---@field Lock                          	UnityEngine.RectTransform               
---@field SliderBar                     	UnityEngine.UI.Slider                   
---@field TxtContent                    	UnityEngine.UI.Text                     
---@field ButOn                         	UnityEngine.RectTransform               
---@field ButPlay                       	UnityEngine.Animator                    
---@field Unlock                        	UnityEngine.RectTransform               
---@field BtnVoice                      	UnityEngine.CanvasGroup                 
local CardProgressionIllustratedVoiceCell = Class('CardProgressionIllustratedVoiceCell')

function CardProgressionIllustratedVoiceCell:__init()
    self._isInitialize = false
end

function CardProgressionIllustratedVoiceCell:__delete()

end

function CardProgressionIllustratedVoiceCell:Awake()
end

function CardProgressionIllustratedVoiceCell:Start()
    SetButtonAction(self.BtnVoice, Bind(self, self.OnClickBtnVoiceAction))
end

function CardProgressionIllustratedVoiceCell:OnDestroy()
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

function CardProgressionIllustratedVoiceCell:FreshUI(voiceData)
    self._voiceData = voiceData
    ---@type RoleVoiceVo
    local voiceVo = voiceData.v
    local status = voiceData.status
    local isLock = status == VoiceStatus.Lock
    KTool.SetActive(self.Lock.gameObject, isLock)
    KTool.SetActive(self.Unlock.gameObject, not isLock)
    
    local TxtContent = isLock and self.TxtContentLock or self.TxtContent
    TxtContent.text = voiceVo.name
    self.BtnVoice.alpha = isLock and 0.6 or 1
    self:FreshStatus(status)
end


function CardProgressionIllustratedVoiceCell:FreshStatus(status, progress)
    local isPlay = status == VoiceStatus.Play
    KTool.SetActive(self.ButOn,     isPlay)
    KTool.SetActive(self.SliderBar, isPlay)
    if isPlay and progress then
        -- self.ButPlay:Rebind()
        -- self.ButPlay:Play(PlayHash)
        self:FreshProgress(progress)
    end
end

function CardProgressionIllustratedVoiceCell:FreshProgress(progress)
    self.SliderBar.value = progress
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

---SetCallBack
---设置单击回调函数
function CardProgressionIllustratedVoiceCell:SetCallback(cb)
    self._callback = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionIllustratedVoiceCell:OnClickBtnVoiceAction()
    if self._callback then
        self._callback(self._voiceData)
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionIllustratedVoiceCell
