-------------------------------------------------------------------------------
-- 社团 - 社团主页 - 信息面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-30 20:40:29
-------------------------------------------------------------------------------

local DeviceID        = CS.Engine.Http.DeviceID
local LayoutUtility   = CS.UnityEngine.UI.LayoutUtility
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local LogListCellName = 'DescNode'

local ROOT_ANIM_NAME = {
    IDLE = 'OverseaClubOverallInformationDialog_Idle',
    SHOW = 'OverseaClubOverallInformationDialog_Entry',
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubOverallInformationDialog.prefab > name: OverseaClubOverallInformationDialog
---@class UIOverseaClubEntryInformationPanel
---@field Env                           	UIOverseaClubEntryInformationPanel      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 0    动画根节点
---@field clubLogTxt                    	UnityEngine.RectTransform               	@ 1    社团日志文本
---@field clubLogList                   	SuperScrollView.LoopListView2           	@ 2    社团日志列表
---@field clubChatBtn                   	UnityEngine.RectTransform               	@ 3    
---@field clubShopBtn                   	UnityEngine.RectTransform               	@ 4    
---@field noticeModifyBtn               	UnityEngine.RectTransform               	@ 5    修改公告按钮
---@field noticeModifyNode              	UnityEngine.RectTransform               	@ 6    修改公告节点
---@field noticeContentTxt              	UnityEngine.RectTransform               	@ 7    公告内容文本
---@field noticeScrollView              	UnityEngine.RectTransform               	@ 8    公告滚动节点
---@field applyInfoTxt                  	UnityEngine.RectTransform               	@ 9    申请信息文本
---@field memberNumTxt                  	UnityEngine.RectTransform               	@ 10   成员数量文本
---@field clubExpSlider                 	UnityEngine.UI.Slider                   	@ 11   社团经验滑块
---@field clubExpTxt                    	UnityEngine.RectTransform               	@ 12   社团经验文本
---@field clubLevelTxt                  	UnityEngine.RectTransform               	@ 13   社团等级文本
---@field clubIdCopyBtn                 	UnityEngine.RectTransform               	@ 14   社团id复制按钮
---@field clubIdTxt                     	UnityEngine.RectTransform               	@ 15   社团id文本
---@field clubNameTxt                   	UnityEngine.RectTransform               	@ 16   社团名字文本
---@field infoModifyBtn                 	UnityEngine.RectTransform               	@ 17   信息修改按钮
---@field clubHeadImg                   	UnityEngine.RectTransform               	@ 18   社团头像图片
---@field BtnRecruit                    	UnityEngine.RectTransform               	@ 19   这团招募按钮
local UIOverseaClubEntryInformationPanel = Class('UIOverseaClubEntryInformationPanel')


function UIOverseaClubEntryInformationPanel:__init()
end


function UIOverseaClubEntryInformationPanel:__delete()
end


function UIOverseaClubEntryInformationPanel:Awake()
end


function UIOverseaClubEntryInformationPanel:Start()
    SetButtonAction(self.infoModifyBtn, Bind(self, self.OnClickInfoModifyButtonHandler_))
    SetButtonAction(self.noticeModifyBtn, Bind(self, self.OnClickNoticeModifyButtonHandler_))
    SetButtonAction(self.clubIdCopyBtn, Bind(self, self.OnClickCopyClubIdButtonHandler_))
    SetButtonAction(self.BtnRecruit, Bind(self, self.OnBtnRecruitButtonHandler_))
    SetListViewAction(self.clubLogList, Bind(self, self.OnUpdateClubLogListCellHandler_))
    
    self.updateExpEventCB_     = Events.AddListener(ClubUtils.EventName.UPDATE_EXP, Bind(self, self.OnClubUpdateExpHandler_))
    self.updateInfoEventCB_    = Events.AddListener(ClubUtils.EventName.UPDATE_INFO, Bind(self, self.OnClubUpdateInfoHandler_))
    self.updateNameEventCB_    = Events.AddListener(ClubUtils.EventName.UPDATE_NAME, Bind(self, self.OnClubUpdateNameHandler_))
    self.updateNoticeEventCB_  = Events.AddListener(ClubUtils.EventName.UPDATE_NOTICE, Bind(self, self.OnClubUpdateNoticeHandler_))
    self.updateMembersEventCB_ = Events.AddListener(ClubUtils.EventName.UPDATE_MEMBERS, Bind(self, self.OnClubUpdateMembersHandler_))

    if self:GetInitParams().tabSelectIndex then
        CfUtils.PlayAnimation(self.AnimRoot, ROOT_ANIM_NAME.IDLE)
    else
        CfUtils.PlayAnimation(self.AnimRoot, ROOT_ANIM_NAME.SHOW)
    end

    if self:GetOnStartCB() then
        self:GetOnStartCB()()
    end
end


function UIOverseaClubEntryInformationPanel:OnDestroy()
    Events.RemoveListener(ClubUtils.EventName.UPDATE_EXP, self.updateExpEventCB_)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_INFO, self.updateInfoEventCB_)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_NAME, self.updateNameEventCB_)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_NOTICE, self.updateNoticeEventCB_)
    Events.RemoveListener(ClubUtils.EventName.UPDATE_MEMBERS, self.updateMembersEventCB_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return fun():void
function UIOverseaClubEntryInformationPanel:GetOnStartCB()
    return self.startCallback_
end
function UIOverseaClubEntryInformationPanel:SetOnStartCB(callback)
    self.startCallback_ = callback
end


---@return table
function UIOverseaClubEntryInformationPanel:GetInitParams()
    return self.initParams_
end
function UIOverseaClubEntryInformationPanel:SetInitParams(parasm)
    self.initParams_ = checkTable(parasm)
end


---@return table[]
function UIOverseaClubEntryInformationPanel:GetLogDataList()
    return checkTable(self.logDataList_)
end
function UIOverseaClubEntryInformationPanel:SetLogDataList(dataList)
    self.logDataList_ = checkTable(dataList)
    self:UpdateLogListView_()
end


-------------------------------------------------
-- public

function UIOverseaClubEntryInformationPanel:RefreshPanel()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    CfUtils.FillText(self.clubIdTxt, clubHomeDojo.clubId)
    
    -- switch job function
    local myMemberDojo   = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
    local isModifyInfo   = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.MODIFY_INFO)
    local isModifyNotice = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.MODIFY_NOTICE)
    local isRecruit      = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.CLUB_RECRUIT)

    CfUtils.SetActive(self.BtnRecruit, isRecruit)
    CfUtils.SetActive(self.noticeModifyNode, isModifyNotice)
    CfUtils.SetActive(self.infoModifyBtn, isModifyInfo)

    -- set clubLogDay tips
    -- local logStashDay = ClubUtils.GetParamValue(ClubUtils.ParamsId.LOG_STASH_DAY)
    -- CfUtils.FillText(self.clubLogTxt, localize('社团日志（最近_num_天）', {_num_ = logStashDay}))
    
    -- update all info
    self:UpdateClubBaseInfo_()
    self:UpdateClubNameInfo_()
    self:UpdateClubNoticeInfo_()
    self:UpdateClubLevelInfo_()
    
    -- refresh club log
    local requestData = {}
    GameUtils.Request(Interfaces.OverseaClubHomeLog, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local logDataList1 = checkTable(responseData.log)
            local logDataList2 = {}
            -- reverse logData
            for logIndex = 1, #logDataList1 do
                logDataList2[logIndex] = table.remove(logDataList1)
            end
            self:SetLogDataList(logDataList2)
        end
    end)
