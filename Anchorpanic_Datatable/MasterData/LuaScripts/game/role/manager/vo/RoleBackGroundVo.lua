module("role.RoleBackGroundVo", Class.impl())
--[[ 
-----------------------------------------------------
@filename       : RoleBackGroundVo
@Description    : 信息面板背景解析
@date           : 2022-05-15 16:46:13
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
-- 解析消息
function parseBackGroundData(self, refID, curData)
    --输入编号
    self.refId = refID
    --解锁类型
    self.unlockType = curData.unlock_type
    -- 解锁列表
    self.unlockList = curData.unlock_list
    -- 背景描述
    self.getDescription = curData.get_description
    -- 图片名称
    self.resName = curData.res_name
    --快捷跳转ID
    self.uicodeId = curData.uicode
    -- 图片索引
    self.icon = curData.icon
    -- 排序
    self.sort = curData.sort
end
--获取小图片地址
function getIconLittleUrl(self)
    return UrlManager:getBgPath("friend/littleBg/friend_bg_little_" .. self.icon .. ".png")
end
--获取大图片地址
function getIconBigUrl(self)
    return UrlManager:getBgPath("friend/bigBg/friend_bg_" .. self.icon .. ".jpg")
end
--获取图片名称
function getName(self)
    return _TT(self.resName)
end
function getSort(self)
    local roleVo = role.RoleManager:getPersonalInfoList()
    local icon = role.RoleManager:getBackGroundVo(roleVo.background).icon
    local sort = self.sort
    if icon ~= self.icon then
        sort = sort + 1000
    end
    return sort
end
function getUicodeId(self)
    if self.uicodeId > 0 then
        return self.uicodeId
    end
    return false
end
--获取解锁ID
function getUnLockId(self)
    return self.unlockList[1]
end
--获取解锁Type
function getUnLockType(self)
    return self.refId
end
--获取解锁描述
function getUnLockDes(self)
    local mainVo, stageVo = battleMap.MainMapManager:getChapterVoByStageId(self:getUnLockId())
    local des = stageVo and _TT(57, stageVo.indexName) or _TT(self.getDescription)
    return des
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]