module('UrlManager', Class.impl())

function ctor(self)
    self.m_dic = {}
end

-- 获取ui资源全路径（pathName = bag/bag_1.png）
function getPackPath(self, pathName)
    return "arts/ui/pack/" .. pathName
end

-- 获取ui公共资源资源全路径（pathName = common_1001.png）
function getCommonPath(self, pathName)
    return "arts/ui/pack/common1/" .. pathName
end

-- 新公用ui资源
function getCommonNewPath(self, pathName)
    return "arts/ui/pack/common/" .. pathName
end

-- UI4公用ui资源
function getCommon4Path(self, pathName)
    return "arts/ui/pack/common4/" .. pathName
end

-- UI5公用ui资源
function getCommon5Path(self, pathName)
    return "arts/ui/pack/common5/" .. pathName
end

-- 获取icon资源全路径（pathName = item/props_2021.png）
function getIconPath(self, pathName)
    return "arts/ui/icon/" .. pathName
end

-- 获取bg资源全路径（pathName = dup/dup_bg_1.jpg）
function getBgPath(self, pathName)
    return "arts/ui/bg/" .. pathName
end

-- 获取loading资源路径（pathName = loadingBg_1）
function getloadingPath(self, pathName)
    return "arts/ui/bg/load_on/" .. pathName .. ".jpg"
end

-- 获取预制体资源全路径
function getPrefabPath(self, pathName)
    return "arts/prefabs/" .. pathName
end

-- 获取ui预制体资源全路径（pathName = bag/BagPanel.prefab）
function getUIPrefabPath(self, pathName)
    return "arts/prefabs/ui/" .. pathName
end

-- ui动画文件
function getUIAniPath(self, pathName)
    return "arts/uianimation/" .. pathName
end

-- 艺术字体
function getFntPath(self, pathName)
    return "arts/fonts/fnt/" .. pathName
end

-- 获取音乐路径
function getAudioPath(self, pathName)
    return "arts/audio/" .. pathName
end

-- 获取游戏背景音乐路径
function getMusicPath(self, pathName)
    return "arts/audio/music/" .. pathName
end

-- 获取游戏音效路径
function getEffectSoundPath(self, pathName)
    return "arts/audio/sound/" .. pathName
end

-- 获取游戏剧情音效路径
function getStorySoundPath(self, pathName)
    return "arts/audio/story/" .. pathName
end

-- 获取战斗音效路径
function getFightSoundPath(self, pathName)
    if pathName then
        return "arts/audio/sfx/" .. pathName
    end
    return ""
end

-- 获取cv配音路径开头
function getCVSoundPrefixPath(self)
    return "arts/audio/cv/"
end

-- 获取cv配音路径
function getCVSoundPath(self, pathName)
    return self:getCVSoundPrefixPath() .. pathName
end

-- 获取ui音源路径
function getUISoundPath(self, pathName)
    return "arts/audio/UI/" .. pathName
end

-- 获取ui基础音效路径
function getUIBaseSoundPath(self, pathName)
    return "arts/audio/UI/basic/" .. pathName
end

-- 获取宿舍音效路径
function getDormSoundPath(self, pathName)
    return "arts/audio/UI/dorm/" .. pathName
end

-- 获取锚点空间音效路径
function getMainExploreSoundPath(self, pathName)
    return "arts/audio/UI/mainExplore/" .. pathName
end

-- 技能镜头资源路径
function getFightCameraAniPath(self, pathName)
    return "arts/character/camera/" .. pathName
end

-- 战员模型路径
function getRolePath(self, pathName)
    return "arts/character/role/" .. pathName
end

-- 战员模型路径
function getRolePath01(self, modelID)
    return string.format("arts/character/role/%s/model%s.prefab", modelID, modelID)
end

-- 怪物模型路径
function getMonsterPath01(self, modelID)
    return string.format("arts/character/monster/%s/model%s.prefab", modelID, modelID)
end

-- NPC模型路径
function getNPCPath01(self, modelID)
    return string.format("arts/character/npc/%s/model%s.prefab", modelID, modelID)
end

-- 武器模型路径
function getWeaponPath(self, pathName)
    return "arts/character/weapon/" .. pathName
end

-- 怪物模型路径
function getMonsterPath(self, pathName)
    return "arts/character/monster/" .. pathName
end

-- 角色展示道具模型路径
function getShowItemPath(self, pathName)
    return "arts/character/show_item/" .. pathName
end

-- 角色特效
function getEfxRolePath(self, pathName)
    return "arts/fx/3d/role/prefab/" .. pathName
end

-- 常驻特效
function getAlwayEfxRolePath(self, pathName)
    return self:getEfxRolePath("always/" .. pathName)
end

-- boss特效
function getEfxBossPath(self, pathName)
    return self:getEfxRolePath("boss/" .. pathName)
end

-- ui材质
function getUIMaterial(self, path)
    return "arts/mat/ui/" .. path
end

