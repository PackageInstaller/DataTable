--- 默认战斗 AI：格心 → 索敌 → 攻击或走一格 → 新格再索敌
--- 继承 AIBase，可按需覆写 GetMarchGrid / OnGridReady 等
local AIBase = require("AIBase")

---@class AI_Default : AIBase
local AI_Default = class("AI_Default", AIBase)

---@param ctx AutoChessAIContext 桥接上下文
function AI_Default:ctor(ctx)
	AIBase.ctor(self, ctx)
	self.aiTag = "AI_Default"
end

return AI_Default
