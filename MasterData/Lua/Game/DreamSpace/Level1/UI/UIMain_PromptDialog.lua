

---@class UIMain_PromptDialog
-- ---@field promptAnimation         UnityEngine.Animation
-- ---@field finishGroup           UnityEngine.RectTransform
-- ---@field newGroup              UnityEngine.RectTransform
-- ---@field tick                  UnityEngine.RectTransform -- 打勾
-- ---@field textComp              UnityEngine.UI.Text
---@field promptAnimation          UnityEngine.Animation
---@field messageText           UnityEngine.UI.Text
local UIMain_PromptDialog = Class('UIMain_PromptDialog')



-- ========================================================

--- lua:
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程


local QuestUtils = import('Game.DreamSpace.Quest.QuestUtils')
---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')

---:
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Canvas = CS.UnityEngine.Canvas
local Transform = CS.UnityEngine.Transform
local Button = CS.UnityEngine.UI.Button
local RectTransform = CS.UnityEngine.RectTransform
local Vector3 = CS.UnityEngine.Vector3
local Quaternion = CS.UnityEngine.Quaternion
local Color = CS.UnityEngine.Color
local Time = CS.UnityEngine.Time
local Text = CS.UnityEngine.UI.Text
local Image = CS.UnityEngine.UI.Image
local Animation = CS.UnityEngine.Animation
local Animator = CS.UnityEngine.Animator


--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type DreamSpaceSounds
local DreamSpaceSounds = import('Game.DreamSpace.Tools.DreamSpaceSounds'):GetInstance()

-- ========================================================

local promptDialogEntry      = "ActionDreamlandTaskPromptDialog_entry"
local promptDialogOut    = "ActionDreamlandTaskPromptDialog_out"

-- ========================================================

function UIMain_PromptDialog:__init()
    self.controller = nil
end


function UIMain_PromptDialog:__delete()
end



function UIMain_PromptDialog:Awake()
    KTool.SetActive(self.controller.gameObject, true)
end


function UIMain_PromptDialog:Start()
    
    KTool.SetActive(self.controller.gameObject, true)
    KTool.SetActive(self.promptAnimation.gameObject, false)
end




function UIMain_PromptDialog:OnDestroy()
    self.controller = nil
    self:Delete()
end

-- =========================================== Self ================================================ --


function UIMain_PromptDialog:PlayEntry(message)
    KTool.SetActive(self.promptAnimation.gameObject, true)
    self.messageText.text = message
    self.promptAnimation:Play(promptDialogEntry)
    DreamSpaceSounds.Play( DreamSpaceSounds.sfx.promptDialog )
end

function UIMain_PromptDialog:PlayOut()
    self.promptAnimation:Play(promptDialogOut)
end



return UIMain_PromptDialog

