--[[ 
-----------------------------------------------------
@filename       : FightSupportInfoTips
@Description    : 战斗UI上的漂浮战场环境tips
@date           : 2023-03-09 10:58:26
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.fightUI.view.FightSupportInfoTips', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fight/FightSupportInfoTips.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mSkillItemList = {}
end

-- 初始化
function configUI(self)
    self.mBtnPrevent = self:getChildGO("mBtnPrevent")
    self.mImgBg = self:getChildTrans("mImgBg")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)

    self.Content = self:getChildTrans("Content")
end

--激活
function active(self, args)
    super.active(self, args)
    self.mSkillList = args.skillList
    self:updateView()
end


--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtTitle.text = _TT(3077) --"战场环境详情"

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPrevent, self.onClickClose)
end

function updateView(self)
    self:recoverList()
    for i, v in ipairs(self.mSkillList) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        local item = SimpleInsItem:create(self:getChildGO("GroupSupportItem"), self.Content, "FightWeakInfoTipsSupportItem")
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
        item:setText("mTxtSkillTitle", nil, skillVo:getName())
        item:setText("mTxtSkillDes", nil, skillVo:getDesc())

        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(item:getChildTrans("mTxtSkillDes"))
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(item:getTrans())
        table.insert(self.mSkillItemList, item)
    end
end

function recoverList(self)
    for i, v in ipairs(self.mSkillItemList) do
        v:poolRecover()
    end
    self.mSkillItemList = {}
end


function __playOpenAction(self)

end

function __closeOpenAction(self)
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]