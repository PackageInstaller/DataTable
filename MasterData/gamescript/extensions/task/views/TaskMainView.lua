.version	5.4

.format	0
.instruction_size	4
.integer_format	8
.float_format	8
.endianness	LITTLE

.function	main

.source	"@Assets\\Lua\\GameScript\\Extensions\\Task\\Views\\TaskMainView.lua"
.linedefined	0
.lastlinedefined	0
.numparams	0
.is_vararg	1
.maxstacksize	7

.local	"TaskMainView"	5	57
.local	"Super"	5	57
.local	"T_UIAnimationController"	12	57
.local	"TaskPage"	14	57
.local	"AddClipToPlay"	16	57
.local	"TOGGLE_COUNT"	17	57

.upvalue	"_ENV"	0	true

.constant	k0	"NewClass"
.constant	k1	"TaskMainView"
.constant	k2	"BaseView"
.constant	k3	"uiResCls"
.constant	k4	"UI_Task_Panel_Main_NewResource"
.constant	k5	"typeof"
.constant	k6	"CS"
.constant	k7	"Z1Client"
.constant	k8	"UIAnimationController"
.constant	k9	"CommonDefine"
.constant	k10	"TaskPage"
.constant	k11	"AnimatorUtils"
.constant	k12	"AddClipToPlay"
.constant	k13	"ctor"
.constant	k14	"RegisterNotifications"
.constant	k15	"RegisterEvents"
.constant	k16	"_RevertToCurTab"
.constant	k17	"_RegisterTabsEvents"
.constant	k18	"OnEnterView"
.constant	k19	"OnEnterViewFinished"
.constant	k20	"_InitTabsInfo"
.constant	k21	"GetTempDependenciesResources"
.constant	k22	"OnExitView"
.constant	k23	"OnClickClose"
.constant	k24	"CheckSwitchPageUnlocked"
.constant	k25	"SwitchPage"
.constant	k26	"_RefreshTabsStatus"
.constant	k27	"PlaySwitchPageAnim"
.constant	k28	"_OnTaskMainViewPageChanged"
.constant	k29	"_OnChildTapViewSwitchedFinished"
.constant	k30	"PlayCloseAnim"
.constant	k31	"Close"

.line	0	varargprep     0
.line	1	gettabup      r0    u0    k0 ; k0 = "NewClass"
.line	0	loadk         r1    k1 ; k1 = "TaskMainView"
.line	0	gettabup      r2    u0    k2 ; k2 = "BaseView"
.line	0	call          r0     3     3
.line	1	gettabup      r2    u0    k4 ; k4 = "UI_Task_Panel_Main_N" (truncated)
.line	0	setfield      r0    k3    r2 ; k3 = "uiResCls"
.line	2	gettabup      r2    u0    k5 ; k5 = "typeof"
.line	0	gettabup      r3    u0    k6 ; k6 = "CS"
.line	0	getfield      r3    r3    k7 ; k7 = "Z1Client"
.line	0	getfield      r3    r3    k8 ; k8 = "UIAnimationControlle" (truncated)
.line	0	call          r2     2     2
.line	1	gettabup      r3    u0    k9 ; k9 = "CommonDefine"
.line	0	getfield      r3    r3   k10 ; k10 = "TaskPage"
.line	1	gettabup      r4    u0   k11 ; k11 = "AnimatorUtils"
.line	0	getfield      r4    r4   k12 ; k12 = "AddClipToPlay"
.line	2	loadi         r5     7
.line	6	closure       r6    f0
.line	251	setfield      r0   k13    r6 ; k13 = "ctor"
.line	31	closure       r6    f1
.line	232	setfield      r0   k14    r6 ; k14 = "RegisterNotification" (truncated)
.line	30	closure       r6    f2
.line	254	setfield      r0   k15    r6 ; k15 = "RegisterEvents"
.line	20	closure       r6    f3
.line	240	setfield      r0   k16    r6 ; k16 = "_RevertToCurTab"
.line	40	closure       r6    f4
.line	233	setfield      r0   k17    r6 ; k17 = "_RegisterTabsEvents"
.line	37	closure       r6    f5
.line	245	setfield      r0   k18    r6 ; k18 = "OnEnterView"
.line	32	closure       r6    f6
.line	237	setfield      r0   k19    r6 ; k19 = "OnEnterViewFinished"
.line	96	closure       r6    f7
.line	181	setfield      r0   k20    r6 ; k20 = "_InitTabsInfo"
.line	79	closure       r6    f8
.line	254	setfield      r0   k21    r6 ; k21 = "GetTempDependenciesR" (truncated)
.line	7	closure       r6    f9
.line	253	setfield      r0   k22    r6 ; k22 = "OnExitView"
.line	9	closure       r6   f10
.line	252	setfield      r0   k23    r6 ; k23 = "OnClickClose"
.line	23	closure       r6   f11
.line	239	setfield      r0   k24    r6 ; k24 = "CheckSwitchPageUnloc" (truncated)
.line	48	closure       r6   f12
.line	227	setfield      r0   k25    r6 ; k25 = "SwitchPage"
.line	57	closure       r6   f13
.line	230	setfield      r0   k26    r6 ; k26 = "_RefreshTabsStatus"
.line	54	closure       r6   f14
.line	230	setfield      r0   k27    r6 ; k27 = "PlaySwitchPageAnim"
.line	30	closure       r6   f15
.line	254	setfield      r0   k28    r6 ; k28 = "_OnTaskMainViewPageC" (truncated)
.line	20	closure       r6   f16
.line	240	setfield      r0   k29    r6 ; k29 = "_OnChildTapViewSwitc" (truncated)
.line	43	closure       r6   f17
.line	233	setfield      r0   k30    r6 ; k30 = "PlayCloseAnim"
.line	31	closure       r6   f18
.line	250	setfield      r0   k31    r6 ; k31 = "Close"
.line	7	return        r0     2     1     1
.line	0	return        r6     1     1     1

.function	main/f0

.source	null
.linedefined	10
.lastlinedefined	15
.numparams	4
.is_vararg	0
.maxstacksize	6

.local	"self"	0	7
.local	"page"	0	7
.local	"switchCb"	0	7
.local	"hideToggles"	0	7

.upvalue	"Super"	1	true

.constant	k0	"ctor"
.constant	k1	"defaultPage"
.constant	k2	"switchCb"
.constant	k3	"hideToggles"

.line	1	gettabup      r4    u0    k0 ; k0 = "ctor"
.line	0	move          r5    r0
.line	0	call          r4     2     1
.line	1	setfield      r0    k1    r1 ; k1 = "defaultPage"
.line	1	setfield      r0    k2    r2 ; k2 = "switchCb"
.line	1	setfield      r0    k3    r3 ; k3 = "hideToggles"
.line	1	return0       r4     1     0     0

.function	main/f1

.source	null
.linedefined	17
.lastlinedefined	41
.numparams	1
.is_vararg	0
.maxstacksize	6

.local	"self"	0	28

.upvalue	"_ENV"	0	false

.constant	k0	"RegisterLocalNotify"
.constant	k1	"NotifyId"
.constant	k2	"OnTaskMainViewPageChanged"
.constant	k3	"_OnTaskMainViewPageChanged"
.constant	k4	"BindEvent"
.constant	k5	"EventMgr"
.constant	k6	"Instance"
.constant	k7	"TaskSwitchPage"
.constant	k8	"Instance"
.constant	k9	"TaskShowAnim"
.constant	k10	"NewbieGuideManager"
.constant	k11	"RegisterNewbieGo"
.constant	k12	"UI_Task_Panel_Main_New(Clone).Btn_Task7"
.constant	k13	"ui"
.constant	k14	"Btn_Task7"
.constant	k15	"Urls"
.constant	k16	"TaskCareerView"

