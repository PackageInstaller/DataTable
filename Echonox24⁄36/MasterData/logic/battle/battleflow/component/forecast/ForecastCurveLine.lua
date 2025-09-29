-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/ForecastCurveLine.lua

module("logic.battle.battleflow.component.forecast.ForecastCurveLine", package.seeall)

local ForecastCurveLine = class("ForecastCurveLine", IBattleReusable)
local kTexUSpeed = UnityEngine.Shader.PropertyToID("_Basics_Tex_U_Speed")
local kDefaultTexUSpeed = -1
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kForecastRoot = goutil.create("Forcasts")

goutil.addChildToParent(kForecastRoot, kSceneRoot)

ForecastCurveLine.mainGO = false
ForecastCurveLine._line = false

function ForecastCurveLine:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local goLine = resMgr:getInst(BattleResourceName.AttackForecast)
	local line = SpaceX.CurveLine.Get(goLine)

	goutil.addChildToParent(goLine, kForecastRoot)

	line.pointCount = 20
	line.interpPointY = 5
	line.useWorldSpace = false
	self._line = line
	self._materialSetter = MaterialSetter.Get(goLine)
	self.mainGO = goLine
end

function ForecastCurveLine:reuse()
	goutil.setActive(self.mainGO, true)
end

function ForecastCurveLine:reset()
	goutil.setActive(self.mainGO, false)
end

function ForecastCurveLine:destroy()
	goutil.destroy(self.mainGO)

	self._line = nil
	self._materialSetter = nil
	self.mainGO = nil
end

function ForecastCurveLine:setStartPositionXYZ(x, y, z)
	self._line:SetStartPoint(x, y, z)
end

function ForecastCurveLine:setEndPositionXYZ(x, y, z)
	self._line:SetEndPoint(x, y, z)
end

function ForecastCurveLine:seLineWidth(lineWidth)
	self._line.lineWidth = lineWidth
end

function ForecastCurveLine:setPlaySpeed(playSpeed)
	local uspeed = kDefaultTexUSpeed * playSpeed

	self._materialSetter:SetFloat(kTexUSpeed, uspeed)
end

function ForecastCurveLine:rebuild()
	self._line:Rebuild()
end

return ForecastCurveLine