-- ui特效
function getUIEfxPath(self, path)
    return "arts/fx/ui/effect/" .. path
end

-- 3dBuff特效目录
function get3DBuffPath(self, path)
    return "arts/fx/3d/role/prefab/common/" .. path
end

-- 3d的场景特效目录
function get3DSceneFx(self, path)
    return "arts/fx/3d/" .. path
end

function getScenePath(self, sceneName)
    return "arts/scene/" .. sceneName .. ".unity"
end

-- 技能图标路径
function getSkillIconPath(self, skillName)
    return "arts/ui/icon/skill/" .. skillName
end

function getMonsterIconPath(self, path)
    return "arts/ui/icon/monster/" .. path
end

-- 使徒之战图标路径
function getDupApoIconPath(self, skillName)
    return "arts/ui/icon/dupImplied/matrix/" .. skillName
end

-- Q版模型路径
function getQRolePath(self, modelID)
    return string.format("arts/character/pet/%s_qb/model%s_qb.prefab", modelID, modelID)
end

-- 锚驴模型路径
function getPetPath(self, modelID)
    return string.format("arts/character/pet/%s/model%s.prefab", modelID, modelID)
end

-- 战斗UI资源路径
function getFightUIPath(self, pathName)
    return self:getPackPath("fight5/" .. pathName)
end

-- 战斗UI资源路径
function getFightArtfontPath(self, pathName)
    return self:getPackPath("fightArtfont/" .. pathName)
end

-- 页签小图标
function getTabIcon(self, pathName)
    return self:getIconPath("tabIcon/" .. pathName)
end

-- 页签小图标
function getMoneyIconUrl(self, propsTid)
    return self:getIconPath(string.format("money/money_%s.png", propsTid))
end

-- 图鉴-音乐图片
function getManualMusicIconUrl(self, pathName)
    return self:getIconPath("manualMusic/" .. pathName .. ".png")
end

-- 技能基建图标路径
function getBuildBaseSkillIconPath(self, skillName)
    return "arts/ui/icon/buildBase/" .. skillName
end

-- 战员时装商店半身像路径
function getFashionShopBodyPath(self, pathName)
    return self:getIconPath("fashionShop/" .. pathName)
end

-- 战员时装界面半身像路径（是时装商店的不一样）
function getHeroFashionBodyPath(self, modelId)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "heroFashion_Har" or "heroFashion"
    return self:getIconPath(string.format("%s/hero_fashion_%s.png", url, modelId))
end

-- 模组头像
function getHeroHeadInEquipByModel(self, modelId)
    return self:getIconPath(string.format("heroHeadEquip/hero_Module_%s.png", modelId))
end

----------------------------------------------------------------

function getDic(self, functionTable, key)
    if (not self.m_dic[functionTable]) then
        self.m_dic[functionTable] = {}
    end
    if (not self.m_dic[functionTable][key]) then
        self.m_dic[functionTable][key] = {}
    end
    return self.m_dic[functionTable][key]
end

-- 获取道具图标icon
function getPropsIconUrl(self, propsTid)
    local dic = self:getDic(self.getPropsIconUrl, propsTid)
    if (not dic.source) then
        local propsConfigVo = props.PropsManager:getPropsConfigVo(propsTid)
        if not propsConfigVo then
            logError(string.format('id%s的道具不存在', propsTid), "UrlManager")
        end
        dic.source = "arts/ui/icon/" .. propsConfigVo.icon
    end
    return dic.source
end

-- 模组槽位图标
function getEquipSlot(self, slotID)
    return string.format("arts/ui/pack/chip/backpack_0%s.png", slotID)
end

-- 获取手环图标icon
function getBraceletIconUrl(self, propsTid)
    return UrlManager:getIconPath("bracelet/mark_" .. propsTid .. ".png")
end

-- 获取手环颜色
function getNraceletColorUrl(self, color)
    return UrlManager:getPackPath("bracelet/Nucleariron_pnl_" .. color .. ".png")
end

-- 获取手环颜色 右侧展示
function getNraceletRightColorUrl(self, color)
    return UrlManager:getPackPath("bracelet/Nucleariron_pnl_right_" .. color .. ".png")
end

-- 获取道具背景图
function getPropsBgUrl(self, color)
    local dic = self:getDic(self.getPropsBgUrl, color)
    if (not dic.source) then
        dic.source = self:getCommon5Path("common_0" .. (102 + color) .. ".png")
    end
    return dic.source
end

-- 获取装备背景图
function getEquipBgUrl(self, color)
    local dic = self:getDic(self.getEquipBgUrl, color)
    if (not dic.source) then
        dic.source = self:getCommon5Path("common_0" .. (102 + color) .. ".png")
    end
    return dic.source
end

-- 获取阵型头像资源
function getFormationHeadUrl(self, model)
    local dic = self:getDic(self.getFormationHeadUrl, model)
    if (not dic.source) then
        dic.source = self:getIconPath("heroFormation/hero_formation_" .. model .. ".png")
    end
    return dic.source