.line	1	self          r1    r0    k0  k= 1 ; k0 = "RegisterLocalNotify"
.line	0	gettabup      r3    u0    k1 ; k1 = "NotifyId"
.line	0	getfield      r3    r3    k2 ; k2 = "OnTaskMainViewPageCh" (truncated)
.line	0	getfield      r4    r0    k3 ; k3 = "_OnTaskMainViewPageC" (truncated)
.line	0	move          r5    r0
.line	0	call          r1     5     1
.line	2	self          r1    r0    k4  k= 1 ; k4 = "BindEvent"
.line	1	gettabup      r3    u0    k5 ; k5 = "EventMgr"
.line	0	getfield      r3    r3    k6 ; k6 = "Instance"
.line	0	getfield      r3    r3    k7 ; k7 = "TaskSwitchPage"
.line	7	closure       r4    f0
.line	248	call          r1     4     1
.line	11	self          r1    r0    k4  k= 1 ; k4 = "BindEvent"
.line	1	gettabup      r3    u0    k5 ; k5 = "EventMgr"
.line	0	getfield      r3    r3    k8 ; k8 = "Instance"
.line	0	getfield      r3    r3    k9 ; k9 = "TaskShowAnim"
.line	5	closure       r4    f1
.line	250	call          r1     4     1
.line	8	gettabup      r1    u0   k10 ; k10 = "NewbieGuideManager"
.line	0	getfield      r1    r1    k8 ; k8 = "Instance"
.line	0	self          r1    r1   k11  k= 1 ; k11 = "RegisterNewbieGo"
.line	0	loadk         r3   k12 ; k12 = "UI_Task_Panel_Main_N" (truncated)
.line	1	getfield      r4    r0   k13 ; k13 = "ui"
.line	0	getfield      r4    r4   k14 ; k14 = "Btn_Task7"
.line	0	gettabup      r5    u0   k15 ; k15 = "Urls"
.line	0	getfield      r5    r5   k16 ; k16 = "TaskCareerView"
.line	255	call          r1     5     1
.line	2	return        r1     1     0     1

.function	main/f1/f0

.source	null
.linedefined	22
.lastlinedefined	28
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"tabIndex"	0	16

.upvalue	"self"	0	true
.upvalue	"_ENV"	0	false

.constant	k0	"CheckSwitchPageUnlocked"
.constant	k1	"_RevertToCurTab"
.constant	k2	"TaskModel"
.constant	k3	"Instance"
.constant	k4	"SetCurTaskPage"

.line	1	getupval      r1    u0
.line	0	self          r1    r1    k0  k= 1 ; k0 = "CheckSwitchPageUnloc" (truncated)
.line	0	move          r3    r0
.line	0	call          r1     3     2
.line	0	test          r1     1
.line	0	jmp          l11
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k1  k= 1 ; k1 = "_RevertToCurTab"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0
.label	l11
.line	2	gettabup      r1    u1    k2 ; k2 = "TaskModel"
.line	0	getfield      r1    r1    k3 ; k3 = "Instance"
.line	0	self          r1    r1    k4  k= 1 ; k4 = "SetCurTaskPage"
.line	0	move          r3    r0
.line	0	call          r1     3     1
.line	1	return0       r1     1     0     0

.function	main/f1/f1

.source	null
.linedefined	33
.lastlinedefined	37
.numparams	2
.is_vararg	0
.maxstacksize	6

.local	"animName"	0	11
.local	"callBack"	0	11

.upvalue	"_ENV"	0	false
.upvalue	"self"	0	true

.constant	k0	"IsNil"
.constant	k1	"uiAnimController"
.constant	k2	"PlayMultiState"

.line	1	gettabup      r2    u0    k0 ; k0 = "IsNil"
.line	0	gettabup      r3    u1    k1 ; k1 = "uiAnimController"
.line	0	call          r2     2     2
.line	0	test          r2     1
.line	0	jmp          l11
.line	1	gettabup      r2    u1    k1 ; k1 = "uiAnimController"
.line	0	self          r2    r2    k2  k= 1 ; k2 = "PlayMultiState"
.line	0	move          r4    r0
.line	0	move          r5    r1
.line	0	call          r2     4     1
.label	l11
.line	2	return0       r2     1     0     0

.function	main/f2

.source	null
.linedefined	45
.lastlinedefined	47
.numparams	1
.is_vararg	0
.maxstacksize	3

.local	"self"	0	3

.constant	k0	"_RegisterTabsEvents"

.line	1	self          r1    r0    k0  k= 1 ; k0 = "_RegisterTabsEvents"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f3

.source	null
.linedefined	49
.lastlinedefined	65
.numparams	1
.is_vararg	0
.maxstacksize	8

.local	"self"	0	34
.local	"curTabIndex"	5	34
.local	"curToggle"	25	34

.upvalue	"_ENV"	0	false
.upvalue	"TaskPage"	3	true

.constant	k0	"childrenTapViews"
.constant	k1	"curTabIndex"
.constant	k2	"TaskModel"
.constant	k3	"Instance"
.constant	k4	"GetUnlockedTaskPage"
.constant	k5	"Career"
.constant	k6	"toggleObj"
.constant	k7	"SetZ1Toggle"

.line	1	getfield      r1    r0    k0 ; k0 = "childrenTapViews"
.line	0	test          r1     1
.line	0	jmp           l5
.line	1	return0       r1     1     0     0
.label	l5
.line	3	getfield      r1    r0    k1 ; k1 = "curTabIndex"
.line	1	test          r1     0
.line	0	jmp          l12
.line	0	getfield      r2    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	test          r2     1
.line	0	jmp          l19
.label	l12
.line	1	gettabup      r2    u0    k2 ; k2 = "TaskModel"
.line	0	getfield      r2    r2    k3 ; k3 = "Instance"
.line	0	self          r2    r2    k4  k= 1 ; k4 = "GetUnlockedTaskPage"
.line	0	call          r2     2     2
.line	0	testset       r1    r2     1
.line	0	jmp          l19
.line	0	gettabup      r1    u1    k5 ; k5 = "Career"
.label	l19
.line	3	getfield      r2    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	test          r2     0
.line	0	jmp          l26
.line	0	getfield      r2    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	getfield      r2    r2    k6 ; k6 = "toggleObj"
.label	l26
.line	1	test          r2     1
.line	0	jmp          l29
.line	1	return0       r3     1     0     0
.label	l29
.line	3	self          r3    r0    k7  k= 1 ; k7 = "SetZ1Toggle"
.line	0	move          r5    r2
.line	0	loadtrue      r6
.line	0	loadtrue      r7
.line	0	call          r3     5     1
.line	1	return0       r3     1     0     0

.function	main/f4

.source	null
.linedefined	66
.lastlinedefined	89
.numparams	1
.is_vararg	0
.maxstacksize	10

.local	"self"	0	20
.local	"(for state)"	3	19
.local	"(for state)"	3	19
.local	"(for state)"	3	19
.local	"tabIndex"	4	17
.local	"toggleBtn"	9	16

.upvalue	"TOGGLE_COUNT"	5	true
.upvalue	"_ENV"	0	false

.constant	k0	"ui"
.constant	k1	"Btn_Task"
.constant	k2	"AddZ1ToggleValueChangedListener"

.line	1	loadi         r1     1
.line	0	getupval      r2    u0
.line	0	loadi         r3     1
.line	0	forprep       r1   l18
.label	l5
.line	1	getfield      r5    r0    k0 ; k0 = "ui"
.line	0	loadk         r6    k1 ; k1 = "Btn_Task"
.line	0	move          r7    r4
.line	0	concat        r6     2
.line	0	gettable      r5    r5    r6
.line	1	test          r5     0
.line	0	jmp          l19
.line	3	self          r6    r0    k2  k= 1 ; k2 = "AddZ1ToggleValueChan" (truncated)
.line	0	move          r8    r5
.line	15	closure       r9    f0
.line	241	call          r6     4     1
.line	15	close         r5
.line	0	close         r4
.label	l18
.line	236	forloop       r1    l5
.label	l19
.line	21	close         r4
.line	1	return        r1     1     0     1

.function	main/f4/f0

.source	null
.linedefined	72
.lastlinedefined	87
.numparams	1
.is_vararg	0
.maxstacksize	6

.local	"isOn"	0	37

.upvalue	"self"	0	true
.upvalue	"toggleBtn"	5	true
.upvalue	"tabIndex"	4	true
.upvalue	"_ENV"	1	false

.constant	k0	"_isTabSwitchAnimating"
.constant	k1	"SetZ1Toggle"
.constant	k2	"_RevertToCurTab"
.constant	k3	"CheckSwitchPageUnlocked"
.constant	k4	"TaskModel"
.constant	k5	"Instance"
.constant	k6	"SetCurTaskPage"

.line	1	test          r0     0
.line	0	jmp          l37
.line	1	gettabup      r1    u0    k0 ; k0 = "_isTabSwitchAnimatin" (truncated)
.line	0	test          r1     0
.line	0	jmp          l16
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k1  k= 1 ; k1 = "SetZ1Toggle"
.line	0	getupval      r3    u1
.line	0	loadfalse     r4
.line	0	loadtrue      r5
.line	0	call          r1     5     1
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k2  k= 1 ; k2 = "_RevertToCurTab"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0
.label	l16
.line	2	getupval      r1    u0
.line	0	self          r1    r1    k3  k= 1 ; k3 = "CheckSwitchPageUnloc" (truncated)
.line	0	getupval      r3    u2
.line	0	call          r1     3     2
.line	0	test          r1     1
.line	0	jmp          l32
.line	2	getupval      r1    u0
.line	0	self          r1    r1    k1  k= 1 ; k1 = "SetZ1Toggle"
.line	0	getupval      r3    u1
.line	0	loadfalse     r4
.line	0	loadtrue      r5
.line	0	call          r1     5     1
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k2  k= 1 ; k2 = "_RevertToCurTab"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0
.label	l32
.line	2	gettabup      r1    u3    k4 ; k4 = "TaskModel"
.line	0	getfield      r1    r1    k5 ; k5 = "Instance"
.line	0	self          r1    r1    k6  k= 1 ; k6 = "SetCurTaskPage"
.line	0	getupval      r3    u2
.line	0	call          r1     3     1
.label	l37
.line	2	return0       r1     1     0     0

