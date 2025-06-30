
module('fight.FightQueueIcon', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
	self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
	self.mGroupEff = self:getChildTrans("mGroupEff")
end

function getWidth(self)
	return self.m_trans.rect.width
end

function getHeight(self)
	return self.m_trans.rect.height
end

function setImg( self, imgKey )
	self.mImgIcon:SetImg(imgKey)
	self.mImgIcon.gameObject:SetActive(true)
end

function getHeroID( self )
	
end

-- 下一回合标识
function nextFlag(self)
	self.mImgIcon.gameObject:SetActive(false)
	self:addEffect("fx_ui_fightQueue_loop", self.mGroupEff)
end

-- 设置容器
function setLayerTrans(self, layerTrans, posY)
	self.m_layerTrans = layerTrans
	if self.m_trans then
		self.m_trans:SetParent(self.m_layerTrans, false)
		gs.TransQuick:UIPos(self.m_trans, 0, posY)
    end
end

-- 设置x偏移
function moveOffset(self, offset)
	if self.m_trans then
	-- self.UITrans:DOMoveUIOffsetX(offset, 0.5)
		self.m_trans:DOMoveUIX(offset, 0.5)
	-- TweenFactory:move2LPosX(self.UITrans, offset, 0.5)
	end
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