end

function getEquipQualityUrl(self, color)
    local dic = self:getDic(self.getEquipQualityUrl, color)
    if (not dic.source) then
        dic.source = self:getPackPath("chip/chip_quality_" .. color .. ".png")
    end
    return dic.source
end

-- 获取装备背景图
function getOrderBgUrl(self)
    local source = self:getCommonNewPath("common_1215.png")
    return source
end

-- 获取道具品质线条图
function getPropsColorLineUrl(self, color)
    local dic = self:getDic(self.getPropsColorLineUrl, color)
    if (not dic.source) then
        if (color == ColorType.GREEN) then
            dic.source = self:getCommon4Path("common_1447.png")
        elseif (color == ColorType.BLUE) then
            dic.source = self:getCommon4Path("common_1450.png")
        elseif (color == ColorType.VIOLET) then
            dic.source = self:getCommon4Path("common_1449.png")
        elseif (color == ColorType.ORANGE) then
            dic.source = self:getCommon4Path("common_1448.png")
        end
    end
    return dic.source
end

-- 获取道具tip品质角标图
function getPropsTipColorIconUrl(self, color)
    local dic = self:getDic(self.getPropsTipColorIconUrl, color)
    if (not dic.source) then
        dic.source = "common_" .. ((5016 - 1) + color) .. ".png"
    end
    return dic.source
end

-- 获取道具左上角品质角标图
function getPropsLeftTopColorIconUrl(self, color)
    local dic = self:getDic(self.getPropsLeftTopColorIconUrl, color)
    if (not dic.source) then
        dic.source = "common_" .. (5033 + color) .. ".png"
    end
    return dic.source
end

------------------------------------------------------------------------start-待废用--------------------------------------------------------------------------
-- 获取英雄圆形头像
function getHeroCircularHeadUrl(self, heroTid)
    local dic = self:getDic(self.getHeroCircularHeadUrl, heroTid)
    if (not dic.source) then
        dic.source = self:getIconPath("heroHead/hero_head_" .. heroTid .. ".png")
    end
    return dic.source
end

-- 获取英雄又是半身像
function getHeroBgImgUrl(self, source)
    if source then
        return "arts/ui/icon/heroShadow/" .. source
    end
    return source
end

------------------------------------------------------------------------end-待废用--------------------------------------------------------------------------

-- 通过id获取怪物头像
function getMonsterHeadUrl(self, uniqueId)
    if (uniqueId > 0) then
        local monsterTidVo = monster.MonsterManager:getMonsterVo(uniqueId)
        return self:getMonsterTidHeadUrl(monsterTidVo.tid)
    else
        dic.source = self:getIconPath("heroHead/hero_head_0.png")
    end
end

-- 通过tid获取怪物头像
function getMonsterTidHeadUrl(self, tid)
    local dic = self:getDic(self.getMonsterTidHeadUrl, tid)
    if (not dic.source) then
        if (tid > 0) then
            local monsterConfigVo = monster.MonsterManager:getMonsterVo01(tid)
            dic.source = self:getIconPath(monsterConfigVo.head)
        else
            dic.source = self:getIconPath("heroHead/hero_head_0.png")
        end
    end
    return dic.source
end

function getMonsterTidMaxHeadUrl(self, tid)
    return UrlManager:getIconPath("monsterArchives/mon_archives_normal_" .. tid .. ".png")
end

-- 通过model获取怪物头像
function getMonsterModelHeadUrl(self, model)
    local dic = self:getDic(self.getMonsterModelHeadUrl, model .. "")
    if (not dic.source) then
        if (model > 0) then
            local monsterConfigVo = monster.MonsterManager:getMonsterConfigVoByModel(model .. "")
            dic.source = self:getIconPath(monsterConfigVo.head)
        else
            dic.source = self:getIconPath("heroHead/hero_head_0.png")
        end
    end
    return dic.source
end

-- 获取英雄头像
function getHeroHeadUrl(self, heroTid)
    local dic = self:getDic(self.getHeroHeadUrl, heroTid)
    if (not dic.source) then
        if (heroTid > 0) then
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
            dic.source = self:getIconPath(heroConfigVo.head)
        else
            dic.source = self:getIconPath("heroHead/hero_head_0.png")
        end
    end
    return dic.source
end

-- 利用模型id获取英雄头像
function getHeroHeadUrlByModel(self, modelId)
    local dic = self:getDic(self.getHeroHeadUrlByModel, modelId)
    if (not dic.source) then
        dic.source = self:getIconPath(string.format("heroHead/hero_head_%s.png", modelId))
    end
    return dic.source
end

-- 利用模型id获取 武器Grid 圆形小英雄头像 | 手环、模组
function getHeroHeadCircularByModel(self, modelId)
    if modelId then
        return self:getIconPath(string.format("heroHeadCircleEquip/hero_rotundity_%s.png", modelId))
    else
        return self:getIconPath(string.format("heroHeadCircleEquip/hero_rotundity_%s.png", 1102))
    end