.function	main/f5

.source	null
.linedefined	92
.lastlinedefined	103
.numparams	1
.is_vararg	0
.maxstacksize	6

.local	"self"	0	27

.upvalue	"Super"	1	true
.upvalue	"T_UIAnimationController"	2	true
.upvalue	"_ENV"	0	false

.constant	k0	"OnEnterView"
.constant	k1	"uiAnimController"
.constant	k2	"ui"
.constant	k3	"uiNode"
.constant	k4	"GetComponent"
.constant	k5	"compBtnClosed"
.constant	k6	"AddViewComponent"
.constant	k7	"UI_Common_Btn_Back3"
.constant	k8	"UICompBtnCloseItem"
.constant	k9	"SetText"
.constant	k10	"Text_Title"
.constant	k11	"LT"
.constant	k12	"Text"
.constant	k13	"Main_Title_3"
.constant	k14	"_InitTabsInfo"

.line	1	gettabup      r1    u0    k0 ; k0 = "OnEnterView"
.line	0	move          r2    r0
.line	0	call          r1     2     1
.line	1	getfield      r1    r0    k2 ; k2 = "ui"
.line	0	getfield      r1    r1    k3 ; k3 = "uiNode"
.line	0	self          r1    r1    k4  k= 1 ; k4 = "GetComponent"
.line	0	getupval      r3    u1
.line	0	call          r1     3     2
.line	0	setfield      r0    k1    r1 ; k1 = "uiAnimController"
.line	1	self          r1    r0    k6  k= 1 ; k6 = "AddViewComponent"
.line	0	getfield      r3    r0    k2 ; k2 = "ui"
.line	0	getfield      r3    r3    k7 ; k7 = "UI_Common_Btn_Back3"
.line	0	gettabup      r4    u2    k8 ; k8 = "UICompBtnCloseItem"
.line	4	closure       r5    f0
.line	252	call          r1     5     2
.line	4	setfield      r0    k5    r1 ; k5 = "compBtnClosed"
.line	1	self          r1    r0    k9  k= 1 ; k9 = "SetText"
.line	0	getfield      r3    r0    k2 ; k2 = "ui"
.line	0	getfield      r3    r3   k10 ; k10 = "Text_Title"
.line	0	gettabup      r4    u2   k11 ; k11 = "LT"
.line	0	getfield      r4    r4   k12 ; k12 = "Text"
.line	0	loadk         r5   k13 ; k13 = "Main_Title_3"
.line	0	call          r4     2     0
.line	0	call          r1     0     1
.line	1	self          r1    r0   k14  k= 1 ; k14 = "_InitTabsInfo"
.line	0	call          r1     2     1
.line	2	return        r1     1     0     1

.function	main/f5/f0

.source	null
.linedefined	95
.lastlinedefined	99
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true

.constant	k0	"clickClose"
.constant	k1	"OnClickClose"

.line	1	gettabup      r0    u0    k0 ; k0 = "clickClose"
.line	0	test          r0     1
.line	0	jmp           l7
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k1  k= 1 ; k1 = "OnClickClose"
.line	0	call          r0     2     1
.label	l7
.line	2	return0       r0     1     0     0

.function	main/f6

.source	null
.linedefined	105
.lastlinedefined	124
.numparams	1
.is_vararg	0
.maxstacksize	6

.local	"self"	0	46
.local	"curPage"	9	46

.upvalue	"_ENV"	0	false

.constant	k0	"SetCanvasGroup"
.constant	k1	"ui"
.constant	k2	"uiNode"
.constant	k3	"TaskModel"
.constant	k4	"Instance"
.constant	k5	"GetUnlockedTaskPage"
.constant	k6	"defaultPage"
.constant	k7	"SetCurTaskPage"
.constant	k8	"IsPageUnlocked"
.constant	k9	"SetZ1Toggle"
.constant	k10	"childrenTapViews"
.constant	k11	"toggleObj"
.constant	k12	"SwitchPage"
.constant	k13	"_RevertToCurTab"
.constant	k14	nil

.line	2	self          r1    r0    k0  k= 1 ; k0 = "SetCanvasGroup"
.line	0	getfield      r3    r0    k1 ; k1 = "ui"
.line	0	getfield      r3    r3    k2 ; k2 = "uiNode"
.line	0	loadi         r4     0
.line	0	call          r1     4     1
.line	2	gettabup      r1    u0    k3 ; k3 = "TaskModel"
.line	0	getfield      r1    r1    k4 ; k4 = "Instance"
.line	0	self          r1    r1    k5  k= 1 ; k5 = "GetUnlockedTaskPage"
.line	0	call          r1     2     2
.line	2	getfield      r2    r0    k6 ; k6 = "defaultPage"
.line	0	test          r2     0
.line	0	jmp          l43
.line	1	gettabup      r2    u0    k3 ; k3 = "TaskModel"
.line	0	getfield      r2    r2    k4 ; k4 = "Instance"
.line	0	self          r2    r2    k7  k= 1 ; k7 = "SetCurTaskPage"
.line	0	getfield      r4    r0    k6 ; k6 = "defaultPage"
.line	0	call          r2     3     1
.line	1	gettabup      r2    u0    k3 ; k3 = "TaskModel"
.line	0	getfield      r2    r2    k4 ; k4 = "Instance"
.line	0	self          r2    r2    k8  k= 1 ; k8 = "IsPageUnlocked"
.line	0	getfield      r4    r0    k6 ; k6 = "defaultPage"
.line	0	call          r2     3     2
.line	0	test          r2     0
.line	0	jmp          l36
.line	1	self          r2    r0    k9  k= 1 ; k9 = "SetZ1Toggle"
.line	0	getfield      r4    r0   k10 ; k10 = "childrenTapViews"
.line	0	getfield      r5    r0    k6 ; k6 = "defaultPage"
.line	0	gettable      r4    r4    r5
.line	0	getfield      r4    r4   k11 ; k11 = "toggleObj"
.line	0	loadtrue      r5
.line	0	call          r2     4     1
.line	1	self          r2    r0   k12  k= 1 ; k12 = "SwitchPage"
.line	0	getfield      r4    r0    k6 ; k6 = "defaultPage"
.line	0	call          r2     3     1
.line	0	jmp          l41
.label	l36
.line	2	self          r2    r0   k12  k= 1 ; k12 = "SwitchPage"
.line	0	move          r4    r1
.line	0	call          r2     3     1
.line	1	self          r2    r0   k13  k= 1 ; k13 = "_RevertToCurTab"
.line	0	call          r2     2     1
.label	l41
.line	2	setfield      r0    k6   k14  k= 1 ; k14 = nil
.line	0	jmp          l46
.label	l43
.line	2	self          r2    r0   k12  k= 1 ; k12 = "SwitchPage"
.line	0	move          r4    r1
.line	0	call          r2     3     1
.label	l46
.line	2	return0       r2     1     0     0

.function	main/f7

.source	null
.linedefined	126
.lastlinedefined	201
.numparams	1
.is_vararg	0
.maxstacksize	7

.local	"self"	0	158

.upvalue	"TaskPage"	3	true
.upvalue	"_ENV"	0	false

