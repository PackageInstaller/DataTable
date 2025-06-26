--[[
-----------------------------------------------------
@filename       : GuildReNamePanel
@Description    : 联盟改名界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildReNamePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildReNamePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(834, 334)
    self:setTxtTitle("联盟名称")
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mInputFieldName = self:getChildGO("mInputFieldName"):GetComponent(ty.InputField)
    self.mImgProps = self:getChildGO("mImgProps"):GetComponent(ty.AutoRefImage)
    self.mTxtPropsCount = self:getChildGO("mTxtPropsCount"):GetComponent(ty.Text)

    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
end

function initViewText(self)
    -- self.mScoreTitle.text = _TT(44657) --"EMAIL LIST"
    self:getChildGO("mInputPlaceholder"):GetComponent(ty.Text).text = _TT(94514)

    self:getChildGO("mTxtConfirm"):GetComponent(ty.Text).text = _TT(1)

end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.close)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirm)
end

function onClickConfirm(self)

    if guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94602))
        return
    end

    if guild.GuildManager:getIsJoinGuildWar() then
        gs.Message.Show(_TT(149213))
        return
    end

    local newName = self.mInputFieldName.text
    if not newName or newName == "" then
        gs.Message.Show(_TT(94583)) --请输入名称
        return
    end

    if FilterWordUtil:HasReNameFilterWord(newName) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end

    -- local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.needTid, self.needCount, true, true)
    -- if tips == "" and result == true then
        GameDispatcher:dispatchEvent(EventName.REQ_RANAME_GUILD, {
            name = self.mInputFieldName.text
        })
    -- else
    --     gs.Message.Show(tips)
    -- end

end
-- 激活
function active(self, args)
    super.active(self, args)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
end

function showPanel(self)

    self.mInputFieldName.characterLimit = sysParam.SysParamManager:getValue(SysParamType.GUILD_NAME_LIMIT)

    self.needTid = sysParam.SysParamManager:getValue(SysParamType.GUILD_RENAMECOST)[1][1]
    self.needCount = sysParam.SysParamManager:getValue(SysParamType.GUILD_RENAMECOST)[1][2]

    self.mImgProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(self.needTid), false)
    self.mTxtPropsCount.text = self.needCount

    local hasCount = MoneyUtil.getMoneyCountByTid(self.needTid)
    if hasCount >= self.needCount then
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtPropsCount.color = gs.ColorUtil.GetColor("f94234ff")
    end
end

return _M
