-- @FileName:   DanKeSceneUISkillItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.danke.view.DanKeSceneUISkillItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, skillVo)
    self.m_skillVo = skillVo

    local mImgIcon =  self:getChildGO("mImgIcon")
    mImgIcon:SetActive(self.m_skillVo ~= nil)
    if self.m_skillVo ~= nil then 
        mImgIcon:GetComponent(ty.AutoRefImage):SetImg(self.m_skillVo:getIcon())
    end
end

function getData(self)
    return self.m_skillVo
end

return _M
