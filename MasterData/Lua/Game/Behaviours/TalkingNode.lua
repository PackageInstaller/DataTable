
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local cs_coroutine     = require "XLua.cs_coroutine"
---@type CriWareUtils
local CriWareUtils     =  import('Game.Entry.CriWareUtilsFix')
------------ import ------------


------------ define ------------
local isNull       = isNull
local checkNumber  = checkNumber
local strIsNull    = string.isEmpty
local yield_return = cs_coroutine.yield_return
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/TalkingNode.prefab
---@class TalkingNode
---@field Env                           	TalkingNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TalkingNode                   	UnityEngine.Canvas                      
---@field ScreenBtn                     	UnityEngine.RectTransform               
---@field Indicate                      	UnityEngine.RectTransform               
---@field TxtLeftName                   	UnityEngine.UI.Text                     
---@field Titles                        	UnityEngine.RectTransform               
---@field TxtContent                    	LetterTyperComp                         
---@field SkipButton                    	UnityEngine.RectTransform               
local TalkingNode = Class('TalkingNode')

function TalkingNode:__init()

end


function TalkingNode:__delete()

end


function TalkingNode:Awake()
    self.TxtContent:Init()
end


function TalkingNode:Start()
    SetButtonAction(self.ScreenBtn.gameObject,  Bind(self, self.OnClickScreenBtnAction))
    SetButtonAction(self.SkipButton.gameObject, Bind(self, self.OnClickSkipButtonAction))
end


function TalkingNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function TalkingNode:Init(eventName)
    self._eventName = eventName
end

function TalkingNode:FreshUI(talkData)
    KTool.SetActive(self.ScreenBtn.gameObject, true)

    local playerName = talkData.playerName
    local isShowName = not string.isEmpty(playerName)
    KTool.SetActive(self.Titles.gameObject, isShowName)
    if isShowName then
        self.TxtLeftName.text = talkData.playerName
    end

    if self._eventName then
        Events.Broadcast(self._eventName, talkData.id, talkData.action, talkData.face)
    end

    local txtContent = self.TxtContent
    txtContent:ResetArgs()
    txtContent:SetText("")
    txtContent.PendingTime     = 0.02
    txtContent.AppearDuration  = 0.2
    txtContent.IgnoreTimeScale = true
    txtContent.TextWillFill    = talkData.talkContent

    local voiceId = talkData.voiceId
    local modelGo = talkData.modelGo
    if not strIsNull(voiceId) then
        CriWareUtils.PlayVoiceById(voiceId, modelGo)
    end

    -- local action   = checkNumber(talkData.action)
    -- local faceId   = checkNumber(talkData.face)
    
    -- local modelAni = talkData.modelAni
    -- if action > 0 and not isNull(modelAni) then
    --     modelAni:SetInteger("talk", action)
    --     modelAni:SetInteger("emoji", faceId)
    -- end
    
    self._isCanPlayNext = false
    self:CloseWaitCo()
    self._waitCo = cs_coroutine.start(function()

        yield_return(txtContent:StartType())

        self._waitCo = nil
    end)

end

function TalkingNode:CloseWaitCo()
    if self:IsFinish() then return end

    cs_coroutine.stop(self._waitCo)
    self._waitCo = nil

end

function TalkingNode:IsFinish()
    return isNull(self._waitCo)
end

function TalkingNode:IsCanPlayNext()
    return self._isCanPlayNext
end

function TalkingNode:GetIsEnd()
    return self._isEnd
end
function TalkingNode:SetIsEnd(isEnd)
    self._isEnd = isEnd
end

function TalkingNode:Stop()
    local txtContent = self.TxtContent
    txtContent:StopType()
    txtContent:ShowAll()
    self:CloseWaitCo()

end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function TalkingNode:OnClickScreenBtnAction()
    if not self:IsFinish() then
        self:Stop()
        return
    end

    self._isCanPlayNext = true

end

function TalkingNode:OnClickSkipButtonAction()
    KTool.SetActive(self.ScreenBtn.gameObject, false)
    self:Stop()
    self:SetIsEnd(true)
    self._isCanPlayNext = false
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return TalkingNode
