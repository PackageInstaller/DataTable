module("guild.GuildCreateTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildCreateTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mInputName = self:getChildGO("mInputName"):GetComponent(ty.InputField)
    self.mInputInfo = self:getChildGO("mInputInfo"):GetComponent(ty.InputField)

    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtPropsCount = self:getChildGO("mTxtPropsCount"):GetComponent(ty.Text)
    self.mBtnCreate = self:getChildGO("mBtnCreate")
end

function active(self)
    super.active(self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCreate, self.onBtnCreateClick)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(94511)
    self:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(94512)

    self:getChildGO("mInputInfoPlaceholder"):GetComponent(ty.Text).text = _TT(94513)
    self:getChildGO("mInputNamePlaceholder"):GetComponent(ty.Text).text = _TT(94514)
    self:getChildGO("mTxtCreate"):GetComponent(ty.Text).text = _TT(94515)

end

function showPanel(self)
    self.mInputName.characterLimit = sysParam.SysParamManager:getValue(SysParamType.GUILD_NAME_LIMIT)
    self.mInputInfo.characterLimit = sysParam.SysParamManager:getValue(SysParamType.GUILD_NOTICE_LIMIT)

    self.needTid = sysParam.SysParamManager:getValue(SysParamType.GUILD_CREATECOST)[1][1]
    self.needCount = sysParam.SysParamManager:getValue(SysParamType.GUILD_CREATECOST)[1][2]

    self.mImgProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.needTid), false)
    self.mTxtPropsCount.text = self.needCount

    local hasCount = MoneyUtil.getMoneyCountByTid(self.needTid)
    if hasCount >= self.needCount then
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end
end

function onBtnCreateClick(self)

    if guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94596))
        return
    end

    local name = self.mInputName.text
    if not name or name == "" then
        gs.Message.Show(_TT(94583)) -- 请输入名称
        return
    end
    if FilterWordUtil:HasReNameFilterWord(name) then
        gs.Message.Show(_TT(513)) -- "存在敏感字或非法符号"
        return
    end

    local notName = self.mInputInfo.text

    if FilterWordUtil:HasReNameFilterWord(notName) then
        gs.Message.Show(_TT(513)) -- "存在敏感字或非法符号"
        return
    end

    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.needTid, self.needCount, true, true)
    if tips == "" and result == true then

        GameDispatcher:dispatchEvent(EventName.REQ_CREATE_GUILD, {
            name = self.mInputName.text,
            notice = self.mInputInfo.text
        })

    elseif not result then
        UIFactory:alertMessge(tips, true, function()
            if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 and MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) >= ti then
                GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
            end
            --self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
    )
    --gs.Message.Show(tips)
end
end

return _M