.constant	k0	"childrenTapViews"
.constant	k1	"Career"
.constant	k2	"toggleObj"
.constant	k3	"ui"
.constant	k4	"Btn_Task1"
.constant	k5	"UIUrl"
.constant	k6	"Urls"
.constant	k7	"TaskCareerView"
.constant	k8	"UINodeName"
.constant	k9	"UI_Task_Popup_Career"
.constant	k10	"serverIdx"
.constant	k11	"TaskModel"
.constant	k12	"Instance"
.constant	k13	"GetPageServerIndex"
.constant	k14	"viewInstance"
.constant	k15	nil
.constant	k16	"labelNameLangKey"
.constant	k17	"Task_Tab_Career"
.constant	k18	"Name"
.constant	k19	"PlayerLevel"
.constant	k20	"Btn_Task2"
.constant	k21	"TaskPlayerLevelView"
.constant	k22	"UI_Task_Popup_PlayerLevel"
.constant	k23	"PlayerLevelTaskLabel"
.constant	k24	"School"
.constant	k25	"Btn_Task3"
.constant	k26	"TaskSchoolView"
.constant	k27	"UI_Task_Popup_School"
.constant	k28	"SchoolTaskLabel"
.constant	k29	"Achievement"
.constant	k30	"Btn_Task4"
.constant	k31	"TaskHomeAchievementView"
.constant	k32	"UI_Task_Popup_Challenge2"
.constant	k33	"Task_SubTab_Achievement"
.constant	k34	"TaskAchievementView"
.constant	k35	"Tutorial"
.constant	k36	"Btn_Task5"
.constant	k37	"TutorialMainView"
.constant	k38	"UI_Course_Panel_Main"
.constant	k39	"TutorialTaskLabel"
.constant	k40	"feature"
.constant	k41	"cd"
.constant	k42	"FeatureId"
.constant	k43	"redFunc"
.constant	k44	"RedPointDataUtils"
.constant	k45	"IsTutorialRedPoint"
.constant	k46	"callback"
.constant	k47	"AwakerTrial"
.constant	k48	"Btn_Task6"
.constant	k49	"FreeTrialView"
.constant	k50	"UI_Dungeons_Panel_Try"
.constant	k51	"FreeTrialTitle"
.constant	k52	"ResidentTrial"
.constant	k53	"RedPointDataUtils"
.constant	k54	"HasFreeTrialAward"
.constant	k55	"BattleTeaching"
.constant	k56	"Btn_Task7"
.constant	k57	"DungeonBattleTeachingView"
.constant	k58	"UI_Dungeons_BattleTeaching_View"
.constant	k59	"BattleTeachingLabel"
.constant	k60	"IsShowBattleTeachingEntryRed"

.line	1	newtable      r1     4     0     1
.line	0	extraarg       0
.line	1	gettabup      r2    u0    k1 ; k1 = "Career"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4    k4 ; k4 = "Btn_Task1"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4    k7 ; k7 = "TaskCareerView"
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8    k9  k= 1 ; k9 = "UI_Task_Popup_Career"
.line	1	gettabup      r4    u1   k11 ; k11 = "TaskModel"
.line	0	getfield      r4    r4   k12 ; k12 = "Instance"
.line	0	self          r4    r4   k13  k= 1 ; k13 = "GetPageServerIndex"
.line	0	gettabup      r6    u0    k1 ; k1 = "Career"
.line	0	call          r4     3     2
.line	0	setfield      r3   k10    r4 ; k10 = "serverIdx"
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k17  k= 1 ; k17 = "Task_Tab_Career"
.line	1	setfield      r3   k18    k7  k= 1 ; k7 = "TaskCareerView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k19 ; k19 = "PlayerLevel"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k20 ; k20 = "Btn_Task2"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k21 ; k21 = "TaskPlayerLevelView"
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k22  k= 1 ; k22 = "UI_Task_Popup_Player" (truncated)
.line	1	gettabup      r4    u1   k11 ; k11 = "TaskModel"
.line	0	getfield      r4    r4   k12 ; k12 = "Instance"
.line	0	self          r4    r4   k13  k= 1 ; k13 = "GetPageServerIndex"
.line	0	gettabup      r6    u0   k19 ; k19 = "PlayerLevel"
.line	0	call          r4     3     2
.line	0	setfield      r3   k10    r4 ; k10 = "serverIdx"
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k23  k= 1 ; k23 = "PlayerLevelTaskLabel"
.line	1	setfield      r3   k18   k21  k= 1 ; k21 = "TaskPlayerLevelView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k24 ; k24 = "School"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k25 ; k25 = "Btn_Task3"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k26 ; k26 = "TaskSchoolView"
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k27  k= 1 ; k27 = "UI_Task_Popup_School"
.line	1	gettabup      r4    u1   k11 ; k11 = "TaskModel"
.line	0	getfield      r4    r4   k12 ; k12 = "Instance"
.line	0	self          r4    r4   k13  k= 1 ; k13 = "GetPageServerIndex"
.line	0	gettabup      r6    u0   k24 ; k24 = "School"
.line	0	call          r4     3     2
.line	0	setfield      r3   k10    r4 ; k10 = "serverIdx"
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k28  k= 1 ; k28 = "SchoolTaskLabel"
.line	1	setfield      r3   k18   k26  k= 1 ; k26 = "TaskSchoolView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k29 ; k29 = "Achievement"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k30 ; k30 = "Btn_Task4"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k31 ; k31 = "TaskHomeAchievementV" (truncated)
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k32  k= 1 ; k32 = "UI_Task_Popup_Challe" (truncated)
.line	1	gettabup      r4    u1   k11 ; k11 = "TaskModel"
.line	0	getfield      r4    r4   k12 ; k12 = "Instance"
.line	0	self          r4    r4   k13  k= 1 ; k13 = "GetPageServerIndex"
.line	0	gettabup      r6    u0   k29 ; k29 = "Achievement"
.line	0	call          r4     3     2
.line	0	setfield      r3   k10    r4 ; k10 = "serverIdx"
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k33  k= 1 ; k33 = "Task_SubTab_Achievem" (truncated)
.line	1	setfield      r3   k18   k34  k= 1 ; k34 = "TaskAchievementView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k35 ; k35 = "Tutorial"
.line	0	newtable      r3     5     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k36 ; k36 = "Btn_Task5"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k37 ; k37 = "TutorialMainView"
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k38  k= 1 ; k38 = "UI_Course_Panel_Main"
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k39  k= 1 ; k39 = "TutorialTaskLabel"
.line	1	newtable      r4     0     1     1
.line	0	extraarg       0
.line	0	gettabup      r5    u1   k41 ; k41 = "cd"
.line	0	getfield      r5    r5   k42 ; k42 = "FeatureId"
.line	0	getfield      r5    r5   k35 ; k35 = "Tutorial"
.line	0	setlist       r4     1     0     0
.line	0	setfield      r3   k40    r4 ; k40 = "feature"
.line	1	gettabup      r4    u1   k44 ; k44 = "RedPointDataUtils"
.line	0	getfield      r4    r4   k45 ; k45 = "IsTutorialRedPoint"
.line	0	setfield      r3   k43    r4 ; k43 = "redFunc"
.line	5	closure       r4    f0
.line	0	setfield      r3   k46    r4 ; k46 = "callback"
.line	1	setfield      r3   k18   k37  k= 1 ; k37 = "TutorialMainView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k47 ; k47 = "AwakerTrial"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k48 ; k48 = "Btn_Task6"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k49 ; k49 = "FreeTrialView"
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k50  k= 1 ; k50 = "UI_Dungeons_Panel_Tr" (truncated)
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k51  k= 1 ; k51 = "FreeTrialTitle"
.line	1	newtable      r4     0     1     1
.line	0	extraarg       0
.line	0	gettabup      r5    u1   k41 ; k41 = "cd"
.line	0	getfield      r5    r5   k42 ; k42 = "FeatureId"
.line	0	getfield      r5    r5   k52 ; k52 = "ResidentTrial"
.line	0	setlist       r4     1     0     0
.line	0	setfield      r3   k40    r4 ; k40 = "feature"
.abslineinfo	127	186
.line	128	gettabup      r4    u1   k53 ; k53 = "RedPointDataUtils"
.line	0	getfield      r4    r4   k54 ; k54 = "HasFreeTrialAward"
.line	0	setfield      r3   k43    r4 ; k43 = "redFunc"
.line	2	setfield      r3   k18   k49  k= 1 ; k49 = "FreeTrialView"
.line	1	settable      r1    r2    r3
.line	1	gettabup      r2    u0   k55 ; k55 = "BattleTeaching"
.line	0	newtable      r3     4     0     1
.line	0	extraarg       0
.line	1	getfield      r4    r0    k3 ; k3 = "ui"
.line	0	getfield      r4    r4   k56 ; k56 = "Btn_Task7"
.line	0	setfield      r3    k2    r4 ; k2 = "toggleObj"
.line	1	gettabup      r4    u1    k6 ; k6 = "Urls"
.line	0	getfield      r4    r4   k57 ; k57 = "DungeonBattleTeachin" (truncated)
.line	0	setfield      r3    k5    r4 ; k5 = "UIUrl"
.line	1	setfield      r3    k8   k58  k= 1 ; k58 = "UI_Dungeons_BattleTe" (truncated)
.line	1	setfield      r3   k14   k15  k= 1 ; k15 = nil
.line	1	setfield      r3   k16   k59  k= 1 ; k59 = "BattleTeachingLabel"
.line	1	newtable      r4     0     1     1
.line	0	extraarg       0
.line	0	gettabup      r5    u1   k41 ; k41 = "cd"
.line	0	getfield      r5    r5   k42 ; k42 = "FeatureId"
.line	0	getfield      r5    r5   k55 ; k55 = "BattleTeaching"
.line	0	setlist       r4     1     0     0
.line	0	setfield      r3   k40    r4 ; k40 = "feature"
.line	1	gettabup      r4    u1   k53 ; k53 = "RedPointDataUtils"
.line	0	getfield      r4    r4   k60 ; k60 = "IsShowBattleTeaching" (truncated)
.line	0	setfield      r3   k43    r4 ; k43 = "redFunc"
.line	1	setfield      r3   k18   k57  k= 1 ; k57 = "DungeonBattleTeachin" (truncated)
.line	1	settable      r1    r2    r3
.line	1	setfield      r0    k0    r1 ; k0 = "childrenTapViews"
.line	1	return0       r1     1     0     0

