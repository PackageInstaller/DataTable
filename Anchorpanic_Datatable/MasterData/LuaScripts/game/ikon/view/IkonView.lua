--[[  AutoScript 自动脚本 
----------------------------------------------------- 
   @CreateTime:2021/4/6 14:19:18 
   @Author:Shenxintian 
   @Copyright: (LY)2021 雷焰网络 
   @Description:广告牌展示页面 V
]] 

module("game.ikon.view.IkonView",Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("ikon/IkonView.prefab" )
destroyTime = 0  -- 自动销毁时间-1默认 0即时销毁 999不销毁 
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 

function ctor(self) 
   super.ctor(self) 
end 

function dtor(self) 
end 

function initData(self) 
end 

function configUI(self) 
   self.mImg = self:getChildGO("mImg"):GetComponent(ty.Image)
   self.mTxtRet = self:getChildGO("mTxtRet"):GetComponent(ty.Text) 
end 

function active(self) 
   super.active(self) 
end 

function deActive(self) 
   super.deActive(self) 
end 

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
