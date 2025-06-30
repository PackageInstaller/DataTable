module("guild.GuildRequestItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBg = self:getChildGO("mBg")
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mBtnAccept = self:getChildGO("mBtnAccept")
    self.mBtnJump = self:getChildGO("mBtnJump")
end


function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAccept, self.onAcceptClick)
    self:addUIEvent(self.mBtnJump, self.onJumpClick)
end

function onAcceptClick(self)

    -- if guild.GuildManager:getGuildBossIsOpen() then
    --     gs.Message.Show(_TT(94594))
    --     return
    -- end
    
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_ARGEE_APPLY, {
        applyPlayerId = self.data.player_id
    })
end

function onJumpClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_REJECT_APPLY, {
        applyPlayerId = self.data.player_id
    })
end

-- function onBgClick(self)
--     GameDispatcher:dispatchEvent(EventName.ONCLICK_GUILD_SEARCHITEM, self.mData)
-- end

function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, {
        id = self.data.player_id
    })
end

function setData(self, data)
    super.setData(self, data)
    self.mData = data

    if self.mPlayerHeadGrid == nil then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end

    self.mPlayerHeadGrid:setData(data.avatar_id)
    self.mPlayerHeadGrid:setHeadFrame(data.avatar_frame_id)
    self.mPlayerHeadGrid:setScale(0.4)
    self.mPlayerHeadGrid:setParent(self.mHeadContent)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)

    self.mTxtName.text = data.player_name
    self.mTxtLv.text = _TT(1003).. data.player_lv
    -- self.mTxtTime.text = data.is_online == 1 and _TT(25126) or TimeUtil.getTimeDescToDate(data.is_online)
end

function onDelete(self)
    super.onDelete(self)

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

return _M
