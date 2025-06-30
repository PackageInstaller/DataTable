--[[
-----------------------------------------------------
@filename       : GuildChangeIconPanel
@Description    : 联盟改名界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildChangeIconPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildChangeIconPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(834, 334)
    self:setTxtTitle(_TT(149187))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.mIconItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtPropsCount = self:getChildGO("mTxtPropsCount"):GetComponent(ty.Text)

    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")

    self.mIconScroll = self:getChildGO("mIconScroll"):GetComponent(ty.ScrollRect)
    self.mIconItem = self:getChildGO("mIconItem")
end

function initViewText(self)
    self.mTxtTips.text = _TT(149188)
    self:getChildGO("mTxtCancel"):GetComponent(ty.Text).text = _TT(2)
    self:getChildGO("mTxtConfirm"):GetComponent(ty.Text).text = _TT(1)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.close)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirm)
end

function onClickConfirm(self)
    if self.openType == 1 then
        if guild.GuildManager:getIsJoinGuildWar() then
            gs.Message.Show(_TT(149213))
            return
        end

        -- local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.needTid, self.needCount, true, true)
        -- if tips == "" and result == true then
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_CHANGE_ICON, {
                iconId = self.curId
            })
        -- else
        --     gs.Message.Show(tips)
        -- end
    else
        guild.GuildManager:setTempIconId(self.curId)
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_CHANGE_ICON_TEMP)
        self:close()
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.openType = args.type
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    self:clearIconItemList()
end

function showPanel(self)
    self.mTxtPropsCount.gameObject:SetActive(self.openType == 1)
    self.needTid = sysParam.SysParamManager:getValue(SysParamType.GUILD_ICON_CHANGE_NEED)[1][1]
    self.needCount = sysParam.SysParamManager:getValue(SysParamType.GUILD_ICON_CHANGE_NEED)[1][2]

    self.mImgProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.needTid), false)
    self.mTxtPropsCount.text = self.needCount

    local hasCount = MoneyUtil.getMoneyCountByTid(self.needTid)
    if hasCount >= self.needCount then
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end

    local dic = guild.GuildManager:getIconData()
    local list = {}
    for id, vo in pairs(dic) do
        table.insert(list, vo)
    end

    table.sort(list,function (vo1,vo2)
        return vo1.id<vo2.id
    end)

    self:clearIconItemList()
    
    if self.openType == 1 then
        self.curId  = guild.GuildManager:getGuildIconId()
    else
        self.curId = guild.GuildManager:getTempId()
    end

    for i = 1, #list do
        local item = SimpleInsItem:create(self.mIconItem, self.mIconScroll.content, "mIconItem")
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(list[i].icon), false)
        item:getChildGO("mIconSelect"):SetActive(self.curId  == list[i].id)

        item:addUIEvent("mBtnClick", function()
            self.curId = list[i].id
            for i = 1, #self.mIconItemList, 1 do
                self.mIconItemList[i]:getChildGO("mIconSelect"):SetActive(self.curId  == list[i].id)
            end
        end)
        table.insert(self.mIconItemList, item)
    end
end

function clearIconItemList(self)
    for i = 1, #self.mIconItemList, 1 do
        self.mIconItemList[i]:poolRecover()
    end
    self.mIconItemList = {}
end

return _M