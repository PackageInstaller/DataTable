-- @FileName:   ShootBrickBrick.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickBrick', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)

    self.m_config = shootBrick.ShootBrickManager:getBrickConfigVo(self.m_args.data.brick_id)
    self.hp = self.m_config.hp

    self:getChildGO("mTextHp"):GetComponent(ty.Text).text = self.hp

    local horizontalLength = (ShootBrickConst.Screen_Width - (ShootBrickConst.BrickWidth * ShootBrickConst.MaxCol)) / 2 + (ShootBrickConst.BrickWidth / 2)
    self:setPos((self.m_args.col - 1) * ShootBrickConst.BrickWidth + horizontalLength, (self.m_args.row - 1) * -ShootBrickConst.BrickHeight - (ShootBrickConst.BrickHeight / 2))

    self:getChildGO("mEffect"):SetActive(false)
    self:refreshImg()
end

function refreshImg(self)
    local iconPath = self.m_config:getIconPath(self.hp)
    if iconPath then
        local img = self:getGo():GetComponent(ty.AutoRefImage)
        img:SetImg(iconPath)
    end
end

--收到攻击
function onHit(self, damage)
    AudioManager:playSoundEffect(self.m_config:getSoundPath())

    if self.m_config.hp == -1 then
        return
    end

    self.hp = self.hp - damage
    self:refreshImg()
    self:getChildGO("mTextHp"):GetComponent(ty.Text).text = self.hp

    if self.hp <= 0 then
        self:onDie()
        return true
    end

    self:getChildGO("mEffect"):SetActive(false)
    self:getChildGO("mEffect"):SetActive(true)

    return false
end

--死亡
function onDie(self)

end

function getPos(self)
    return self:getTrans():GetComponent(ty.RectTransform).anchoredPosition
end

function getSize(self)
    local rectTrans = self:getTrans():GetComponent(ty.RectTransform)
    return{width = rectTrans.rect.width, height = rectTrans.rect.height}
end

function getScore(self)
    return self.m_config.score
end

function recover(self)
    super.recover(self)

    self.m_config = nil
    self.hp = nil
end

return _M
