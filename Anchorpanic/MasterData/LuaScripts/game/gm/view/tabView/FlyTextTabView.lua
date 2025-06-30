--[[ 
-----------------------------------------------------
@filename       : FlyTextTabView
@Description    : 飞行文本板
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.FlyTextTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("gm/FlyTextTabView.prefab")

function configUI(self)
	super.configUI(self)
	local root2 = gs.GameObject.Find("[UI_ROOT]")
	self.mInLayerTrans = root2.transform
	
	self.mCPTrans = self:getChildTrans("CPos")
	self.mE1PTrans = self:getChildTrans("E1Pos")
	self.mE2PTrans = self:getChildTrans("E2Pos")
	self.mTxt1 = self:getChildGO("CPosTxt"):GetComponent(ty.Text)
	self.mTxt2 = self:getChildGO("E1PosTxt"):GetComponent(ty.Text)
	self.mTxt3 = self:getChildGO("E2PosTxt"):GetComponent(ty.Text)

	local input1 = self:getChildGO("Time1TInput"):GetComponent(typeof(CS.STInput))
	local input2 = self:getChildGO("Time2TInput"):GetComponent(typeof(CS.STInput))

	local function _call()
		local t1 = input1:GetInputFloatVal()
		local t2 = input2:GetInputFloatVal()
		if t1 and t1>0 and t2 and t2>0 then
			local cp = gs.Vector3(self.mCPTrans.anchoredPosition.x, self.mCPTrans.anchoredPosition.y)
			local e1p = gs.Vector3(self.mE1PTrans.anchoredPosition.x, self.mE1PTrans.anchoredPosition.y)
			local e2p = gs.Vector3(self.mE2PTrans.anchoredPosition.x, self.mE2PTrans.anchoredPosition.y)
			-- fightUI.FightFlyUtil:fly3D03(11,, "546$897", gs.VEC3_ZERO, cp, e1p, e2p, t1, t2)
			fightUI.FightFlyUtil:fly3D03(111,fight.FightDef.BATTLE_TYPE_DAMAGE, math.ceil(math.random(10,30)), gs.VEC3_ZERO, true)
		end
	end
	self:addOnClick(self:getChildGO("GOBtn"), _call)
end

function active(self, args)
	super.active(self, args)
	self.mFlyLayer = SubLayerMgr:getLayer(gud.SLAYER_FLOAT)
	self.mPLayer = self.mFlyLayer.parent
	self.mFlyLayer:SetParent(self.mInLayerTrans, false)

	self:__updateTime()
    self.mLoopSn = LoopManager:addTimer(1, 0, self, self.__updateTime)
end

--非激活
function deActive(self)
	LoopManager:removeTimerByIndex(self.mLoopSn)
	self.mLoopSn = 0
	self.mFlyLayer:SetParent(self.mPLayer, false)
    super.deActive(self)
end

function __updateTime(self)
	self.mTxt1.text = string.format("[%.2f, %.2f]",self.mCPTrans.anchoredPosition.x, self.mCPTrans.anchoredPosition.y)
	self.mTxt2.text = string.format("[%.2f, %.2f]",self.mE1PTrans.anchoredPosition.x, self.mE1PTrans.anchoredPosition.y)
	self.mTxt3.text = string.format("[%.2f, %.2f]",self.mE2PTrans.anchoredPosition.x, self.mE2PTrans.anchoredPosition.y)
end

return _M

 
--[[ 替换语言包自动生成，请勿修改！
]]
