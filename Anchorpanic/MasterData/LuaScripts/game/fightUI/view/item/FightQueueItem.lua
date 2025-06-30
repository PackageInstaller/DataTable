--[[   
     战斗UI下方技能区域 技能item
]]
module('fight.FightQueueItem', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_width = self.m_trans.rect.width
    self.m_imgHero = self:getChildGO('Icon'):GetComponent(ty.AutoRefImage)
    self.m_imgSide = self:getChildGO('ImgSide'):GetComponent(ty.AutoRefImage)
    self.m_heroID = nil
    self.m_index = nil
end

function getWidth(self)
    return self.m_width
end

function setHeroID(self, heroID, side, imgKey)
    self.m_heroID = heroID
    if side == 1 then
        self.m_imgSide:SetImg(UrlManager:getFightUIPath("fight_icon_2.png"))
    else
        --敌
        self.m_imgSide:SetImg(UrlManager:getFightUIPath("fight_icon_3.png"))
    end
    self.m_imgHero:SetImg(imgKey, false)
end
function getHeroID(self)
    return self.m_heroID
end
function setIndex(self,val)
    self.m_index = val
end
-- 位置顺序2 = 下一个开始的战员
function getIndex(self)
    return self.m_index
end
-- 设置容器
function setLayerTrans(self, layerTrans, posX)
    self.m_layerTrans = layerTrans
    if self.m_trans then
        self.m_trans:SetParent(self.m_layerTrans, false)
        gs.TransQuick:UIPos(self.m_trans, 0, posX)
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