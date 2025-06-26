module("role.PersonalInfoVo", Class.impl())
--[[ 
-----------------------------------------------------
@filename       : PersonalInfoVo
@Description    : 个人信息面板解析
@date           : 2022-05-15 16:46:13
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
-- 解析消息
function parsePersonalInfoMsg(self, curData)
    --玩家展示id
    self.showId = curData.show_id
    -- 玩家名字
    self.playerName = curData.player_name
    -- 玩家签名
    self.playerSignature = curData.player_signature
    -- 等级
    self.level = curData.level
    -- 头像
    self.avatar = curData.avatar
    -- 头像框
    self.avatarFrame = curData.avatar_frame
    -- 称号
    self.designation = curData.designation
    -- 背景图
    self.background = curData.background
    -- 战员数量
    self.heroNum = curData.hero_num
    -- 主线进度
    self.mainStage = curData.main_stage
    -- 爬塔进度
    self.towerStage = curData.tower_stage
    -- 成就进度
    self.achievementNum = curData.achievement_num
    -- 无限城
    self.cityId = curData.city_id
    -- 皮肤数量
    self.fashionNum = curData.fashion_num
    --好友备注
    self.remarks = curData.friend_remarks
    -- 展示战员列表
    self.heroList = {}
    for i = 1, #curData.show_hero_list do
        local heroVo = curData.show_hero_list[i]
        table.insert(self.heroList, heroVo)
    end
end
--获取小图片地址
function getShowHeroList(self)
    table.sort(self.heroList, function(vo1, vo2)
        return vo1.pos < vo2.pos
    end)
    return self.heroList
end
--称号
function getTitleId(self)
    return self.designation
end
--头像框ID
function getAvatarFrameId(self)
    return self.avatarFrame
end
--等级
function getPlayerLvl(self)
    return self.level
end
--名字
function getPlayerName(self)
    return self.playerName
end
--个性签名
function getAutograph(self)
    if self.playerSignature == "" then
        self.playerSignature = _TT(520)
    end
    return self.playerSignature
end
--头像
function getAvatarId(self)
    return self.avatar
end
--主线进度
function getMainStage(self)
    if self.mainStage == 0 then
        self.mainStage = battleMap.MainMapManager:getMainMapShowStage()
    end
    return battleMap.MainMapManager:getStageVo(self.mainStage).indexName
end
--爬塔进度
function getTowerStage(self)
    return dup.DupClimbTowerManager:getDupVo(self.towerStage):getStageName()
end
--成就进度
function getAchievementNum(self)
    return self.achievementNum
end
--皮肤数量
function getFashionNum(self)
    return self.fashionNum
end
--战员数量
function getHeroNum(self)
    return self.heroNum
end
--背景图
function getBackGround(self)
    local icon = role.RoleManager:getBackGroundVo(self.background).icon
    return UrlManager:getBgPath("friend/bigBg/friend_bg_" .. icon .. ".jpg")
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]