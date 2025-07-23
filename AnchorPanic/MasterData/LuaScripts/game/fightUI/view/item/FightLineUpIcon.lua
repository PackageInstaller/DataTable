--[[   
     战斗UI下方技能区域 技能item
]]
module('fight.FightLineUpIcon', Class.impl('lib.component.BaseContainer'))
UIRes = UrlManager:getUIPrefabPath('fight/FightLineUpIcon.prefab')

function initData(self)
	self.m_imgHero = nil
	self.m_heroID = nil
end

--初始化UI
function configUI(self)
	self.m_imgHero = self.UIObject:GetComponent(ty.AutoRefImage)
end

function setImg( self, imgKey )
	self.m_imgHero:SetImg(imgKey)
end

function setHeroID( self, heroID )
	self.m_heroID = heroID
end
function getHeroID( self )
	return self.m_heroID
end

-- 设置容器
function setLayerTrans(self, layerTrans, posX)
	self.m_layerTrans = layerTrans
	if self.UIObject then
		self.UITrans:SetParent(self.m_layerTrans, false)
		gs.TransQuick:UIPos(self.UITrans, posX, 0)
		self:active()
    end
end

-- 设置x偏移
function moveOffset(self, offset)
	if self.UIObject then
	-- self.UITrans:DOMoveUIOffsetX(offset, 0.5)
		self.UITrans:DOMoveUIX(offset, 0.5)
	-- TweenFactory:move2LPosX(self.UITrans, offset, 0.5)
	end
end


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
