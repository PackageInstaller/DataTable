-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/forecast/RogueForecastCurveLine.lua

module("logic.extensions.roguelike.flow.component.forecast.RogueForecastCurveLine", package.seeall)

local M = class("RogueForecastCurveLine", IBattleReusable)
local kDefaultTexUSpeed = -1
local kTexUSpeed = UnityEngine.Shader.PropertyToID("_Basics_Tex_U_Speed")
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kForecastRoot = goutil.create("Forcasts")

goutil.addChildToParent(kForecastRoot, kSceneRoot)

M.mainGO = false
M._line = false

function M:ctor()
	local drawer = RogueMgr.instance:getForecastDrawer()
	local goLine = drawer:getInst(BattleResourceName.AttackForecast)
	local line = SpaceX.CurveLine.Get(goLine)

	goutil.addChildToParent(goLine, kForecastRoot)

	line.pointCount = 20
	line.interpPointY = 5
	line.useWorldSpace = false
	self._line = line
	self._materialSetter = MaterialSetter.Get(goLine)
	self.mainGO = goLine
end

function M:reuse()
	goutil.setActive(self.mainGO, true)
end

function M:reset()
	goutil.setActive(self.mainGO, false)
end

function M:destroy()
	goutil.destroy(self.mainGO)

	self._line = nil
	self._materialSetter = nil
	self.mainGO = nil
end

function M:setStartPositionXYZ(x, y, z)
	self._line:SetStartPoint(x, y, z)
end

function M:setEndPositionXYZ(x, y, z)
	self._line:SetEndPoint(x, y, z)
end

function M:seLineWidth(lineWidth)
	self._line.lineWidth = lineWidth
end

function M:setPlaySpeed(playSpeed)
	local uspeed = kDefaultTexUSpeed * playSpeed

	self._materialSetter:SetFloat(kTexUSpeed, uspeed)
end

function M:setColor(colorString)
	self._materialSetter:SetColor(kMainColorID, colorString)
end

function M:rebuild()
	self._line:Rebuild()
end

return M
