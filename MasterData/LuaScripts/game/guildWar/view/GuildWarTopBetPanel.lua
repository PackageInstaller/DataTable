
--[[ 
-----------------------------------------------------
@Description    : 联盟团战下注界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('guildWar.GuildWarTopBetPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarTopBetPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(149240))
end

function dtor(self)
end

function initData(self)
    self.mPropsList = {}
end

-- 初始化
function configUI(self)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mTxtWReward = self:getChildGO("mTxtWReward"):GetComponent(ty.Text)
    self.mTxtLReward = self:getChildGO("mTxtLReward"):GetComponent(ty.Text)

    self.mImgIcon1 = self:getChildGO("mImgIcon1"):GetComponent(ty.AutoRefImage)
    self.mImgIcon2 = self:getChildGO("mImgIcon2"):GetComponent(ty.AutoRefImage)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtLv1 = self:getChildGO("mTxtLv1"):GetComponent(ty.Text)
    self.mTxtLv2 = self:getChildGO("mTxtLv2"):GetComponent(ty.Text)
   
    self.mFinalImgBg = self:getChildGO("mFinalImgBg"):GetComponent(ty.RectTransform)
    self.mImgFinalPro = self:getChildGO("mImgFinalPro"):GetComponent(ty.RectTransform)

    self.mTxtPro1 = self:getChildGO("mTxtPro1"):GetComponent(ty.Text)
    self.mTxtPro2 = self:getChildGO("mTxtPro2"):GetComponent(ty.Text)

    self.mTxtSelect1 = self:getChildGO("mTxtSelect1"):GetComponent(ty.Text)
    self.mTxtSelect2 = self:getChildGO("mTxtSelect2"):GetComponent(ty.Text)
    self.mBtnSelect1 = self:getChildGO("mBtnSelect1")
    self.mBtnSelect2 = self:getChildGO("mBtnSelect2")

    self.mSelectDef1 = self:getChildGO("mSelectDef1")
    self.mSelectDef2 = self:getChildGO("mSelectDef2")

    self.mSelect1 = self:getChildGO("mSelect1")
    self.mSelect2 = self:getChildGO("mSelect2")

    self.mWPropsContent = self:getChildTrans("mWPropsContent")
    self.mLPropsContent = self:getChildTrans("mLPropsContent")
  
    self.mBtnCanle = self:getChildGO("mBtnCanle"):GetComponent(ty.Button)
    self.mBtnSure = self:getChildGO("mBtnSure"):GetComponent(ty.Button)
end

function initViewText(self)
    self.mTxtTips.text = _TT(149241)
    self.mTxtWReward.text = _TT(149242)
    self.mTxtLReward.text = _TT(149243)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSelect1,self.selectBetChange,nil,1)
    self:addUIEvent(self.mBtnSelect2,self.selectBetChange,nil,2)

    self:addUIEvent(self.mBtnCanle,function()
        self:close()
    end)
    self:addUIEvent(self.mBtnSure,function()
        local day =  guildWar.GuildWarManager:getGuildWarTopSelectDay()
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_TOP_BET,{
            groupId = self.info.group_id,
            day = day,
            betUid = self.selectBetUid,
        })
        self:close()
    end)
end

function active(self, args)
    super.active(self)
    self.info = args
    --GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_TOP_INFO, args)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearPropsList()
end

function showPanel(self)
    local url = guild.GuildManager:getIconDataById(self.info.team_1_icon).icon
    self.mImgIcon1:SetImg(UrlManager:getIconPath(url), false)
    self.mTxtName1.text = self.info.team_1_name
    self.mTxtLv1.text = "Lv."..self.info.team_1_lv
    
    url = guild.GuildManager:getIconDataById(self.info.team_2_icon).icon
    self.mImgIcon2:SetImg(UrlManager:getIconPath(url), false)
    self.mTxtName2.text = self.info.team_2_name
    self.mTxtLv2.text = "Lv."..self.info.team_2_lv

    local bet1 = self.info.team_1_bet_num + 50
    local bet2 = self.info.team_2_bet_num + 50

    local pro1 = bet1 / (bet1 + bet2) * 100
    local pro2 = bet2 / (bet1 + bet2) * 100
    self.mTxtPro1.text = string.format("%.2f",pro1).."%"
    self.mTxtPro2.text = string.format("%.2f",pro2).."%"

    gs.TransQuick:SizeDelta01(self.mImgFinalPro,self.mFinalImgBg.sizeDelta.x * pro1 / 100)
    
    local betInfo = guildWar.GuildWarManager:getBetInfo(self.info)
    self.betUid = 0
    for i = 1 ,#betInfo do
        if betInfo[i].group_id == self.info.group_id then
            self.betUid = betInfo[i].bet_uid
            break
        end
    end
    self.selectBet = 1
    if self.betUid ~= 0 then
        if self.betUid == self.info.team_1 then
            self.selectBet = 1
        else
            self.selectBet = 2
        end
    end

 
    self:clearPropsList()

    local day =  guildWar.GuildWarManager:getGuildWarTopSelectDay()
    local awardVo = guildWar.GuildWarManager:getGuildAwardBetAward(day)
    for i = 1,#awardVo.successAward do
        local propGrid = PropsGrid:createByData({ tid = awardVo.successAward[i][1], num = awardVo.successAward[i][2], parent =self.mWPropsContent, scale = 0.6, showUseInTip = true })
        table.insert(self.mPropsList, propGrid)
    end

    for i = 1,#awardVo.failAward do
        local propGrid = PropsGrid:createByData({ tid = awardVo.failAward[i][1], num = awardVo.failAward[i][2], parent =self.mLPropsContent, scale = 0.6, showUseInTip = true })
        table.insert(self.mPropsList, propGrid)
    end


    self:selectBetChange(self.selectBet)
end

function clearPropsList(self)
    for i = 1, #self.mPropsList, 1 do
        self.mPropsList[i]:poolRecover()
    end
    self.mPropsList = {}
end

function selectBetChange(self,betId)
    self.mTxtSelect1.text = betId == 1 and _TT(149244) or _TT(149245)
    self.mTxtSelect2.text = betId == 2 and _TT(149244) or _TT(149245)

    self.mSelectDef1:SetActive(betId ~= 1)
    self.mSelectDef2:SetActive(betId ~= 2)

    self.mSelect1:SetActive(betId == 1)
    self.mSelect2:SetActive(betId == 2)

    self.selectBetUid = betId == 1 and self.info.team_1 or self.info.team_2


    if self.betUid == 0 then
        self.mBtnSure.interactable = true
        self.mBtnSure:GetComponent(ty.Image).raycastTarget = true
    else 
        if betId == 1 then
            self.mBtnSure:GetComponent(ty.Image).raycastTarget = self.betUid ~= self.info.team_1
             self.mBtnSure.interactable = self.betUid ~= self.info.team_1
        elseif betId == 2 then
            self.mBtnSure:GetComponent(ty.Image).raycastTarget = self.betUid ~= self.info.team_2
            self.mBtnSure.interactable = self.betUid ~= self.info.team_2
        end
    end
end

return _M