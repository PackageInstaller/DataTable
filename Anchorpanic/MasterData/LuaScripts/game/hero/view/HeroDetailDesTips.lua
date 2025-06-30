--[[ 
-----------------------------------------------------
@filename       : HeroDetailDesTips
@Description    : 战员档案描述tips
@date           : 2023-6-20 11:13:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroDetailDesTips", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroDetailDesTips.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mFinishCall = nil
end

function configUI(self)
    super.configUI(self)
    self.mImgBlack = self:getChildGO("mImgBlack")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    if args.finishCall then
        self.mFinishCall = args.finishCall
    end
    self:updateView(args)
end

-- 设置货币栏
function setMoneyBar(self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mImgBlack, self.onClickClose)
end

function deActive(self)
    super.deActive(self)
end

function close(self)
    super.close(self)
end

function __closeOpenAction(self)
    if self.mFinishCall then
        self.mFinishCall()
    end
    super.__closeOpenAction(self)
end

function updateView(self, data)
    self.mTxtContent.text = data.des
    self.mTxtTitle.text = data.title
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]