end

-- 利用图片全称称获取英雄头像含.png
function getHeroHeadUrlByImgName(self, imgName)
    local dic = self:getDic(self.getHeroHeadUrlByImgName, imgName)
    if (not dic.source) then
        dic.source = self:getIconPath("heroHead/" .. imgName)
    end
    return dic.source
end

-- 通过source获取英雄阴影头像
function getHeroHeadShadow(self, modelId)
    local dic = self:getDic(self.getHeroHeadShadow, modelId)
    if (not dic.source) then
        dic.source = string.format("arts/ui/icon/heroShadow/hero_shadow_%s.png", modelId)
    end
    return dic.source
end

-- 通过模型id获取boss大血条专用头像
function getMonBossShadow(self, modelId)
    local dic = self:getDic(self.getMonBossShadow, modelId)
    if (not dic.source) then
        dic.source = string.format("arts/ui/icon/monsterShadowBoss/combat_boss_%s.png", modelId)
    end
    return dic.source
end

-- 获取英雄圆形头像背景
function getHeroCircularHeadBgUrl(self, color)
    local dic = self:getDic(self.getHeroCircularHeadBgUrl, color)
    if (not dic.source) then
        dic.source = "common_" .. (1036 + color) .. ".png"
    end
    return dic.source
end

-- 获取英雄半身像通过模型id
function getHeroSmallBodyImgUrl(self, modelId)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "heroSmallList_Har" or "heroSmallList"
    return string.format("arts/ui/icon/%s/hero_smallBody_%s.png", url, modelId)
    -- local dic = self:getDic(self.getHeroBodyImgUrl, modelId)
    -- if (not dic.source) then
    --     dic.source = string.format("arts/ui/icon/heroList/hero_bigBody_%s.png", modelId)
    -- end
    -- return dic.source
end

-- 获取英雄半身像通过模型id
function getHeroBodyImgUrl(self, modelId)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "heroList_Har" or "heroList"
    return string.format("arts/ui/icon/%s/hero_bigBody_%s.png", url, modelId)
    -- local dic = self:getDic(self.getHeroBodyImgUrl, modelId)
    -- if (not dic.source) then
    --     dic.source = string.format("arts/ui/icon/heroList/hero_bigBody_%s.png", modelId)
    -- end
    -- return dic.source
end

-- 获取英雄半身像通过模型id
function getCycleHeroBodyImgUrl(self, modelId)
    local dic = self:getDic(self.getCycleHeroBodyImgUrl, modelId)
    if (not dic.source) then
        dic.source = string.format("arts/ui/icon/cycleHero/hero_formation_%s.png", modelId)
    end
    return dic.source
end

-- 获取英雄半身像图片全称带.png后缀
function getHeroBodyUrlByImgName(self, imgName)
    local dic = self:getDic(self.getHeroBodyUrlByImgName, imgName)
    if (not dic.source) then
        dic.source = "arts/ui/icon/heroBody/" .. imgName
    end
    return dic.source
end

-- 获取pain像
function getPainImg(self, imgName)
    local url = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and "heroRecord_Har" or "heroRecord"
    return self:getBgPath(string.format("%s/%s", url, imgName))
end

---- 获取时装服饰像
--function getFashionClothesUrl(self, model)
--	local dic = self:getDic(self.getFashionClothesUrl, model)
--	if(not dic.source)then
--		dic.source = "arts/ui/icon/heroFashion/hero_fashion_" .. model .. ".png"
--	end
--	return dic.source
--end

-- 获取时装商店展示卡片
function getFashionShopClothesUrl(self, model)
    local dic = self:getDic(self.getFashionClothesUrl, model)
    if (not dic.source) then
        dic.source = "arts/ui/icon/fashionShop/hero_fashionShop_" .. model .. ".png"
    end
    return dic.source
end

-- 获取英雄武器像
function getFashionWeaponUrl(self, propsTid)
    local dic = self:getDic(self.getFashionWeaponUrl, propsTid)
    if (not dic.source) then
        local propsConfigVo = props.PropsManager:getPropsConfigVo(propsTid)
        if not propsConfigVo then
            logError(string.format('id%s的道具不存在', propsTid), "UrlManager")
        end
        dic.source = "arts/ui/icon/" .. propsConfigVo.icon
    end
    return dic.source
end

-- 获取英雄职业icon
function getHeroJobIconUrl(self, professionType)
    local dic = self:getDic(self.getHeroJobIconUrl, professionType)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath("heroProfession/heroProfession_" .. professionType .. ".png")
    end
    return dic.source
end

-- 获取英雄职业小icon
function getHeroJobSmallIconUrl(self, professionType)
    local dic = self:getDic(self.getHeroJobSmallIconUrl, professionType)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath("heroProfession/heroProfession_" .. professionType .. ".png")
    end
    return dic.source
end

