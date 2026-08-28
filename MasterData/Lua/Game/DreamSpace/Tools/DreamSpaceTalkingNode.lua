
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local cs_coroutine     = require "XLua.cs_coroutine"
------------ import ------------


------------ define ------------
local isNull       = isNull
local checkNumber  = checkNumber
local strIsNull    = string.isEmpty
local yield_return = cs_coroutine.yield_return
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/DreamSpaceTalkingNode.prefab
---@class DreamSpaceTalkingNode
---@field Env                           	DreamSpaceTalkingNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TalkingNodeCanvas                 UnityEngine.Canvas                      
---@field ScreenBtn                     	UnityEngine.RectTransform               
---@field Indicate                      	UnityEngine.RectTransform               
---@field TxtLeftName                   	UnityEngine.UI.Text                     
---@field Titles                        	UnityEngine.RectTransform               
---@field TxtContent                    	LetterTyperComp                         
---@field SkipButton                    	UnityEngine.RectTransform               
local DreamSpaceTalkingNode = Class('DreamSpaceTalkingNode')
-- 外部调用时:
-- local DreamSpaceTalkingNode = import('Game.DreamSpace.Tools.DreamSpaceTalkingNode')


function DreamSpaceTalkingNode:__init()

end


function DreamSpaceTalkingNode:__delete()

end


function DreamSpaceTalkingNode:Awake()
    self.TxtContent:Init()
    assert( self.TalkingNodeCanvas and self.ScreenBtn and self.Indicate and self.TxtLeftName and self.Titles and self.TxtContent and self.SkipButton )
end


function DreamSpaceTalkingNode:Start()
    SetButtonAction(self.ScreenBtn.gameObject,  Bind(self, self.OnClickScreenBtnAction))
    SetButtonAction(self.SkipButton.gameObject, Bind(self, self.OnClickSkipButtonAction))
end


function DreamSpaceTalkingNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function DreamSpaceTalkingNode:Init(eventName)
    self._eventName = eventName
end


function DreamSpaceTalkingNode:Show()
    self.TalkingNodeCanvas.enabled = true
end 

function DreamSpaceTalkingNode:Hide()
    self.TalkingNodeCanvas.enabled = false
end 



-- 打印对白: 
function DreamSpaceTalkingNode:FreshUI(talkData)

    --print( "koko DreamSpaceTalkingNode:FreshUI" )

    KTool.SetActive(self.ScreenBtn.gameObject, true)

    local playerName = talkData.playerName
    local isShowName = not string.isEmpty(playerName)
    KTool.SetActive(self.Titles.gameObject, isShowName)
    if isShowName then
        self.TxtLeftName.text = talkData.playerName
    end

    -- if self._eventName then
    --     Events.Broadcast(self._eventName, talkData.id, talkData.action, talkData.face)
    -- end

    local txtContent = self.TxtContent
    txtContent:ResetArgs()
    txtContent:SetText("")
    txtContent.PendingTime     = 0.02 -- 0.02
    txtContent.AppearDuration  = 0.2 -- 0.2
    txtContent.IgnoreTimeScale = true
    txtContent.TextWillFill    = talkData.talkContent

    
    self._isCanPlayNext = false
    self:CloseWaitCo()
    self._waitCo = cs_coroutine.start(function()

        --print( "koko --9-- " )

        yield_return(txtContent:StartType())

        self._waitCo = nil
    end)

end



function DreamSpaceTalkingNode:CloseWaitCo()
    if self:IsFinish() then return end

    cs_coroutine.stop(self._waitCo)
    self._waitCo = nil
end

function DreamSpaceTalkingNode:IsFinish()
    return isNull(self._waitCo)
end

function DreamSpaceTalkingNode:IsCanPlayNext()
    return self._isCanPlayNext
end

function DreamSpaceTalkingNode:GetIsEnd()
    return self._isEnd
end
function DreamSpaceTalkingNode:SetIsEnd(isEnd)
    self._isEnd = isEnd
end

function DreamSpaceTalkingNode:Stop()
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

function DreamSpaceTalkingNode:OnClickScreenBtnAction()
    if not self:IsFinish() then
        self:Stop()
        return
    end

    self._isCanPlayNext = true

end

function DreamSpaceTalkingNode:OnClickSkipButtonAction()

    KTool.SetActive(self.ScreenBtn.gameObject, false)
    self:Stop()
    self:SetIsEnd(true)
    self._isCanPlayNext = false
    self._isEnd = true
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return DreamSpaceTalkingNode
