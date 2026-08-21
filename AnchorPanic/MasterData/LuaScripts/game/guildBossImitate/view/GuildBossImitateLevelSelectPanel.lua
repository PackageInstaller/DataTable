-- @FileName:   GuildBossImitateLevelSelectPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-07 20:09:42
-- @Copyright:   (LY) 2023 雷焰网络

module("game.guildBossImitate.view.GuildBossImitateLevelSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('guildBossImitate/GuildBossImitateLevelSelectPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 518)
    self:setTxtTitle(_TT(108002))
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mItemLevel = self:getChildGO("mItemLevel")
    self.mItemAttr = self:getChildGO("mItemAttr")

    self.mLevelGroup = self:getChildTrans("mLevelGroup")
    self.mAttrGroup = self:getChildTrans("mAttrGroup")
    self.mBtnSure = self:getChildGO("mBtnSure")

    self.mTextTitleLevel = self:getChildGO("mTextTitleLevel"):GetComponent(ty.Text)
    self.mTextTitleAttr = self:getChildGO("mTextTitleAttr"):GetComponent(ty.Text)

end

function initViewText(self)
    self.mTextTitleLevel.text = _TT(108005)
    self.mTextTitleAttr.text = _TT(108006)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onSure)
end

-- 激活
function active(self, args)
    super.active(self, args)

    self:createItem()
    local dupId = guildBossImitate.GuildBossImitateManager:getSaveCacheDupId()
    local dupConfig = guildBossImitate.GuildBossImitateManager:getDupConfig(dupId)
    for _, _item in pairs(self.m_attrItemList) do
        if _item.m_data == dupConfig.weakness_ele then
            _item:select()
            break
        end
    end

    for _, _item in pairs(self.m_levelItemList) do
        if _item.m_data == dupConfig.difficulty then
            _item:select()
            break
        end
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)

    self:clearItem()
end

function onSure(self)
    local selectDupId = 0
    local dupConfigDic = guildBossImitate.GuildBossImitateManager:getDupConfigDic()
    for dup_id, dupConfigVo in pairs(dupConfigDic) do
        if dupConfigVo.difficulty == self.m_selectLevel and dupConfigVo.weakness_ele == self.m_selectAttr then
            selectDupId = dup_id
            break
        end
    end

    guildBossImitate.GuildBossImitateManager:saveCacheDupId(selectDupId)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILDBOSSIMITATE_DUPINFO, selectDupId)

    self:close()
end

function createItem(self)
    local attrConfigList = guildBossImitate.GuildBossImitateManager:getAttrConfigList()
    local levelConfigList = guildBossImitate.GuildBossImitateManager:getLevelConfigList()

    self.m_attrItemList = {}
    for _, attr in pairs(attrConfigList) do
        local item = SimpleInsItem:create(self.mItemAttr, self.mAttrGroup, "GuildBossImitateLevelSelectPanel_attrItem")
        item.m_data = attr
        table.insert(self.m_attrItemList, item)

        local color, name = hero.getHeroTypeName(attr)
        item:setText("mTextLable", nil, string.format("<color=%s>%s</color>", color, name))
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(attr), true)

        item:addUIEvent(nil, function ()
            for _, _item in pairs(self.m_attrItemList) do
                _item:unSelect()
            end
            item:select()
        end)

        item.unSelect = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(false)
        end

        item.select = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(true)
            self.m_selectAttr = item.m_data
        end

        item:unSelect()
    end

    self.m_levelItemList = {}
    for _, level in pairs(levelConfigList) do
        local item = SimpleInsItem:create(self.mItemLevel, self.mLevelGroup, "GuildBossImitateLevelSelectPanel_levelItem")
        item.m_data = level
        table.insert(self.m_levelItemList, item)

        item:setText("mTextLable", nil, level .. "级")

        item:addUIEvent(nil, function ()
            for _, _item in pairs(self.m_levelItemList) do
                _item:unSelect()
            end
            item:select()
        end)

        item.unSelect = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(false)
        end

        item.select = function (_item)
            _item:getChildGO("mImgSelect"):SetActive(true)
            self.m_selectLevel = item.m_data
        end

        item:unSelect()
    end
end

function clearItem(self)
    for _, _item in pairs(self.m_attrItemList) do
        _item:poolRecover()
    end
    self.m_attrItemList = {}

    for _, _item in pairs(self.m_levelItemList) do
        _item:poolRecover()
    end
    self.m_levelItemList = {}
end

return _M
