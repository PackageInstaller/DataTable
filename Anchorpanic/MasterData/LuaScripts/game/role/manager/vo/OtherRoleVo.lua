--[[ 
-----------------------------------------------------
@filename       : OtherRoleVo
@Description    : 其他玩家数据解析
@date           : 2023-17-59 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("role.OtherRoleVo", Class.impl("lib.event.EventDispatcher"))

function parseMsg(self, msg)
    -- 玩家id
    self.id = msg.player_id
    -- 玩家交互识别id
    self.showId = msg.show_id
    -- 玩家名字
    self.name = msg.player_name
    -- 玩家签名
    self.signature = msg.player_signature
    -- 等级
    self.lvl = msg.level
    -- 头像
    self.avatar = msg.avatar
    -- 头像框
    self.avatarFrame = msg.avatar_frame
    -- 称号
    self.playerTitle = msg.designation
    -- 军团
    self.guild = msg.guild
    -- 战力
    self.power = msg.power
    --战员数量
    self.heroNum = msg.hero_num
    --主线进度
    self.mainStage = msg.main_stage
    --爬塔进度
    self.towerStage = msg.tower_stage
    --成就进度
    self.achievementNum = msg.achievement_num
    --背景图
    self.background = msg.background
    -- 展示战员列表
    self.heroList = {}
	--联盟数据
    self.guildInfo  = msg.guild_info
    --无限城城区
    self.cityId = msg.city_id
    --皮肤数量
    self.fashionNum = msg.fashion_num
    --好友备注
    self.remarks = msg.friend_remarks
    
    for i = 1, #msg.hero_list do
        local heroVo = hero.OtherHeroVo.new()
        heroVo:parseOtherMsg(msg.hero_list[i])
        local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, heroVo.tid, heroVo.fashionBodyId)
        heroVo.model = fashionConfigVo.model
        table.insert(self.heroList, heroVo)
    end
end

--展示战员列表
function getShowHeroList(self)
    return self.heroList
end
--称号
function getTitleId(self)
    return self.playerTitle
end
--头像框ID
function getAvatarFrameId(self)
    return self.avatarFrame
end
--等级
function getPlayerLvl(self)
    return self.lvl
end
--名字
function getPlayerName(self)
    return self.name
end
--个性签名
function getAutograph(self)
    if self.signature == "" then
        self.signature = _TT(520)
    end
    return self.signature
end
--头像
function getAvatarId(self)
    return self.avatar
end
--主线进度
function getMainStage(self)
    if self.mainStage == 0 then
        self.mainStage = battleMap.MainMapManager:getMaxChapterStageId()
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