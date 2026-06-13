-- baoruichang
-- 2023/5/13 17:42:36
local UIActivityCtrl = BaseClass("UIActivityCtrl", BaseUICtrl)
local M = UIActivityCtrl
local UIActivityItemCtrl = require("UI.Ctrl.Activity.UIActivityItemCtrl")
local UIActivityItemView = require("UI.View.Activity.UIActivityItemView")
local EActivityId = EnumConst.EActivityId

function M:Init()
    self.grid = self._view.grid
    self.grid:Init(UIActivityItemCtrl, UIActivityItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end

-- 进入UI，可传参数
function M:OnEnter(activityId, closeCallBack)
    self.closeCallBack = closeCallBack
    local activityDatas = self:GetContext():GetActivityDatas()
    self.grid:SetDataList(activityDatas)
    if activityId then
        local have = nil
        for _, activityData in pairs(activityDatas) do
            if activityData.id == activityId then
                have = true
            end
        end
        if not have then
            activityId = nil
        end
    end
    local id = activityId or activityDatas[1].id
    local UIActivityItemCtrls = self.grid:GetItems()
    for _, UIActivityItemCtrl in pairs(UIActivityItemCtrls) do
        local activityData = UIActivityItemCtrl:GetData()
        if activityData.id == id then
            self:_OnItemClick(UIActivityItemCtrl)
            break
        end
    end
    self:OnVisible()
end

function M:OnVisible()
    local ctrl = UIContextMgr:GetInstance():GetCtrl(self.currentOpenUI)
    if ctrl and ctrl.OnVisible then
        ctrl:OnVisible()
    end
end

function M:_OnCreateItem(UIActivityItemCtrl)
    UIActivityItemCtrl:SetClick(Bind(self, self._OnItemClick))
end

function M:_OnItemClick(UIActivityItemCtrl)
    if not self:GetContext():GetCanRecharge() then
        return
    end
    if self.selectUIActivityItemCtrl == UIActivityItemCtrl then
        return
    end
    if self.selectUIActivityItemCtrl then
        self.selectUIActivityItemCtrl:SetState(1)
    end
    self.selectUIActivityItemCtrl = UIActivityItemCtrl
    UIActivityItemCtrl:SetState(2)
    local activityData = UIActivityItemCtrl:GetData()
    local activityId = activityData.id
    Logger.Log("点击了活动：" .. activityId)
    local ui

    if activityId == EActivityId.FirstRecharge then
        ui = "FirstRecharge"
        activityId = nil
    elseif activityId == EActivityId.MonthSign then
        ui = "MonthlySignUI"
        activityId = nil
    elseif activityId == EActivityId.DayEnergy then -- 每日体力领取
        ui = UIDefine.UIDayEnergy
        activityId = nil
    elseif activityId == EActivityId.LevelFund then -- 成长基金
        ui = UIDefine.UILevelFund
        activityId = nil
    else
        ui = ConfigHelper.GetCfgPropByLua("activity", activityId, "prefabPath")
    end
    if self.currentOpenUI and self.currentOpenUI ~= ui then
        UIContextMgr:GetInstance():Close(self.currentOpenUI)
    end
    UIContextMgr:GetInstance():Show(ui, activityId)
    self.currentOpenUI = ui
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnBack()
    if not self:GetContext():GetCanRecharge() then
        return false
    end
    return true
end

function M:OnClose()
    if self.closeCallBack then
        self:closeCallBack()
    end
end

return UIActivityCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--						  . ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                       一个是阆苑仙葩，
--                       一个是美玉无瑕。
--                       若说没奇缘，
--                       今生偏又遇着他；
--                       若说有奇缘，
--                       如何心事终虚化？
--                       一个枉自嗟呀，
--                       一个空劳牵挂。
--                       一个是水中月，
--                       一个是镜中花。
--                       想眼中能有多少泪珠儿，
--                       怎禁得秋流到冬尽，
--                       春流到夏！
