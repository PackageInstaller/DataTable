--[[ 
-----------------------------------------------------
@filename       : GuildTipsPanel
@Description    : 联盟信息界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildTipsPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildTipsPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(94535))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtShowID = self:getChildGO("mTxtShowID"):GetComponent(ty.Text)

    self.mTxtActive = self:getChildGO("mTxtActive"):GetComponent(ty.Text)
    self.mTxtNotice = self:getChildGO("mTxtNotice"):GetComponent(ty.Text)
    self.mTxtGuildLv = self:getChildGO("mTxtGuildLv"):GetComponent(ty.Text)

    self.mTxtMasterName = self:getChildGO("mTxtMasterName"):GetComponent(ty.Text)
    self.mTxtMemberCount = self:getChildGO("mTxtMemberCount"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtRequest = self:getChildGO("mTxtRequest"):GetComponent(ty.Text)
    self.mImgFree = self:getChildGO("mImgFree")

    self.mBtnJoin = self:getChildGO("mBtnJoin")
    self.mBtnJoined = self:getChildGO("mBtnJoined")
end

function initViewText(self)
    self:getChildGO("mTxtMaster"):GetComponent(ty.Text).text = _TT(94524)
    self:getChildGO("mTxtMember"):GetComponent(ty.Text).text = _TT(94523)
    self:getChildGO("mTxtDes"):GetComponent(ty.Text).text = _TT(94512)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnJoin,self.onBtnJoinClickHandler)
end

function onBtnJoinClickHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_GUILD, true) == false then
        return
    end


    if guild.GuildManager:getJoinGuilded() == false then
        local leaveTime = guild.GuildManager:getLeaveTime()
        local needTime = sysParam.SysParamManager:getValue(SysParamType.GUILD_LEAVE_TIME) * 60 * 60
        if GameManager:getClientTime() - leaveTime < needTime then
            local s = TimeUtil.getFormatTimeBySeconds_1(needTime - (GameManager:getClientTime() - leaveTime))
            gs.Message.Show(_TT(94562, s))
            return
        end

        UIFactory:alertMessge(_TT(94582), true, function()
            --table.insert(self.mReqList, self.mSelectData.uid)
            GameDispatcher:dispatchEvent(EventName.REQ_APPLY_GUILD, {
                uid = self.data.uid
            })
            self.mBtnJoin:SetActive(false)
            self.mBtnJoined:SetActive(true)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    else
        if self.data.uid == guild.GuildManager:getGuildInfo().uid then
            gs.Message.Show(_TT(94603))
        else
            gs.Message.Show(_TT(94600))
        end
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.data = args.guildInfo
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
end

function showPanel(self)
    self.mTxtName.text = self.data.name
    self.mTxtShowID.text = "ID："..self.data.show_id
    self.mTxtActive.text = "活跃度:"..self.data.activation
    self.mTxtNotice.text = self.data.notice
    self.mTxtGuildLv.text = "公会等级:  "..self.data.lv
    self.mTxtMasterName.text = self.data.leader_name

    self.mImgIcon:SetImg(UrlManager:getIconPath(guild.GuildManager:getIconDataById(self.data.icon).icon),false)
    self.localData = guild.GuildManager:getGuildData(self.data.lv)
    self.mTxtMemberCount.text = self.data.member_num .. "/"..self.localData.peopleNum
    self.mTxtMemberCount.color = self.data.member_num == self.localData.peopleNum and gs.ColorUtil.GetColor("FFB644FF") or gs.ColorUtil.GetColor("404548FF")
    
    self.mTxtRequest.text = _TT(94508) .. self.data.apply_lv_cond
    self.mImgFree:SetActive(self.data.apply_type == 1)

    self.mBtnJoin:SetActive(true)
    self.mBtnJoined:SetActive(false)
end
return _M