-- 获取怪物职业小icon
function getMonsterJobSmallIconUrl(self, professionType)
    local dic = self:getDic(self.getMonsterJobSmallIconUrl, professionType)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath("heroProfession/heroProfession_" .. professionType .. ".png")
    end
    return dic.source
end

-- 获取英雄职业icon(白色)
function getHeroJobWhiteIconUrl(self, professionType)
    local dic = self:getDic(self.getHeroJobWhiteIconUrl, professionType)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath("heroProfession/heroProfession_" .. professionType .. ".png")
    end
    return dic.source
end

-- 获取英雄属性定位icon
function getHeroEleTypeIconUrl(self, eleType)
    return self:getIconPath("heroElement/hero_element_" .. eleType .. ".png")
end

-- 获取英雄属性定位icon - 带描边
function getHeroEleTypeIconUrl2(self, eleType)
    return self:getIconPath("heroElement/ys_" .. eleType .. ".png")
end

-- 获取英雄技能范围icon
function getHeroSkillRangeIconUrl(self, index)
    local dic = self:getDic(self.getHeroSkillRangeIconUrl, index)
    if (not dic.source) then
        dic.source = self:getIconPath("skillRange/skillRange_" .. index .. ".png")
    end
    return dic.source
end

-- 获取英雄国家icon
function getHeroCountryIconUrl(self, camp)
    local dic = self:getDic(self.getHeroCountryIconUrl, camp)
    if (not dic.source) then
        dic.source = "hero_country_" .. camp .. ".png"
    end
    return dic.source
end

-- 获取英雄模型大图
function getHeroModelUrl(self, source)
    local dic = self:getDic(self.getHeroModelUrl, source)
    if (not dic.source) then
        dic.source = "arts/ui/bg/heroRecord/" .. source
    end
    return dic.source
end

-- 获取战员立绘
function getheroRecordUrl(self, modelId)
    local dic = self:getDic(self.getheroRecordUrl, modelId)
    if (not dic.source) then
        dic.source = string.format("arts/ui/bg/heroRecord/record_pic_%s.png", modelId)
    end
    return dic.source
end

-- 获取英雄品质大图
function getHeroColorBigIconUrl(self, color)
    local dic = self:getDic(self.getHeroColorBigIconUrl, color)
    if (not dic.source) then
        dic.source = "hero_base_color_" .. color .. ".png"
    end
    return dic.source
end

-- 获取英雄品质字母图icon
function getHeroColorCharacterIconUrl(self, color)
    local dic = self:getDic(self.getHeroColorCharacterIconUrl, color)
    if (not dic.source) then
        dic.source = self:getCommonPath("common_" .. (5020 + color) .. ".png")
    end
    return dic.source
end

-- 获取英雄升品用的品质字母图icon
function getHeroColorCharacterIconUrl_1(self, color)
    local dic = self:getDic(self.getHeroColorCharacterIconUrl_1, color)
    if (not dic.source) then
        dic.source = self:getCommonPath("common_" .. (5083 + color) .. ".png")
    end
    return dic.source
end

-- 获取英雄品质icon
function getHeroColorIconUrl(self, color)
    local dic = self:getDic(self.getHeroColorIconUrl, color)
    if (not dic.source) then
        if color == 1 then
        elseif color == 2 then
            dic.source = self:getCommon5Path("common_0033.png")
        elseif color == 3 then
            dic.source = self:getCommon5Path("common_0031.png")
        elseif color == 4 then
            dic.source = self:getCommon5Path("common_0032.png")
        elseif color == 5 then
        end
        --dic.source = self:getPackPath("hero4/hero4_color_"..color..".png")
    end
    return dic.source
end

-- 获取英雄升品用的品质字母图icon(升格界面里另一版资源)
function getHeroColorCharacterIconUrl_2(self, color)
    local dic = self:getDic(self.getHeroColorCharacterIconUrl_2, color)
    if (not dic.source) then
        dic.source = self:getPackPath(string.format("hero4/hero_color_up_c_%s.png", color))
    end
    return dic.source
end

-- 获取英雄品质icon 1
function getHeroColorIconUrl_1(self, color)
    return self:getCommon5Path("common_0" .. (177 - color) .. ".png")
end

-- 获取英雄品质icon 2
function getHeroColorIconUrl_2(self, color)
    local dic = self:getDic(self.getHeroColorIconUrl_2, color)
    if (not dic.source) then
        if (color == ColorType.GREEN) then
            dic.source = self:getCommon5Path("common_0172.png")
        elseif (color == ColorType.BLUE) then
            dic.source = self:getCommon4Path("common_0175.png")
        elseif (color == ColorType.VIOLET) then
            dic.source = self:getCommon4Path("common_0174.png")
        elseif (color == ColorType.ORANGE) then
            dic.source = self:getCommon4Path("common_0173.png")
        end
    end
    return dic.source
end

