-- 发射炮弹动画定制效果
module("maze.MazeEffectExecuter_1", Class.impl(maze.MazeBaseEffectExecuter))

function __initData(self)
	super.__initData(self)

	self.mBoomTrans = nil
	self.mTargetWorldPos = nil
	self.mDistanceToTarget = nil
	self.mSpeed = 10
end

function startPlay(self, mazeId, data)
	local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, data[1])
	local startWorldPos = maze.MazeSceneThingManager:getLayer(maze.LAYER_THING):TransformPoint(self:__getPos(mazeId, row, col))

	self.mBoomTrans = AssetLoader.GetGO(maze.getPrefabUrl("other/MazeFire.prefab")).transform
	self.mBoomTrans:SetParent(maze.MazeSceneThingManager:getLayer(maze.LAYER_THING), true)
	gs.TransQuick:Pos(self.mBoomTrans, startWorldPos)

	row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, data[#data])
	self.mTargetWorldPos = maze.MazeSceneThingManager:getLayer(maze.LAYER_THING):TransformPoint(self:__getPos(mazeId, row, col))
	self.mDistanceToTarget = math.v3Distance(startWorldPos, self.mTargetWorldPos)

	self:__addFrame()
end

function __onStepHandler(self, deltaTime)
	super.__onStepHandler(self, deltaTime)

	local boomPos = self.mBoomTrans.position
	local currentDist = math.v3Distance(boomPos, self.mTargetWorldPos)
	-- 弧线中的夹角
	local angle = math.min(1, currentDist / self.mDistanceToTarget) * 45
	self.mBoomTrans.rotation = self.mBoomTrans.rotation * gs.Quaternion.Euler(gs.Mathf.Clamp(-angle, -42, 42), 0, 0)
	self.mBoomTrans:Translate(gs.Vector3.forward * math.min(self.mSpeed * deltaTime, currentDist))
	self.mBoomTrans:LookAt(self.mTargetWorldPos)
	if (currentDist < 0.5)then
		maze.MazeEffectExecutor:removeEffect(self)
	end
end

function __reset(self)
	super.__reset(self)
	if(self.mCallFun)then
		self.mCallFun()
	end
	gs.GameObject.Destroy(self.mBoomTrans.gameObject)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
