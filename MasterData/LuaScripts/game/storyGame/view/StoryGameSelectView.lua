--[[ 
-----------------------------------------------------
@filename       : StoryGameSelectView
@Description    : 小游戏选择界面(测试页面)
@date           : 2020-12-28 16:09:07
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.StoryGameSelectView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/StoryGameSelectView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 450)
end
--析构  
function dtor(self)
end

function initData(self)
    self.list = {
        { id = 1, name = "拼图小游戏", call = function()
            GameDispatcher:dispatchEvent(EventName.OPEN_PUZZLE_GAME_PANEL)
        end
        },
        {
            id = 2, name = "接水管小游戏", call = function()
                GameDispatcher:dispatchEvent(EventName.OPEN_WATERPIPE_GAME_PANEL, { gameId = 1, data = {} })
            end
        },
        {
            id = 3, name = "阀门小游戏", call = function()
                GameDispatcher:dispatchEvent(EventName.OPEN_VALVE_GAME_PANEL)
            end
        },
        {
            id = 4, name = "密码锁游戏", call = function()
                GameDispatcher:dispatchEvent(EventName.OPEN_PASSWORD_GAME_PANEL)
            end
        },
        {
            id = 5, name = "阅读小游戏", call = function()
                GameDispatcher:dispatchEvent(EventName.OPEN_READ_GAME_PANEL)
            end
        },
    }
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mGroup = self:getChildTrans("mGroup")

    self:updateView()
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)
    local btn = nil
    for i, v in ipairs(self.list) do
        if i == 1 then
            btn = self:getChildGO("mBtn")
        else
            btn = gs.GameObject.Instantiate(self:getChildGO("mBtn"))
        end
        self:setBtnLabel(btn, nil, v.name)
        self:addOnClick(btn, v.call)
        btn.transform:SetParent(self.mGroup)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
