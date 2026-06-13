-- baoruichang
-- 2023/6/12 16:24:40
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UITurnTaskItemCtrl = BaseClass("UITurnTaskItemCtrl", CircularScrollViewItem)
local M = UITurnTaskItemCtrl
local EActivityState = EnumConst.EActivityState

function M:Init()
    self._view.btn:onClick(Bind(self, self._onBtnClick))
end

function M:UpdateItem(data)
    self.data = data
    self._view.labName:SetText("今日活跃度达到" .. data.limitValue1)
    self._view.labNum:SetText("(" .. data.currentValue .. "/" .. data.limitValue1 .. ")")
    if data.state == EActivityState.Completed then
        self._view.btn:SetActive(false)
    else
        self._view.btn:SetActive(true)
        self._view.btnState:SetState(data.state == EActivityState.Finished and 1 or 2)
    end
    local itemGroup = ConfigHelper.GetCfg("itemGroup", data.reward)
    self._view.ItemPfbUI:SetInfo(itemGroup.items[1], 1, itemGroup.cnts[1])
    self._view.ItemPfbUI:EnablePopItem(true)
end

function M:_onBtnClick()
    Logger.LogError("AAAAAAAAAAAAAA")
    if self.callBack then
        self.callBack(self.data.id)
    end
end

function M:SetClickCallBack(callBack)
    self.callBack = callBack
end

function M:GetData()
    return self.data.id
end

return UITurnTaskItemCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' |_. |
--                     \ .-.\__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 \ \ `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