.function	main/f7/f0

.source	null
.linedefined	172
.lastlinedefined	176
.numparams	0
.is_vararg	0
.maxstacksize	3

.upvalue	"_ENV"	1	false

.constant	k0	"RedPointDataUtils"
.constant	k1	"ReqRemoveData"
.constant	k2	"RedType"
.constant	k3	"Tutorial"
.constant	k4	"RedAttrType"
.constant	k5	"IsNew"

.line	1	gettabup      r0    u0    k0 ; k0 = "RedPointDataUtils"
.line	0	getfield      r0    r0    k1 ; k1 = "ReqRemoveData"
.line	1	gettabup      r1    u0    k0 ; k0 = "RedPointDataUtils"
.line	0	getfield      r1    r1    k2 ; k2 = "RedType"
.line	0	getfield      r1    r1    k3 ; k3 = "Tutorial"
.line	0	gettabup      r2    u0    k0 ; k0 = "RedPointDataUtils"
.line	0	getfield      r2    r2    k4 ; k4 = "RedAttrType"
.line	1	getfield      r2    r2    k5 ; k5 = "IsNew"
.line	254	call          r0     3     1
.line	3	return0       r0     1     0     0

.function	main/f8

.source	null
.linedefined	203
.lastlinedefined	205
.numparams	1
.is_vararg	0
.maxstacksize	5

.local	"self"	0	10

.upvalue	"_ENV"	0	false
.upvalue	"TaskPage"	3	true

.constant	k0	"TaskModel"
.constant	k1	"Instance"
.constant	k2	"GetTaskPageResUrl"
.constant	k3	"Career"

.line	1	newtable      r1     0     0     1
.line	0	extraarg       0
.line	0	gettabup      r2    u0    k0 ; k0 = "TaskModel"
.line	0	getfield      r2    r2    k1 ; k1 = "Instance"
.line	0	self          r2    r2    k2  k= 1 ; k2 = "GetTaskPageResUrl"
.line	0	gettabup      r4    u1    k3 ; k3 = "Career"
.line	0	call          r2     3     0
.line	0	setlist       r1     0     0     0
.line	0	return1       r1     2     0     0
.line	1	return0       r1     1     0     0

.function	main/f9

.source	null
.linedefined	207
.lastlinedefined	210
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"self"	0	9

.upvalue	"Super"	1	true
.upvalue	"_ENV"	0	false
.upvalue	"TaskPage"	3	true

.constant	k0	"OnExitView"
.constant	k1	"TaskModel"
.constant	k2	"Instance"
.constant	k3	"SetCurTaskPage"
.constant	k4	"Career"

.line	1	gettabup      r1    u0    k0 ; k0 = "OnExitView"
.line	0	move          r2    r0
.line	0	call          r1     2     1
.line	1	gettabup      r1    u1    k1 ; k1 = "TaskModel"
.line	0	getfield      r1    r1    k2 ; k2 = "Instance"
.line	0	self          r1    r1    k3  k= 1 ; k3 = "SetCurTaskPage"
.line	0	gettabup      r3    u2    k4 ; k4 = "Career"
.line	0	call          r1     3     1
.line	1	return0       r1     1     0     0

.function	main/f10

.source	null
.linedefined	212
.lastlinedefined	216
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"self"	0	9

.upvalue	"_ENV"	0	false

.constant	k0	"UIManager"
.constant	k1	"Instance"
.constant	k2	"ReShowBehindPanel"
.constant	k3	"clickClose"
.constant	k4	true
.constant	k5	"PlayCloseAnim"

.line	1	gettabup      r1    u0    k0 ; k0 = "UIManager"
.line	0	getfield      r1    r1    k1 ; k1 = "Instance"
.line	0	self          r1    r1    k2  k= 1 ; k2 = "ReShowBehindPanel"
.line	0	move          r3    r0
.line	0	call          r1     3     1
.line	1	setfield      r0    k3    k4  k= 1 ; k4 = true
.line	1	self          r1    r0    k5  k= 1 ; k5 = "PlayCloseAnim"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f11

.source	null
.linedefined	218
.lastlinedefined	235
.numparams	2
.is_vararg	0
.maxstacksize	9

.local	"self"	0	57
.local	"tabIndex"	0	57
.local	"serverIdx"	9	57
.local	"_"	10	57
.local	"unlocked"	10	57
.local	"feature"	22	57

.upvalue	"_ENV"	0	false

.constant	k0	"childrenTapViews"
.constant	k1	"serverIdx"
.constant	k2	"feature"
.constant	k3	"CommonDefine"
.constant	k4	"FeatureId"
.constant	k5	"Task"
.constant	k6	"PlayerDataUtils"
.constant	k7	"IsFeatureUnlock"
.constant	k8	"AlertLockedTips"

.line	1	getfield      r2    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	test          r2     1
.line	0	jmp           l7
.line	1	loadfalse     r2
.line	0	return1       r2     2     0     0
.label	l7
.line	2	getfield      r2    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	getfield      r2    r2    k1 ; k1 = "serverIdx"
.line	1	loadnil       r3     1
.line	1	getfield      r5    r0    k0 ; k0 = "childrenTapViews"
.line	0	gettable      r5    r5    r1
.line	0	getfield      r5    r5    k2 ; k2 = "feature"
.line	0	test          r5     1
.line	0	jmp          l23
.line	0	newtable      r5     0     2     1
.line	0	extraarg       0
.line	0	gettabup      r6    u0    k3 ; k3 = "CommonDefine"
.line	0	getfield      r6    r6    k4 ; k4 = "FeatureId"
.line	0	getfield      r6    r6    k5 ; k5 = "Task"
.line	0	move          r7    r2
.line	0	setlist       r5     2     0     0
.label	l23
.line	1	test          r2     0
.line	0	jmp          l35
.line	1	gettabup      r6    u0    k6 ; k6 = "PlayerDataUtils"
.line	0	getfield      r6    r6    k7 ; k7 = "IsFeatureUnlock"
.line	0	gettabup      r7    u0    k3 ; k3 = "CommonDefine"
.line	0	getfield      r7    r7    k4 ; k4 = "FeatureId"
.line	0	getfield      r7    r7    k5 ; k5 = "Task"
.line	0	move          r8    r2
.line	0	call          r6     3     3
.line	0	move          r4    r7
.line	0	move          r3    r6
.line	0	jmp          l46
.label	l35
.line	1	test          r2     1
.line	0	jmp          l46
.line	0	test          r5     0
.line	0	jmp          l46
.line	1	gettabup      r6    u0    k6 ; k6 = "PlayerDataUtils"
.line	0	getfield      r6    r6    k7 ; k7 = "IsFeatureUnlock"
.line	0	geti          r7    r5     1
.line	0	geti          r8    r5     2
.line	0	call          r6     3     3
.line	0	move          r4    r7
.line	0	move          r3    r6
.label	l46
.line	2	test          r4     1
.line	0	jmp          l55
.line	1	gettabup      r6    u0    k6 ; k6 = "PlayerDataUtils"
.line	0	getfield      r6    r6    k8 ; k8 = "AlertLockedTips"
.line	0	geti          r7    r5     1
.line	0	geti          r8    r5     2
.line	0	call          r6     3     1
.line	1	loadfalse     r6
.line	0	return1       r6     2     0     0
.label	l55
.line	2	loadtrue      r6
.line	0	return1       r6     2     0     0
.line	1	return0       r6     1     0     0

.function	main/f12

.source	null
.linedefined	237
.lastlinedefined	266
.numparams	2
.is_vararg	0
.maxstacksize	8

.local	"self"	0	71
.local	"tabIndex"	0	71
.local	"serverIdx"	10	71

.upvalue	"_ENV"	0	false
.upvalue	"TaskPage"	3	true

