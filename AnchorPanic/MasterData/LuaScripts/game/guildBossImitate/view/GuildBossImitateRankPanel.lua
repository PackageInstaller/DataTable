-- @FileName:   GuildBossImitateRankPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-07 20:37:09
-- @Copyright:   (LY) 2023 雷焰网络

module("game.guildBossImitate.view.GuildBossImitateRankPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("guildBossImitate/GuildBossImitateRankPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1-- 窗口类型 1 全屏 2 弹窗

--是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(108003))
    self:setBg("")
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)

    self.GroupTabItem = self:getChildGO("GroupTabItem")
    self.TabBarNode = self:getChildTrans("TabBarNode")

    self.subTabItem = self:getChildGO("subTabItem")
    self.subTabGroup = self:getChildTrans("subTabGroup")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDamage = self:getChildGO("mTxtDamage"):GetComponent(ty.Text)
    self.mTxtInfoRankBig = self:getChildGO("mTxtInfoRankBig"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRank_02 = self:getChildGO("mTxtRank_02"):GetComponent(ty.Text)

    self.mLyScroll = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mLyScroll:SetItemRender(guildBossImitate.GuildBossImitateRankItem)

    self.mHeadGridNode = self:getChildTrans("mHeadGridNode")

    self.mImgNo = self:getChildGO("mImgNo")
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTextTitle_1"):GetComponent(ty.Text).text = _TT(108012)
    self:getChildGO("mTextTitle_2"):GetComponent(ty.Text).text = _TT(108013)
    self:getChildGO("mTextTitle_3"):GetComponent(ty.Text).text = _TT(108014)
end

-- 设置货币栏
function setMoneyBar(self)
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.RECEIVE_GUILDBOSSIMITATE_RANKDATA, self.refreshView, self)

    self:createTabItem()

    local dupId = guildBossImitate.GuildBossImitateManager:getSaveCacheDupId()
    local dupConfig = guildBossImitate.GuildBossImitateManager:getDupConfig(dupId)
    for _, _item in pairs(self.m_tabItemList) do
        if _item.m_data == dupConfig.weakness_ele then
            _item:select()
            break
        end
    end

    for _, _item in pairs(self.m_subTabItemList) do
        if _item.m_data == dupConfig.difficulty then
            _item:select()
            break
        end
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.RECEIVE_GUILDBOSSIMITATE_RANKDATA, self.refreshView, self)

    self:clearTabItem()

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    self.m_selectLevel = nil
    self.m_selectAttr = nil
end

function createTabItem(self)
    self.m_tabItemList = {}

    local attrConfigList = guildBossImitate.GuildBossImitateManager:getAttrConfigList()
    for _, attr in pairs(attrConfigList) do
        local item = SimpleInsItem:create(self.GroupTabItem, self.TabBarNode, "GuildBossImitateRankPanel_tabItem")
        item.m_data = attr
        table.insert(self.m_tabItemList, item)

        local color, name = hero.getHeroTypeName(attr)
        local heroTypeLable = string.format("<color=%s>%s</color>", color, name)
        local heroTypeImage = UrlManager:getHeroEleTypeIconUrl(attr)
        item:getChildGO("mImgNomalIcon"):GetComponent(ty.AutoRefImage):SetImg(heroTypeImage, false)
        item:getChildGO("mTxtNomal"):GetComponent(ty.Text).text = heroTypeLable

        item:getChildGO("mImgSelectIcon"):GetComponent(ty.AutoRefImage):SetImg(heroTypeImage, false)
        item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = heroTypeLable

        item:addUIEvent("mBtnNomal", function ()
            for _, _item in pairs(self.m_tabItemList) do
                _item:unSelect()
            end

            item:select()
        end)

        item.unSelect = function (_item)
            _item:getChildGO("mBtnSelect"):SetActive(false)
        end

        item.select = function (_item)
            _item:getChildGO("mBtnSelect"):SetActive(true)

            self.m_selectAttr = attr
            self:onReqRankData()
        end

        item:unSelect()
    end

    self.m_subTabItemList = {}
    local levelConfigList = guildBossImitate.GuildBossImitateManager:getLevelConfigList()
    for _, level in pairs(levelConfigList) do
        local item = SimpleInsItem:create(self.subTabItem, self.subTabGroup, "GuildBossImitateRankPanel_subTabItem")
        item.m_data = level

        table.insert(self.m_subTabItemList, item)

        local lable = level .. "级"
        item:getChildGO("mTextNormalLabel"):GetComponent(ty.Text).text = lable
        item:getChildGO("mTextSelectLabel"):GetComponent(ty.Text).text = lable

        item:addUIEvent("mNormal", function ()
            for _, _item in pairs(self.m_subTabItemList) do
                _item:unSelect()
            end

            item:select()
        end)

        item.unSelect = function (_item)
            _item:getChildGO("mSelect"):SetActive(false)
        end

        item.select = function (_item)
            _item:getChildGO("mSelect"):SetActive(true)

            self.m_selectLevel = level
            self:onReqRankData()
        end

        item:unSelect()
    end

end

function clearTabItem(self)
    for _, _item in pairs(self.m_subTabItemList) do
        _item:poolRecover()
    end
    self.m_subTabItemList = {}

    for _, _item in pairs(self.m_tabItemList) do
        _item:poolRecover()
    end
    self.m_tabItemList = {}
end

function onReqRankData(self)
    if not self.m_selectLevel or not self.m_selectAttr then
        return
    end

    self.m_selectDupId = 0
    local dupConfigDic = guildBossImitate.GuildBossImitateManager:getDupConfigDic()
    for dup_id, dupConfigVo in pairs(dupConfigDic) do
        if dupConfigVo.difficulty == self.m_selectLevel and dupConfigVo.weakness_ele == self.m_selectAttr then
            self.m_selectDupId = dup_id
            break
        end
    end

    GameDispatcher:dispatchEvent(EventName.REQ_GUILDBOSSIMITATE_RANKDATA, self.m_selectDupId)
end

function refreshView(self, args)
    if args.dup_id ~= self.m_selectDupId then
        return
    end

    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHeadGrid:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.mPlayerHeadGrid:setParent(self.mHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    self.mPlayerHeadGrid:setScale(1)

    self.mTxtName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.mTxtDamage.text = args.my_rank_val

    self.mTxtInfoRankBig.gameObject:SetActive(args.my_rank <= 10 and args.my_rank ~= 0)
    self.mTxtInfoRankBig.text = args.my_rank
    self.mTxtRank.gameObject:SetActive(args.my_rank > 10)
    self.mTxtRank_02.gameObject:SetActive(args.my_rank <= 0)

    if args.my_rank <= 3 and args.my_rank > 0 then
        self.mTxtRank.text = ""
    elseif args.my_rank <= 100 then
        self.mTxtRank.text = args.my_rank
    else
        self.mTxtRank.text = "<size=24>" .. args.my_rank .. "</size>"
    end

    local list = {}
    for i = 1, #args.rank_list do
        table.insert(list, args.rank_list[i])
    end

    table.sort(list, function(a, b)
        return a.rank < b.rank
    end)

    local len = math.min(4, #list)
    for i = 1, len do
        list[i].tweenId = i * 3.5
    end

    if (self.mLyScroll.Count <= 0) then
        self.mLyScroll.DataProvider = list
    else
        self.mLyScroll:ReplaceAllDataProvider(list)
    end

    self.mImgNo:SetActive(table.empty(list))
end

return _M