function getHeroColorBgUrl(self, color)
    local dic = self:getDic(self.getHeroColorIconUrl_1, color)
    if (not dic.source) then
        if (color == ColorType.GREEN) then
            --dic.source = self:getCommon4Path("common_1447.png")
        elseif (color == ColorType.BLUE) then
            dic.source = self:getCommon5Path("common_0028.png")
        elseif (color == ColorType.VIOLET) then
            dic.source = self:getCommon5Path("common_0026.png")
        elseif (color == ColorType.ORANGE) then
            dic.source = self:getCommon5Path("common_0027.png")
        end
    end
    return dic.source
end

-- 获取英雄原画阴影图
function getHeroShadowBgUrl(self, source)
    -- local dic = self:getDic(self.getHeroShadowBgUrl, color)
    -- if(not dic.source)then
    -- 	dic.source = "hero_shadow_"..color..".png"
    -- end
    -- return dic.source
    return source
end

-- 获取装备突破级别图标
function getEquipTuPoRankIconUrl(self, tuPoRank)
    local dic = self:getDic(self.getEquipTuPoRankIconUrl, tuPoRank)
    if (not dic.source) then
        dic.source = "equip_rank_icon_" .. tuPoRank .. ".png"
    end
    return dic.source
end

-- 获取装备套装icon图
function getEquipSuitIconUrl(self, suitId)
    local dic = self:getDic(self.getEquipSuitIconUrl, suitId)
    if (not dic.source) then
        if (suitId > 0) then
            dic.source = UrlManager:getIconPath("equipSuit/equipSuitIcon/equip_suit_icon_" .. suitId .. ".png")
        else
            dic.source = UrlManager:getIconPath("equipSuit/equipSuitIcon/equip_suit_icon_all.png")
        end
    end
    return dic.source
end

-- 获取属性图标
function getAttrIconUrl(self, attrKey)
    local dic = self:getDic(self.getAttrIconUrl, attrKey)
    if (not dic.source) then
        if (attrKey == AttConst.HP_MAX) then
            dic.source = self:getCommonPath("common_5040.png")
        elseif (attrKey == AttConst.ATTACK) then
            dic.source = self:getCommonPath("common_5038.png")
        elseif (attrKey == AttConst.DEFENSE) then
            dic.source = self:getCommonPath("common_5039.png")
        elseif (attrKey == AttConst.SPEED) then
            dic.source = self:getCommonPath("common_5041.png")
        end
    end
    return dic.source
end

-- 获取属性权重图标
function getAttrWeightIconUrl(self, attrWeight)
    local dic = self:getDic(self.getAttrWeightIconUrl, attrWeight)
    if (not dic.source) then
        dic.source = "hero_attr_weight_" .. attrWeight .. ".png"
    end
    return dic.source
end

-- 获取军衔图标
function getHeroMilitaryRankIconUrl(self, militaryRankLvl)
    local dic = self:getDic(self.getHeroMilitaryRankIconUrl, militaryRankLvl)
    if (not dic.source) then
        dic.source = "arts/ui/icon/heroMilitaryRank/hero_military_rank_icon_" .. militaryRankLvl .. ".png"
    end
    return dic.source
end

-- 获取英雄队列按钮背景图
function getHeroTeamBtnNormalBgUrl(self, teamId)
    local dic = self:getDic(self.getHeroTeamBtnNormalBgUrl, teamId)
    if (not dic.source) then
        dic.source = "btn_hero_team_normal_" .. teamId .. ".png"
    end
    return dic.source
end

-- 获取英雄队列按钮选中图
function getHeroTeamBtnSelectBgUrl(self, teamId)
    local dic = self:getDic(self.getHeroTeamBtnSelectBgUrl, teamId)
    if (not dic.source) then
        dic.source = "btn_hero_team_select_" .. teamId .. ".png"
    end
    return dic.source
end

-- 获取竞技大厅Bar图
function getArenaHallBarBgUrl(self, arenaHallType)
    local dic = self:getDic(self.getArenaHallBarBgUrl, arenaHallType)
    if (not dic.source) then
        dic.source = "arena_hall_bar_" .. arenaHallType .. ".jpg"
    end
    return dic.source
end

-- 获取竞技大厅Bar标题图
function getArenaHallBarTitleUrl(self, arenaHallType)
    local dic = self:getDic(self.getArenaHallBarTitleUrl, arenaHallType)
    if (not dic.source) then
        dic.source = "arena_hall_bar_title_" .. arenaHallType .. ".png"
    end
    return dic.source
end

-- 获取竞技大厅Bar标题图
function getFormationTileImgUrl(self, tileIndex)
    local dic = self:getDic(self.getFormationTileImgUrl, tileIndex)
    if (not dic.source) then
        local formationTileCount, row, col = formation.FormationManager:getFormationTileCount()
        if (tileIndex > formationTileCount) then
            dic.source = "hero_formation_tile_bg.jpg"
        else
            dic.source = "hero_formation_tile_" .. tileIndex .. ".jpg"
        end
    end
    return dic.source