.constant	k0	"CheckSwitchPageUnlocked"
.constant	k1	"_isTabSwitchAnimating"
.constant	k2	true
.constant	k3	"childrenTapViews"
.constant	k4	"serverIdx"
.constant	k5	"RedPointDataUtils"
.constant	k6	"ReqRemoveData"
.constant	k7	"RedType"
.constant	k8	"Task"
.constant	k9	"RedAttrType"
.constant	k10	"IsNew"
.constant	k11	"TaskModel"
.constant	k12	"Instance"
.constant	k13	"SetCurServerIndex"
.constant	k14	"callback"
.constant	k15	"lastTabIndex"
.constant	k16	"curTabIndex"
.constant	k17	"Tutorial"
.constant	k18	"viewInstance"
.constant	k19	"ReqTutorialFinishReadCb"
.constant	k20	"SetText"
.constant	k21	"ui"
.constant	k22	"Text_Label"
.constant	k23	"LT"
.constant	k24	"Text"
.constant	k25	"labelNameLangKey"
.constant	k26	"_RefreshTabsStatus"
.constant	k27	"SwitchChildTapView"
.constant	k28	"switchCb"
.constant	k29	nil

.line	1	self          r2    r0    k0  k= 1 ; k0 = "CheckSwitchPageUnloc" (truncated)
.line	0	move          r4    r1
.line	0	call          r2     3     2
.line	0	test          r2     1
.line	0	jmp           l7
.line	1	return0       r2     1     0     0
.label	l7
.line	2	setfield      r0    k1    k2  k= 1 ; k2 = true
.line	1	getfield      r2    r0    k3 ; k3 = "childrenTapViews"
.line	0	gettable      r2    r2    r1
.line	0	getfield      r2    r2    k4 ; k4 = "serverIdx"
.line	1	test          r2     0
.line	0	jmp          l28
.line	1	gettabup      r3    u0    k5 ; k5 = "RedPointDataUtils"
.line	0	getfield      r3    r3    k6 ; k6 = "ReqRemoveData"
.line	1	gettabup      r4    u0    k5 ; k5 = "RedPointDataUtils"
.line	0	getfield      r4    r4    k7 ; k7 = "RedType"
.line	0	getfield      r4    r4    k8 ; k8 = "Task"
.line	0	gettabup      r5    u0    k5 ; k5 = "RedPointDataUtils"
.line	0	getfield      r5    r5    k9 ; k9 = "RedAttrType"
.line	0	getfield      r5    r5   k10 ; k10 = "IsNew"
.line	1	move          r6    r2
.line	254	call          r3     4     1
.line	3	gettabup      r3    u0   k11 ; k11 = "TaskModel"
.line	0	getfield      r3    r3   k12 ; k12 = "Instance"
.line	0	self          r3    r3   k13  k= 1 ; k13 = "SetCurServerIndex"
.line	0	move          r5    r2
.line	0	call          r3     3     1
.label	l28
.line	2	getfield      r3    r0    k3 ; k3 = "childrenTapViews"
.line	0	gettable      r3    r3    r1
.line	0	getfield      r3    r3   k14 ; k14 = "callback"
.line	0	test          r3     0
.line	0	jmp          l37
.line	1	getfield      r3    r0    k3 ; k3 = "childrenTapViews"
.line	0	gettable      r3    r3    r1
.line	0	getfield      r3    r3   k14 ; k14 = "callback"
.line	0	call          r3     1     1
.label	l37
.line	2	getfield      r3    r0   k16 ; k16 = "curTabIndex"
.line	0	setfield      r0   k15    r3 ; k15 = "lastTabIndex"
.line	1	getfield      r3    r0   k16 ; k16 = "curTabIndex"
.line	0	gettabup      r4    u1   k17 ; k17 = "Tutorial"
.line	0	eq            r3    r4     0
.line	0	jmp          l49
.line	2	getfield      r3    r0    k3 ; k3 = "childrenTapViews"
.line	0	getfield      r4    r0   k16 ; k16 = "curTabIndex"
.line	0	gettable      r3    r3    r4
.line	0	getfield      r3    r3   k18 ; k18 = "viewInstance"
.line	0	self          r3    r3   k19  k= 1 ; k19 = "ReqTutorialFinishRea" (truncated)
.line	0	call          r3     2     1
.label	l49
.line	2	self          r3    r0   k20  k= 1 ; k20 = "SetText"
.line	0	getfield      r5    r0   k21 ; k21 = "ui"
.line	0	getfield      r5    r5   k22 ; k22 = "Text_Label"
.line	0	gettabup      r6    u0   k23 ; k23 = "LT"
.line	0	getfield      r6    r6   k24 ; k24 = "Text"
.line	0	getfield      r7    r0    k3 ; k3 = "childrenTapViews"
.line	0	gettable      r7    r7    r1
.line	0	getfield      r7    r7   k25 ; k25 = "labelNameLangKey"
.line	0	call          r6     2     0
.line	0	call          r3     0     1
.line	1	setfield      r0   k16    r1 ; k16 = "curTabIndex"
.line	1	self          r3    r0   k26  k= 1 ; k26 = "_RefreshTabsStatus"
.line	0	call          r3     2     1
.line	2	self          r3    r0   k27  k= 1 ; k27 = "SwitchChildTapView"
.line	0	move          r5    r1
.line	0	call          r3     3     1
.line	1	getfield      r3    r0   k28 ; k28 = "switchCb"
.line	0	test          r3     0
.line	0	jmp          l71
.line	1	getfield      r3    r0   k28 ; k28 = "switchCb"
.line	0	call          r3     1     1
.line	1	setfield      r0   k28   k29  k= 1 ; k29 = nil
.label	l71
.line	2	return0       r3     1     0     0

.function	main/f13

.source	null
.linedefined	268
.lastlinedefined	294
.numparams	1
.is_vararg	0
.maxstacksize	19

.local	"self"	0	80
.local	"(for state)"	3	79
.local	"(for state)"	3	79
.local	"(for state)"	3	79
.local	"tabIndex"	4	77
.local	"toggleBtn"	9	77
.local	"group_Normal"	15	77
.local	"group_Selected"	23	77
.local	"unlocked"	35	77
.local	"serverIdx"	46	77
.local	"redDot"	50	77
.local	"redFunc"	53	77

.upvalue	"TOGGLE_COUNT"	5	true
.upvalue	"_ENV"	0	false

.constant	k0	"ui"
.constant	k1	"Btn_Task"
.constant	k2	"FindChild"
.constant	k3	"Group_Normal"
.constant	k4	"SetActive"
.constant	k5	"Group_Selected"
.constant	k6	"curTabIndex"
.constant	k7	"TaskModel"
.constant	k8	"Instance"
.constant	k9	"IsPageUnlocked"
.constant	k10	"hideToggles"
.constant	k11	"childrenTapViews"
.constant	k12	"serverIdx"
.constant	k13	"Com_RedDot"
.constant	k14	"redFunc"
.constant	k15	"AddViewComponentOnce"
.constant	k16	"UICompRedDot"
.constant	k17	"CommonDefine"
.constant	k18	"RedDotType"
.constant	k19	"Dot"