end


-------------------------------------------------
-- private

function UIOverseaClubEntryInformationPanel:UpdateClubBaseInfo_()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local clubHeadVo = ClubUtils.GetClubHeadVo(clubHomeDojo.avatar)
    CfUtils.FillImage(self.clubHeadImg, clubHeadVo.photoPath)

    local applyLevel = clubHomeDojo.applyLevel
    local isFreeType = clubHomeDojo.applyType == ClubUtils.ApplyType.FREE
    local applyText  = ''
    if isFreeType then
        applyText = localize('_num_级以上，自由加入', {_num_ = applyLevel})
    else
        applyText = localize('_num_级以上，需要审核', {_num_ = applyLevel})
    end
    CfUtils.FillText(self.applyInfoTxt, applyText)
end


function UIOverseaClubEntryInformationPanel:UpdateClubNameInfo_()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    CfUtils.FillText(self.clubNameTxt, clubHomeDojo.name)
end


function UIOverseaClubEntryInformationPanel:UpdateClubNoticeInfo_()
    local clubHomeDojo   = ClubUtils.GetClubComp():GetHomeDojo()
    local clubNoticeText = string.isEmpty(clubHomeDojo.notice) and localize('欢迎加入~') or clubHomeDojo.notice
    CfUtils.FillText(self.noticeContentTxt, clubNoticeText)
end


function UIOverseaClubEntryInformationPanel:UpdateClubLevelInfo_()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    CfUtils.FillText(self.clubLevelTxt, clubHomeDojo.level)

    if clubHomeDojo.level >= ClubUtils.GetLevelMax() then
        CfUtils.FillText(self.clubExpTxt, '')
        CfUtils.SetSliderPercent(self.clubExpSlider, 1)
    else
        local curtTotalExp  = ClubUtils.GetLevelExp(clubHomeDojo.level)
        local nextTotalExp  = ClubUtils.GetLevelExp(clubHomeDojo.level + 1)
        local curtProgress  = math.max(clubHomeDojo.contributionPoint - curtTotalExp, 0)
        local totalProgress = math.max(nextTotalExp - curtTotalExp)
        CfUtils.FillText(self.clubExpTxt, string.fmt('%1/%2', curtProgress, totalProgress))
        CfUtils.SetSliderPercent(self.clubExpSlider, curtProgress / totalProgress)
    end

    self:UpdateClubMembersInfo_()