end

-- 获取玩家头像
function getPlayerHeadUrl(self, avatarId)
    local dic = self:getDic(self.getPlayerHeadUrl, avatarId)
    if (not dic.source) then
        dic.source = self:getIconPath("heroHead/hero_head_" .. avatarId .. ".png")
    end
    return dic.source
end

-- 获取玩家头像框
function getPlayerHeadFrameUrl(self, headFrameName)
    local dic = self:getDic(self.getPlayerHeadFrameUrl, headFrameName)
    if (not dic.source) then
        dic.source = self:getIconPath("playerHeadFrame/" .. headFrameName)
    end
    return dic.source
end

-- 获取玩家动态头像框
function getDynamicHeadFrameUrl(self, headFrameName)
    local dic = self:getDic(self.getDynamicHeadFrameUrl, headFrameName)
    if (not dic.source) then
        dic.source = "arts/fx/ui/dynamicHeadFrame/prefabs/" .. headFrameName
    end
    return dic.source
end

-- 获取玩家称号
function getPlayerTitleUrl(self, titleId)
    local dic = self:getDic(self.getPlayerTitleUrl, titleId)
    if (not dic.source) then
        dic.source = "player_title_icon_" .. titleId .. ".png"
    end
    return dic.source
end

-- 获取竞技场排名图标
function getArenaRankIconUrl(self, rank)
    local dic = self:getDic(self.getArenaRankIconUrl, rank)
    local curIndex = 5248 + rank
    if (not dic.source) then
        if (rank > 3 or rank <= 0) then
            dic.source = self:getCommonNewPath("common_5252.png")
        else
            dic.source = self:getCommonNewPath("common_" .. curIndex .. ".png")
        end
    end
    return dic.source
end

-- 获取主线章节的章节名图片
function getMainMapChapterIconUrl(self, chapterId)
    return "main_map_chapter_title_1.png"
    -- local dic = self:getDic(self.getMainMapChapterIconUrl, chapterId)
    -- if(not dic.source)then
    -- 	dic.source = "main_map_chapter_title_"..chapterId..".png"
    -- end
    -- return dic.source
end

-- 获取主线章节的章节背景图片
function getMainMapChapterBgUrl(self, styleType, chapterId)
    local dic = self:getDic(self.getMainMapChapterBgUrl, styleType .. "_" .. chapterId)
    if (not dic.source) then
        dic.source = self:getBgPath("dup/mainMap/main_map_" .. chapterId .. ".jpg")
    end
    return dic.source
end

-- 获取装备改造部位图标
function getEquipRemakePosIconUrl(self, remakePos)
    local dic = self:getDic(self.getEquipRemakePosIconUrl, remakePos)
    if (not dic.source) then
        dic.source = "hero_base_41_" .. remakePos .. ".png"
    end
    return dic.source
end

-- 获取手环精炼等级图标
function getBraceletsRefineLvlIconUrl(self, isNotYet)
    local dic = self:getDic(self.getBraceletsRefineLvlIconUrl, isNotYet)
    if (not dic.source) then
        if (isNotYet) then
            dic.source = self:getCommonNewPath("common_5238.png")
        else
            dic.source = self:getCommonNewPath("common_5237.png")
        end
    end
    return dic.source
end

-- 获取盟约助手头像小图标
function getHelperHeadIconUrl(self, helperId)
    local dic = self:getDic(self.getHelperHeadIconUrl, helperId)
    if (not dic.source) then
        dic.source = self:getHeroHeadUrl(helperId)
    end
    return dic.source
end

-- 获取迷宫入口图标
function getMazeEnterIconUrl(self, mazeId)
    local dic = self:getDic(self.getMazeEnterIconUrl, mazeId)
    if (not dic.source) then
        dic.source = self:getPackPath(string.format("maze5/maze_enter_%s.png", mazeId))
    end
    return dic.source
end

-- 获取迷宫事件图标
function getMazeEventIconUrl(self, eventType)
    local dic = self:getDic(self.getMazeEventIconUrl, eventType)
    if (not dic.source) then
        dic.source = self:getIconPath(string.format("maze/maze_event_preview_%s.png", eventType))
    end
    return dic.source
end

-- 获取家具预制体路径
function getFurniturePrefabUrl(self, cusName)
    local dic = self:getDic(self.getFurniturePrefabUrl, cusName)
    if (not dic.source) then
        dic.source = string.format("arts/sceneModule/dormitory/prefab/furniture/%s.prefab", cusName)
    end
    return dic.source
end

-- 获取宿舍单片网格预制体路径
function getDormitoryTilePrefabUrl(self, cusName)
    local dic = self:getDic(self.getDormitoryTilePrefabUrl, cusName)
    if (not dic.source) then
        dic.source = string.format("arts/sceneModule/dormitory/prefab/tile/%s.prefab", cusName)
    end
    return dic.source
end

