-- baoruichang
-- 2023/5/26 17:16:47
local UIKitChenContext = BaseClass("UIKitChenContext", BaseContext)
local M = UIKitChenContext
local tSort = table.sort

function M:Init()
end

function M:GetMenus()
    if not self.menus then
        self.menus = {}
        local allMenus = ConfigHelper.GetCfgsByLua("menu")
        local index = 1
        for _, menu in pairs(allMenus) do
            self.menus[index] = menu
            index = index + 1
        end
    end
    tSort(self.menus, self._Sort)
    return self.menus
end

function M._Sort(menu1, menu2)
    return menu1.id < menu2.id
end

function M:Open(roomData, itemId)
    self:_Show(self:GetMenus(), roomData, itemId)
end

function M:OnClose()
    M.super.OnClose(self)
end

return UIKitChenContext
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

