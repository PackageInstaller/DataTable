local WU, DB, REF = require("Common/WindowUtil")(this)
local OpenGroup = 111
local CloseGroup = 112
local DontMatchGroup = 113
local MatchedGroup = 114

function Awake()
  local function AddEvent(go, targetGroup, callbackEvent, targetType)
    local rotationComponents = go.transform:GetComponents(targetType)
    
    for i = 0, rotationComponents.Length - 1 do
      local tr = rotationComponents[i]
      if tr.tweenGroup == targetGroup then
        CS.EventDelegate.Add(tr.onFinished, callbackEvent)
      end
    end
  end
  
  AddEvent(REF.TweenNode, CloseGroup, function()
    this:BroadcastGameEvent("UnlockCardClick")
  end, typeof(CS.TweenScale))
  AddEvent(REF["$"], DontMatchGroup, function()
    CloseCard()
    WU.SetActive(REF.GameCardFrame, false)
  end, typeof(CS.UIPlayTween))
  WU.BindButtonEvent(REF.ButtonSlot, OnCardClick)
end

function OpenCard()
  local p = FindUIPlayTween(OpenGroup)
  p:Play(true)
end

function CloseCard()
  WU.SetActive(REF.GameCardFrame, false)
  local p = FindUIPlayTween(CloseGroup)
  p:Play(true)
end

function DontMatch()
  local p = FindUIPlayTween(DontMatchGroup)
  p:Play(true)
end

function Matched()
  WU.SetActive(REF.GameCardFrame, false)
  WU.SetActive(REF.GameCardLight, true)
  local p = FindUIPlayTween(MatchedGroup)
  p:Play(true)
end

function OnCardClick()
  this:BroadcastGameEvent("TryToOpenCard", REF["$gameObject"])
end

function SetData(data)
  if data == nil then
    return
  end
  REF.ActorHead.UISprite.spriteName = data.head
  WU.SetActive(REF.GameCardLight, false)
  WU.SetActive(REF.GameCardFrame, false)
end

function ToggleNode(isOpen)
  WU.ToggleRendering(REF.Back, not isOpen)
  WU.ToggleRendering(REF.Front, isOpen)
end

function FindUIPlayTween(targetGroup)
  local components = REF["$transform"]:GetComponents(typeof(CS.UIPlayTween))
  for i = 0, components.Length - 1 do
    local pt = components[i]
    if pt.tweenGroup == targetGroup then
      return pt
    end
  end
end

function SetFrame(flag)
  WU.SetActive(REF.GameCardFrame, flag)
end

function SetLight(flag)
  WU.SetActive(REF.GameCardLight, flag)
end