-- 获取宿舍墙体预制体路径
function getDormitoryWallPrefabUrl(self, cusName)
    local dic = self:getDic(self.getDormitoryWallPrefabUrl, cusName)
    if (not dic.source) then
        dic.source = string.format("arts/sceneModule/dormitory/prefab/build/%s.prefab", cusName)
    end
    return dic.source
end

function getBreakUpRankImgUrl(self, cusRank)
    local dic = self:getDic(self.getBreakUpRankImgUrl, cusRank)
    if (not dic.source) then
        dic.source = UrlManager:getPackPath("equipBuild/equip_strengthen_tupo_" .. (cusRank - 1) .. ".png")
    end
    return dic.source
end

--获取buff图标路径
function getBuffIconUrl(self, iconName)
    return self:getIconPath("buff/" .. iconName)
end

-- 获取静态表情路径
function getStaticEmojiUrl(self, index)
    local dic = self:getDic(self.getStaticEmojiUrl, index)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath(string.format("emoji/static/static_%s.png", index))
    end
    return dic.source
end

-- 获取动态表情路径
function getDynamicEmojiUrl(self, index)
    local dic = self:getDic(self.getDynamicEmojiUrl, index)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath(string.format("emoji/dynamic/dynamic_%s.png", index))
    end
    return dic.source
end

-- 获取dna音效路径
function getDnaSoundPath(self, tid, ttype)
    return "arts/audio/UI/dna/" .. string.format("ui_dna_%s_%s.prefab", tid, ttype)
end

function getDnaOtherSoundPath(self, name)
    return "arts/audio/UI/dna/" .. name .. ".prefab"
end

-- 获取dna蛋图标路径
function getDnaEggIconUrl(self, id)
    local dic = self:getDic(self.getDnaEggIconUrl, id)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath(string.format("dna/dna_egg_%s.png", id))
    end
    return dic.source
end

-- 获取dna人形头像路径
function getDnaHeroHeadUrl(self, id)
    local dic = self:getDic(self.getDnaHeroHeadUrl, id)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath(string.format("dna/dna_head_%s.png", id))
    end
    return dic.source
end

-- 获取dna人形形象路径
function getDnaHeroRoleUrl(self, id)
    local dic = self:getDic(self.getDnaHeroRoleUrl, id)
    if (not dic.source) then
        dic.source = UrlManager:getIconPath(string.format("dna/dna_role_%s.png", id))
    end
    return dic.source
end

-- 获取dna人形形象帧动画路径
function getDnaRoleFrameAniUrl(self, id)
    local dic = self:getDic(self.getDnaRoleFrameAniUrl, id)
    if (not dic.source) then
        dic.source = string.format("arts/fx/ui/dnaFrame/prefabs/dna_frame_ani_%s.prefab", id)
    end
    return dic.source
end

-- 获取dna选择蛋item品质背景图
function getDnaEggChoiceItemBgUrl(self, quality)
    local dic = self:getDic(self.getDnaEggChoiceItemBgUrl, quality)
    if (not dic.source) then
        -- quality传入的暂时只有1-3品质 资源美术命名的pnl_05 - 07(显示的品质是倒着来的)
        dic.source = UrlManager:getPackPath(string.format("dna/pnl_0%s.png", 5 + (3 - quality)))
    end
    return dic.source
end

-- 获取dna品质icon
function getDnaGridQualityBg(self, quality)
    local dic = self:getDic(self.getDnaGridQualityBg, quality)
    if (not dic.source) then
        if quality == hero.eggQuality.r then
            dic.source = self:getCommon5Path("common_0175.png")
        elseif quality == hero.eggQuality.sr then
            dic.source = self:getCommon5Path("common_0174.png")
        elseif quality == hero.eggQuality.ssr then
            dic.source = self:getCommon5Path("common_0173.png")
        end
    end
    return dic.source
end

function getRemakeTypeUrl(self, colorType)
    return UrlManager:getPackPath("equipBuild/equip_remake_color_" .. colorType .. ".png")
end

-- 肉鸽buffbg图
function getRorueLikeBuffBg(self, colorType)
    return UrlManager:getPackPath("roguelike/infiniteCity_buff_0" .. colorType .. ".png")
end

-- 肉鸽事件Icon
function getRogueLikeMapIcon(self, type)
    return UrlManager:getPackPath("roguelike/img_item_nor_icon0" .. type .. ".png")
end

-- 无限城道具Icon
function getCycelCollectionIcon(self, source)
    return "arts/ui/icon/cycleEvent/" .. source .. ".png"
end

-- 剧情资源
function getStoryPrefabPath(self)
    return "arts/storyPrefab/"
end

-- 剧情角色
function getStoryCharactorUrl(self, source)
    return "arts/storyPrefab/expression/" .. source .. "/" .. source .. ".png"
end

-- 剧情角色表情
function getStoryCharactorFaceUrl(self, source, index)
    return "arts/storyPrefab/expression/" .. source .. "/" .. source .. "_Face_" .. index .. ".png"
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]