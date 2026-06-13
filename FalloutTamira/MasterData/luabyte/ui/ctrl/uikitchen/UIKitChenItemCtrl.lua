-- baoruichang
-- 2023/5/26 17:08:40
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIKitChenItemCtrl = BaseClass("UIKitChenItemCtrl", CircularScrollViewItem)
local M = UIKitChenItemCtrl

function M:Init()
    self._view:onClick(Bind(self, self._onClick))
    self.tabItemPfbView = {self._view.ItemPfbView}
end

function M:UpdateItem(data)
    self.data = data
    self._view.imgIcon:SetItemIcon(data.food)
    self._view.labSatiety:SetText(tostring(data.cookCost))
    for i, costId in ipairs(data.itemCost) do
        local costNum = data.itemNum[i]
        local ItemPfbView = self.tabItemPfbView[i]
        if not ItemPfbView then
            ItemPfbView = self._view.ItemPfbView:Instantiate()
            self.tabItemPfbView[i] = ItemPfbView
        end
        local haveNum = ItemDataMgr:GetInstance():GetItemNumById(costId)
        ItemPfbView.item:SetInfo(costId, ItemNumberType.FRACTION, costNum, haveNum)
        ItemPfbView:SetActive(true)
        ItemPfbView.item:EnablePopItem(true)
    end
    for i = #data.itemCost + 1, #self.tabItemPfbView do
        self.tabItemPfbView[i]:SetActive(false)
    end
    self._view.ScrollView:SetEnable(#data.itemCost > 4)
    self:SetState(data.selectId == data.id and 2 or 1)
    if data.eatNum < data.cookCost then
        self._view.labSatiety:SetColor(244, 78, 78, 255)
    else
        self._view.labSatiety:SetColor(45, 45, 45, 255)
    end
end

function M:SetOnClick(clickCallback)
    self.clickCallback = clickCallback
end

function M:_onClick()
    if self.clickCallback then
        self.clickCallback(self.data)
    end
end

function M:SetState(state)
    self._view.uiState:SetState(state)
end

function M:OnDispose()
    -- Logger.LogError("销毁函数")
    M.super.OnDispose(self)
    for _, value in ipairs(self.tabItemPfbView) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDispose()
    end
end

return UIKitChenItemCtrl
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

