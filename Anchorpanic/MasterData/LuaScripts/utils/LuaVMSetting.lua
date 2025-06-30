--[[
****************************************************************************
Brief  :JIT 判断和处理
Author :Zhaosongjie
Date   :2018-10-15 11:53:51
Last Modified by:   Zhaosongjie
Last Modified time: 2018-10-15 12:00:21
Copyright (c) 2018 雷焰网络. All rights reserved
****************************************************************************
]]

LuaVMTypeConst = 
{
	Lua = 0,
	LuaJIT = 1
}

LuaVMType = nil

function initLuaVMSetting()

	if jit then 
		LuaVMType = LuaVMTypeConst.LuaJIT;
	else 
		LuaVMType = LuaVMTypeConst.Lua;
	end 

	if LuaVMType == LuaVMTypeConst.LuaJIT then 
		Debug.Log("Detect vm type : Lua JIT");
		-- 关闭jit，使用jit的解释器
		--[[ 
		说明：
		经过实际Android测试，JIT经常会产生拖慢帧数的效果。关闭了反而帧数上去了
		LuaJIT 在针对大量C API调用的Lua程序时（就像我们这种游戏lua的情况），jit的效果更慢
		在LuaJIT尝试去JIT编译lua程序栈的时候，碰到C API就会被打断产生NYI Error，从而转向使用解释器
		这时候就会产生没有必要的失败逻辑（JIT逻辑失败），还不如直接使用解释器，LuaJIT的解释器本身就比Lua快2-4倍，所以也不亏。
		]] 
		jit.off();
		Debug.Log("Turning off Lua JIT Compiler");
	else 
		Debug.Log("Detect vm type : Native Lua");
	end 
end 