module('maze.MazeGoodsItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    -- self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    -- self.mImgBuffColor = self:getChildGO("mImgBuffColor"):GetComponent(ty.AutoRefImage)
    -- self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    -- self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)

    local buffId = self.data

    -- 老版显示
    -- local goodsConfigVo = maze.MazeManager:getGoodsConfigVo(buffId)
    -- self.mTxtName.text = goodsConfigVo:getName()
    -- self.mTxtDes.text = goodsConfigVo:getDes()
    -- local skillVo = fight.SkillManager:getSkillRo(goodsConfigVo.skillId)
    -- self.mImgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    -- self.mImgBuffColor:SetImg(UrlManager:getPackPath(string.format("maze5/maze_buff_color_%s.png", goodsConfigVo.color)))
    
    -- 新版显示
    local goodsConfigVo = maze.MazeManager:getGoodsConfigVo(buffId)
    local skillVo = fight.SkillManager:getSkillRo(goodsConfigVo.skillId)
    self.mImgBg:SetImg(UrlManager:getPackPath(string.format("maze5/maze_buff_%s.png", goodsConfigVo.color)), true)
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    self.mTxtTitle.text = _TT(63014)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtImprove.text = _TT(63013, goodsConfigVo.efficiency / 10)
    self.mTxtDes.text = goodsConfigVo:getDes()
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
