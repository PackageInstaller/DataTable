--[[ 
-----------------------------------------------------
@filename       : MazeAbnormalShowItem
@Description    : 迷宫拥有异常状态列表item
@date           : 2021-07-07 11:11:49
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeAbnormalShowItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function setData(self, param)
    super.setData(self, param)

    local data = maze.MazeManager:getAbnormalConfigVo(self.data)
    local skillVo = data:getSkillVo()
    self.mTxtName.text = skillVo:getName()
    self.mTxtDes.text = skillVo:getDesc()
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()))
    self.mImgBg:SetImg(UrlManager:getPackPath(string.format("dupImplied/dupImplied_ab_bg_%s.png", data.color)))
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