end


function UIOverseaClubEntryInformationPanel:UpdateClubMembersInfo_()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local clubLevelVo  = ClubUtils.GetLevelVo(clubHomeDojo.level)
    CfUtils.FillText(self.memberNumTxt, string.fmt('%1/%2', #clubHomeDojo.memberList, clubLevelVo.members))
end


function UIOverseaClubEntryInformationPanel:UpdateLogListView_()
    local listDataLegnth = #self:GetLogDataList()
    GameUtils.ReloadData(self.clubLogList, listDataLegnth)
    -- scroll to last
    self.clubLogList:MovePanelToItemIndex(listDataLegnth)
end


-------------------------------------------------
-- handler

function UIOverseaClubEntryInformationPanel:OnBtnRecruitButtonHandler_()
    GameUtils.Request(Interfaces.OverseaClubRecruitTime,{},function(request,response)
        if response.errCode == 0 then
            local leaveTime = response.data.dailyRecruitTimes
            if leaveTime > 0 then
                GameUtils.SecondConfirm(localize("是否在招募频道发布招募信息？"),function()
                    GameUtils.Request(Interfaces.OverseaClubRecruit,{},function(request,response)
                        if response.errCode == 0 then
                        end
                    end)
                end,nil,localize("(今日剩余免费次数：_num_)",{_num_ = leaveTime}))
            else
                local consumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.Recruit_ConsumeId)
                local consumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.Recruit_ConsumeNum)
                GameUtils.SecondConfirm(localize("是否消耗以下道具在招募频道发布招募信息？"),function()
                    local haveNum = GoodsUtils.GetThingNo(consumeId)
                    if haveNum >= consumeNum then
                        GameUtils.Request(Interfaces.OverseaClubRecruit,{},function(request,response)
                            if response.errCode == 0 then
                                GoodsUtils.DrawRewards({ { goodsId = consumeId, num = -consumeNum} })
                            end
                        end)
                    else
                        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(consumeId)
                        GameUtils.Toast(localize("_name_不足",{_name_ = goodsVo.name}))
                    end
                end,nil,nil,6,{{goodsId = consumeId ,num = consumeNum }})
            end
        end
    end)
end


function UIOverseaClubEntryInformationPanel:OnClickInfoModifyButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubCreatePopup)
end


function UIOverseaClubEntryInformationPanel:OnClickNoticeModifyButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubModifyNoticePopup)
end


function UIOverseaClubEntryInformationPanel:OnClickCopyClubIdButtonHandler_()
    GameUtils.SecondConfirm(localize("是否复制【社团ID】到剪切板？"), function()
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        DeviceID.CopyToClipboard(tostring(clubHomeDojo.clubId))
        GameUtils.Toast(localize("社团ID已复制"))
    end)
end


function UIOverseaClubEntryInformationPanel:OnClubUpdateInfoHandler_()
    self:UpdateClubBaseInfo_()
end


function UIOverseaClubEntryInformationPanel:OnClubUpdateNameHandler_()
    self:UpdateClubNameInfo_()
end


function UIOverseaClubEntryInformationPanel:OnClubUpdateNoticeHandler_()
    self:UpdateClubNoticeInfo_()
end


function UIOverseaClubEntryInformationPanel:OnClubUpdateExpHandler_()
    self:UpdateClubLevelInfo_()
end


function UIOverseaClubEntryInformationPanel:OnClubUpdateMembersHandler_()
    self:UpdateClubMembersInfo_()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIOverseaClubEntryInformationPanel:OnUpdateClubLogListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(LogListCellName)
    local cellData = self:GetLogDataList()[luaIndex]
    if isNotNull(cellNode) then
        local logDataTxt  = cellNode.transform:Find('TextDate')
        local logDescrTxt = cellNode.transform:Find('TextDesc')
        CfUtils.FillText(logDataTxt, os.date('%Y-%m-%d', cellData.createTime))
        CfUtils.FillText(logDescrTxt, tostring(cellData.data))
    end
    -- re-layout owner
    local layouter = cellNode.transform
    LayoutRebuilder.ForceRebuildLayoutImmediate(layouter)
    CfUtils.AdaptiveParentHeight(cellNode, LayoutUtility.GetPreferredHeight(layouter))
    return cellNode
end


return UIOverseaClubEntryInformationPanel