.line	1	loadi         r1     1
.line	0	getupval      r2    u0
.line	0	loadi         r3     1
.line	0	forprep       r1   l78
.label	l5
.line	1	getfield      r5    r0    k0 ; k0 = "ui"
.line	0	loadk         r6    k1 ; k1 = "Btn_Task"
.line	0	move          r7    r4
.line	0	concat        r6     2
.line	0	gettable      r5    r5    r6
.line	1	test          r5     0
.line	0	jmp          l79
.line	3	self          r6    r0    k2  k= 1 ; k2 = "FindChild"
.line	0	move          r8    r5
.line	0	loadk         r9    k3 ; k3 = "Group_Normal"
.line	0	call          r6     4     2
.line	1	self          r7    r0    k4  k= 1 ; k4 = "SetActive"
.line	0	move          r9    r6
.line	0	loadtrue     r10
.line	0	call          r7     4     1
.line	1	self          r7    r0    k2  k= 1 ; k2 = "FindChild"
.line	0	move          r9    r5
.line	0	loadk        r10    k5 ; k5 = "Group_Selected"
.line	0	call          r7     4     2
.line	1	self          r8    r7    k4  k= 1 ; k4 = "SetActive"
.line	0	getfield     r10    r0    k6 ; k6 = "curTabIndex"
.line	0	eq            r4   r10     1
.line	0	jmp          l29
.line	0	lfalseskip   r10
.label	l29
.line	0	loadtrue     r10
.line	0	call          r8     3     1
.line	2	gettabup      r8    u1    k7 ; k7 = "TaskModel"
.line	0	getfield      r8    r8    k8 ; k8 = "Instance"
.line	0	self          r8    r8    k9  k= 1 ; k9 = "IsPageUnlocked"
.line	0	move         r10    r4
.line	0	call          r8     3     2
.line	1	self          r9    r5    k4  k= 1 ; k4 = "SetActive"
.line	0	getfield     r11    r0   k10 ; k10 = "hideToggles"
.line	0	test         r11     1
.line	0	jmp          l42
.line	0	testset      r11    r8     1
.line	0	jmp          l43
.label	l42
.line	0	loadfalse    r11
.label	l43
.line	0	call          r9     3     1
.line	2	getfield      r9    r0   k11 ; k11 = "childrenTapViews"
.line	0	gettable      r9    r9    r4
.line	0	getfield      r9    r9   k12 ; k12 = "serverIdx"
.line	2	self         r10    r0    k2  k= 1 ; k2 = "FindChild"
.line	0	move         r12    r5
.line	0	loadk        r13   k13 ; k13 = "Com_RedDot"
.line	0	call         r10     4     2
.line	1	getfield     r11    r0   k11 ; k11 = "childrenTapViews"
.line	0	gettable     r11   r11    r4
.line	0	getfield     r11   r11   k14 ; k14 = "redFunc"
.line	1	test          r9     0
.line	0	jmp          l66
.line	1	self         r12    r0   k15  k= 1 ; k15 = "AddViewComponentOnce"
.line	0	move         r14   r10
.line	0	gettabup     r15    u1   k16 ; k16 = "UICompRedDot"
.line	0	gettabup     r16    u1   k17 ; k17 = "CommonDefine"
.line	0	getfield     r16   r16   k18 ; k18 = "RedDotType"
.line	0	getfield     r16   r16   k19 ; k19 = "Dot"
.line	0	loadnil      r17     0
.line	2	closure      r18    f0
.line	254	call         r12     7     1
.line	2	jmp          l77
.label	l66
.line	1	test         r11     0
.line	0	jmp          l77
.line	1	self         r12    r0   k15  k= 1 ; k15 = "AddViewComponentOnce"
.line	0	move         r14   r10
.line	0	gettabup     r15    u1   k16 ; k16 = "UICompRedDot"
.line	0	gettabup     r16    u1   k17 ; k17 = "CommonDefine"
.line	0	getfield     r16   r16   k18 ; k18 = "RedDotType"
.line	0	getfield     r16   r16   k19 ; k19 = "Dot"
.line	0	loadnil      r17     0
.line	0	move         r18   r11
.line	0	call         r12     7     1
.label	l77
.line	1	close         r5
.label	l78
.line	233	forloop       r1    l5
.label	l79
.line	24	close         r4
.line	1	return        r1     1     0     1

.function	main/f13/f0

.source	null
.linedefined	287
.lastlinedefined	289
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"_ENV"	1	false
.upvalue	"serverIdx"	9	true

.constant	k0	"RedPointDataUtils"
.constant	k1	"IsShowTaskRedPoint"

.line	1	gettabup      r0    u0    k0 ; k0 = "RedPointDataUtils"
.line	0	getfield      r0    r0    k1 ; k1 = "IsShowTaskRedPoint"
.line	0	getupval      r1    u1
.line	0	return        r0     2     0     0
.line	0	return        r0     0     0     0
.line	1	return0       r0     1     0     0

.function	main/f14

.source	null
.linedefined	296
.lastlinedefined	322
.numparams	1
.is_vararg	0
.maxstacksize	8

.local	"self"	0	61
.local	"clipsToPlay"	1	61
.local	"oldPage"	2	61
.local	"newPage"	3	61
.local	"curPageUrl"	48	61
.local	"panel"	53	61

.upvalue	"AddClipToPlay"	4	true
.upvalue	"_ENV"	0	false

.constant	k0	""
.constant	k1	"lastTabIndex"
.constant	k2	"curTabIndex"
.constant	k3	"UI_Task_Panel_Main_New_Open"
.constant	k4	"childrenTapViews"
.constant	k5	"closeAnimClip"
.constant	k6	"enterAnimClip"
.constant	k7	"uiAnimController"
.constant	k8	"PlayMultiState"
.constant	k9	"UIUrl"
.constant	k10	"UIManager"
.constant	k11	"Instance"
.constant	k12	"GetWindow"
.constant	k13	"PlayOpenAnimation"

.line	1	loadk         r1    k0 ; k0 = ""
.line	1	getfield      r2    r0    k1 ; k1 = "lastTabIndex"
.line	1	getfield      r3    r0    k2 ; k2 = "curTabIndex"
.line	2	test          r2     1
.line	0	jmp          l12
.line	1	getupval      r4    u0
.line	0	move          r5    r1
.line	0	loadk         r6    k3 ; k3 = "UI_Task_Panel_Main_N" (truncated)
.line	0	call          r4     3     2
.line	0	move          r1    r4
.line	0	jmp          l40
.label	l12
.line	3	test          r2     0
.line	0	jmp          l26
.line	0	getfield      r4    r0    k4 ; k4 = "childrenTapViews"
.line	0	gettable      r4    r4    r2
.line	0	getfield      r4    r4    k5 ; k5 = "closeAnimClip"
.line	0	test          r4     0
.line	0	jmp          l26
.line	1	getupval      r4    u0
.line	0	move          r5    r1
.line	0	getfield      r6    r0    k4 ; k4 = "childrenTapViews"
.line	0	gettable      r6    r6    r2
.line	0	getfield      r6    r6    k5 ; k5 = "closeAnimClip"
.line	0	call          r4     3     2
.line	0	move          r1    r4
.label	l26
.line	3	test          r3     0
.line	0	jmp          l40
.line	0	getfield      r4    r0    k4 ; k4 = "childrenTapViews"
.line	0	gettable      r4    r4    r3
.line	0	getfield      r4    r4    k6 ; k6 = "enterAnimClip"
.line	0	test          r4     0
.line	0	jmp          l40
.line	1	getupval      r4    u0
.line	0	move          r5    r1
.line	0	getfield      r6    r0    k4 ; k4 = "childrenTapViews"
.line	0	gettable      r6    r6    r3
.line	0	getfield      r6    r6    k6 ; k6 = "enterAnimClip"
.line	0	call          r4     3     2
.line	0	move          r1    r4
.label	l40
.line	3	getfield      r4    r0    k7 ; k7 = "uiAnimController"
.line	0	self          r4    r4    k8  k= 1 ; k8 = "PlayMultiState"
.line	0	move          r6    r1
.line	2	closure       r7    f0
.line	254	call          r4     4     1
.line	4	getfield      r4    r0    k4 ; k4 = "childrenTapViews"
.line	0	getfield      r5    r0    k2 ; k2 = "curTabIndex"
.line	0	gettable      r4    r4    r5
.line	0	getfield      r4    r4    k9 ; k9 = "UIUrl"
.line	1	gettabup      r5    u1   k10 ; k10 = "UIManager"
.line	0	getfield      r5    r5   k11 ; k11 = "Instance"
.line	0	self          r5    r5   k12  k= 1 ; k12 = "GetWindow"
.line	0	move          r7    r4
.line	0	call          r5     3     2
.line	1	test          r5     0
.line	0	jmp          l61
.line	0	getfield      r6    r5   k13 ; k13 = "PlayOpenAnimation"
.line	0	test          r6     0
.line	0	jmp          l61
.line	1	self          r6    r5   k13  k= 1 ; k13 = "PlayOpenAnimation"
.line	0	call          r6     2     1
.label	l61
.line	2	return        r6     1     0     1

.function	main/f14/f0

.source	null
.linedefined	313
.lastlinedefined	315
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true

.constant	k0	"_isTabSwitchAnimating"
.constant	k1	nil

.line	1	settabup      u0    k0    k1  k= 1 ; k1 = nil
.line	1	return0       r0     1     0     0

.function	main/f15

.source	null
.linedefined	324
.lastlinedefined	326
.numparams	2
.is_vararg	0
.maxstacksize	5

.local	"self"	0	4
.local	"paged"	0	4

.constant	k0	"SwitchPage"

.line	1	self          r2    r0    k0  k= 1 ; k0 = "SwitchPage"
.line	0	move          r4    r1
.line	0	call          r2     3     1
.line	1	return0       r2     1     0     0

.function	main/f16

.source	null
.linedefined	328
.lastlinedefined	344
.numparams	1
.is_vararg	0
.maxstacksize	11

.local	"self"	0	36
.local	"curPageUrl"	7	36
.local	"(for state)"	10	28
.local	"(for state)"	10	28
.local	"(for state)"	10	28
.local	"(for state)"	10	28
.local	"_"	11	25
.local	"v"	11	25

.upvalue	"Super"	1	true
.upvalue	"_ENV"	0	false

.constant	k0	"_OnChildTapViewSwitchedFinished"
.constant	k1	"childrenTapViews"
.constant	k2	"curTabIndex"
.constant	k3	"UIUrl"
.constant	k4	"pairs"
.constant	k5	"viewInstance"
.constant	k6	"SetRendered"
.constant	k7	"CloseChildPanel"
.constant	k8	"SetCanvasGroup"
.constant	k9	"ui"
.constant	k10	"uiNode"
.constant	k11	"PlaySwitchPageAnim"

.line	1	gettabup      r1    u0    k0 ; k0 = "_OnChildTapViewSwitc" (truncated)
.line	0	move          r2    r0
.line	0	call          r1     2     1
.line	2	getfield      r1    r0    k1 ; k1 = "childrenTapViews"
.line	0	getfield      r2    r0    k2 ; k2 = "curTabIndex"
.line	0	gettable      r1    r1    r2
.line	0	getfield      r1    r1    k3 ; k3 = "UIUrl"
.line	1	gettabup      r2    u1    k4 ; k4 = "pairs"
.line	0	getfield      r3    r0    k1 ; k1 = "childrenTapViews"
.line	0	call          r2     2     5
.line	0	tforprep      r2   l26
.label	l12
.line	1	getfield      r8    r7    k3 ; k3 = "UIUrl"
.line	0	eq            r1    r8     1
.line	0	jmp          l26
.line	1	getfield      r8    r7    k5 ; k5 = "viewInstance"
.line	0	test          r8     0
.line	0	jmp          l23
.line	1	getfield      r8    r7    k5 ; k5 = "viewInstance"
.line	0	self          r8    r8    k6  k= 1 ; k6 = "SetRendered"
.line	0	loadfalse    r10
.line	0	call          r8     3     1
.line	0	jmp          l26
.label	l23
.line	2	self          r8    r0    k7  k= 1 ; k7 = "CloseChildPanel"
.line	0	getfield     r10    r7    k3 ; k3 = "UIUrl"
.line	0	call          r8     3     1
.label	l26
.line	251	tforcall      r2     2
.line	0	tforloop      r2   l12
.line	8	close         r2
.line	1	self          r2    r0    k8  k= 1 ; k8 = "SetCanvasGroup"
.line	0	getfield      r4    r0    k9 ; k9 = "ui"
.line	0	getfield      r4    r4   k10 ; k10 = "uiNode"
.line	0	loadi         r5     1
.line	0	call          r2     4     1
.line	2	self          r2    r0   k11  k= 1 ; k11 = "PlaySwitchPageAnim"
.line	0	call          r2     2     1
.line	1	return        r2     1     0     1

.function	main/f17

.source	null
.linedefined	348
.lastlinedefined	371
.numparams	1
.is_vararg	0
.maxstacksize	8

.local	"self"	0	51
.local	"clipsToPlay"	7	51
.local	"aniQuit"	11	51
.local	"viewInstance"	22	51

.upvalue	"AddClipToPlay"	4	true
.upvalue	"_ENV"	0	false

.constant	k0	"curTabIndex"
.constant	k1	"Close"
.constant	k2	""
.constant	k3	"childrenTapViews"
.constant	k4	"closeAnimClip"
.constant	k5	"viewInstance"
.constant	k6	"compBtnClosed"
.constant	k7	"PlayCloseAnim"
.constant	k8	"UI_Task_Panel_Main_New_Close"
.constant	k9	"EventMgr"
.constant	k10	"Instance"
.constant	k11	"OpenAnimMask"
.constant	k12	"Dispatch"
.constant	k13	"uiAnimController"
.constant	k14	"StopPlayableGraph"
.constant	k15	"PlayMultiState"

.line	1	getfield      r1    r0    k0 ; k0 = "curTabIndex"
.line	0	test          r1     1
.line	0	jmp           l7
.line	1	self          r1    r0    k1  k= 1 ; k1 = "Close"
.line	0	call          r1     2     1
.line	1	return        r1     1     0     1
.label	l7
.line	2	loadk         r1    k2 ; k2 = ""
.line	1	getfield      r2    r0    k3 ; k3 = "childrenTapViews"
.line	0	getfield      r3    r0    k0 ; k0 = "curTabIndex"
.line	0	gettable      r2    r2    r3
.line	0	getfield      r2    r2    k4 ; k4 = "closeAnimClip"
.line	1	test          r2     0
.line	0	jmp          l19
.line	1	getupval      r3    u0
.line	0	move          r4    r1
.line	0	move          r5    r2
.line	0	call          r3     3     2
.line	0	move          r1    r3
.label	l19
.line	2	getfield      r3    r0    k3 ; k3 = "childrenTapViews"
.line	0	getfield      r4    r0    k0 ; k0 = "curTabIndex"
.line	0	gettable      r3    r3    r4
.line	0	getfield      r3    r3    k5 ; k5 = "viewInstance"
.line	1	test          r3     0
.line	0	jmp          l30
.line	0	getfield      r4    r3    k1 ; k1 = "Close"
.line	0	test          r4     0
.line	0	jmp          l30
.line	1	self          r4    r3    k1  k= 1 ; k1 = "Close"
.line	0	call          r4     2     1
.label	l30
.line	2	getfield      r4    r0    k6 ; k6 = "compBtnClosed"
.line	0	self          r4    r4    k7  k= 1 ; k7 = "PlayCloseAnim"
.line	0	call          r4     2     1
.line	2	getupval      r4    u0
.line	0	move          r5    r1
.line	0	loadk         r6    k8 ; k8 = "UI_Task_Panel_Main_N" (truncated)
.line	0	call          r4     3     2
.line	0	move          r1    r4
.line	1	gettabup      r4    u1    k9 ; k9 = "EventMgr"
.line	0	getfield      r4    r4   k10 ; k10 = "Instance"
.line	0	getfield      r4    r4   k11 ; k11 = "OpenAnimMask"
.line	0	self          r4    r4   k12  k= 1 ; k12 = "Dispatch"
.line	0	call          r4     2     1
.line	1	getfield      r4    r0   k13 ; k13 = "uiAnimController"
.line	0	self          r4    r4   k14  k= 1 ; k14 = "StopPlayableGraph"
.line	0	call          r4     2     1
.line	1	getfield      r4    r0   k13 ; k13 = "uiAnimController"
.line	0	self          r4    r4   k15  k= 1 ; k15 = "PlayMultiState"
.line	0	move          r6    r1
.line	3	closure       r7    f0
.line	253	call          r4     4     1
.line	4	return        r4     1     0     1

.function	main/f17/f0

.source	null
.linedefined	367
.lastlinedefined	370
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true
.upvalue	"_ENV"	1	false

.constant	k0	"Close"
.constant	k1	"EventMgr"
.constant	k2	"Instance"
.constant	k3	"CloseAnimMask"
.constant	k4	"Dispatch"

.line	1	getupval      r0    u0
.line	0	self          r0    r0    k0  k= 1 ; k0 = "Close"
.line	0	call          r0     2     1
.line	1	gettabup      r0    u1    k1 ; k1 = "EventMgr"
.line	0	getfield      r0    r0    k2 ; k2 = "Instance"
.line	0	getfield      r0    r0    k3 ; k3 = "CloseAnimMask"
.line	0	self          r0    r0    k4  k= 1 ; k4 = "Dispatch"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f18

.source	null
.linedefined	373
.lastlinedefined	379
.numparams	1
.is_vararg	0
.maxstacksize	3

.local	"self"	0	19

.upvalue	"Super"	1	true
.upvalue	"_ENV"	0	false

.constant	k0	"Close"
.constant	k1	"bg"
.constant	k2	"IsInBattle"
.constant	k3	"WorldStageManager"
.constant	k4	"Instance"
.constant	k5	"IsInStage"
.constant	k6	"SceneMgr"
.constant	k7	"EnterTown"

.line	1	gettabup      r1    u0    k0 ; k0 = "Close"
.line	0	move          r2    r0
.line	0	call          r1     2     1
.line	2	gettabup      r1    u1    k1 ; k1 = "bg"
.line	0	getfield      r1    r1    k2 ; k2 = "IsInBattle"
.line	0	call          r1     1     2
.line	0	test          r1     1
.line	0	jmp          l19
.line	0	gettabup      r1    u1    k3 ; k3 = "WorldStageManager"
.line	0	getfield      r1    r1    k4 ; k4 = "Instance"
.line	0	self          r1    r1    k5  k= 1 ; k5 = "IsInStage"
.line	0	call          r1     2     2
.line	0	test          r1     1
.line	0	jmp          l19
.line	1	gettabup      r1    u1    k6 ; k6 = "SceneMgr"
.line	0	getfield      r1    r1    k4 ; k4 = "Instance"
.line	0	self          r1    r1    k7  k= 1 ; k7 = "EnterTown"
.line	0	call          r1     2     1
.label	l19
.line	2	return0       r1     1     0     0

