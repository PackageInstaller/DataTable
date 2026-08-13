class = var_0_10000

local var_0_0 = "PrepControllerCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.facade
	local var_1_1 = var_2.registerCommand

	GAME = var_1_10004

	local var_1_2 = var_1_10004.LOAD_CONTEXT

	LoadContextCommand = var_1_10005

	var_1_1(var_1_0, var_1_2, var_1_10005)

	local var_1_3 = arg_1_0.facade
	local var_1_4 = var_2.registerCommand

	GAME = var_1_2

	local var_1_5 = var_1_2.LOAD_SCENE

	LoadSceneCommand = var_1_10005

	var_1_4(var_1_3, var_1_5, var_1_10005)

	local var_1_6 = arg_1_0.facade
	local var_1_7 = var_2.registerCommand

	GAME = var_1_5

	local var_1_8 = var_1_5.CHANGE_SCENE

	ChangeSceneCommand = var_1_10005

	var_1_7(var_1_6, var_1_8, var_1_10005)

	local var_1_9 = arg_1_0.facade
	local var_1_10 = var_2.registerCommand

	GAME = var_1_8

	local var_1_11 = var_1_8.HOEM_SCENE

	HomeSceneCommand = var_1_10005

	var_1_10(var_1_9, var_1_11, var_1_10005)

	local var_1_12 = arg_1_0.facade
	local var_1_13 = var_2.registerCommand

	GAME = var_1_11

	local var_1_14 = var_1_11.GO_BACK

	GoBackCommand = var_1_10005

	var_1_13(var_1_12, var_1_14, var_1_10005)

	local var_1_15 = arg_1_0.facade
	local var_1_16 = var_2.registerCommand

	GAME = var_1_14

	local var_1_17 = var_1_14.REMOVE_LAYERS

	RemoveLayersCommand = var_1_10005

	var_1_16(var_1_15, var_1_17, var_1_10005)

	local var_1_18 = arg_1_0.facade
	local var_1_19 = var_2.registerCommand

	GAME = var_1_17

	local var_1_20 = var_1_17.LOAD_LAYERS

	LoadLayersCommand = var_1_10005

	var_1_19(var_1_18, var_1_20, var_1_10005)

	local var_1_21 = arg_1_0.facade
	local var_1_22 = var_2.registerCommand

	GAME = var_1_20

	local var_1_23 = var_1_20.USER_LOGIN

	UserLoginCommand = var_1_10005

	var_1_22(var_1_21, var_1_23, var_1_10005)

	local var_1_24 = arg_1_0.facade
	local var_1_25 = var_2.registerCommand

	GAME = var_1_23

	local var_1_26 = var_1_23.USER_REGISTER

	UserRegisterCommand = var_1_10005

	var_1_25(var_1_24, var_1_26, var_1_10005)

	local var_1_27 = arg_1_0.facade
	local var_1_28 = var_2.registerCommand

	GAME = var_1_26

	local var_1_29 = var_1_26.SERVER_LOGIN

	ServerLoginCommand = var_1_10005

	var_1_28(var_1_27, var_1_29, var_1_10005)

	local var_1_30 = arg_1_0.facade
	local var_1_31 = var_2.registerCommand

	GAME = var_1_29

	local var_1_32 = var_1_29.CREATE_NEW_PLAYER

	CreateNewPlayerCommand = var_1_10005

	var_1_31(var_1_30, var_1_32, var_1_10005)

	local var_1_33 = arg_1_0.facade
	local var_1_34 = var_2.registerCommand

	GAME = var_1_32

	local var_1_35 = var_1_32.LOAD_PLAYER_DATA

	LoadPlayerDataCommand = var_1_10005

	var_1_34(var_1_33, var_1_35, var_1_10005)

	local var_1_36 = arg_1_0.facade
	local var_1_37 = var_2.registerCommand

	GAME = var_1_35

	local var_1_38 = var_1_35.SERVER_INTERCOMMECTION

	ServerInterconnectionCommand = var_1_10005

	var_1_37(var_1_36, var_1_38, var_1_10005)

	local var_1_39 = arg_1_0.facade
	local var_1_40 = var_2.registerCommand

	GAME = var_1_38

	local var_1_41 = var_1_38.LOGOUT

	LogoutCommand = var_1_10005

	var_1_40(var_1_39, var_1_41, var_1_10005)

	local var_1_42 = arg_1_0.facade
	local var_1_43 = var_2.registerCommand

	GAME = var_1_41

	local var_1_44 = var_1_41.CHANGE_PLAYER_NAME

	ChangePlayerNameCommand = var_1_10005

	var_1_43(var_1_42, var_1_44, var_1_10005)

	local var_1_45 = arg_1_0.facade
	local var_1_46 = var_2.registerCommand

	GAME = var_1_44

	local var_1_47 = var_1_44.CHANGE_PLAYER_ICON

	ChangePlayerIconCommand = var_1_10005

	var_1_46(var_1_45, var_1_47, var_1_10005)

	local var_1_48 = arg_1_0.facade
	local var_1_49 = var_2.registerCommand

	GAME = var_1_47

	local var_1_50 = var_1_47.CHANGE_PLAYER_MANIFESTO

	ChangeManifestoCommand = var_1_10005

	var_1_49(var_1_48, var_1_50, var_1_10005)

	local var_1_51 = arg_1_0.facade
	local var_1_52 = var_2.registerCommand

	GAME = var_1_50

	local var_1_53 = var_1_50.CHANGE_PLAYER_MEDAL_DISPLAY

	ChangeMedalDisplayCommand = var_1_10005

	var_1_52(var_1_51, var_1_53, var_1_10005)

	local var_1_54 = arg_1_0.facade
	local var_1_55 = var_2.registerCommand

	GAME = var_1_53

	local var_1_56 = var_1_53.HARVEST_RES

	HarvestResourceCommand = var_1_10005

	var_1_55(var_1_54, var_1_56, var_1_10005)

	local var_1_57 = arg_1_0.facade
	local var_1_58 = var_2.registerCommand

	GAME = var_1_56

	local var_1_59 = var_1_56.HARVEST_CLASS_RES

	HarvestClassResourceCommand = var_1_10005

	var_1_58(var_1_57, var_1_59, var_1_10005)

	local var_1_60 = arg_1_0.facade
	local var_1_61 = var_2.registerCommand

	GAME = var_1_59

	local var_1_62 = var_1_59.UPDATE_GUIDE_INDEX

	UpdateGuideIndexCommand = var_1_10005

	var_1_61(var_1_60, var_1_62, var_1_10005)

	local var_1_63 = arg_1_0.facade
	local var_1_64 = var_2.registerCommand

	GAME = var_1_62

	local var_1_65 = var_1_62.GET_PLAYER_SUMMARY_INFO

	GetSummaryInfoCommand = var_1_10005

	var_1_64(var_1_63, var_1_65, var_1_10005)

	local var_1_66 = arg_1_0.facade
	local var_1_67 = var_2.registerCommand

	GAME = var_1_65

	local var_1_68 = var_1_65.ON_PLAYER_RES_CHANGE

	PlayerResChangeCommand = var_1_10005

	var_1_67(var_1_66, var_1_68, var_1_10005)

	local var_1_69 = arg_1_0.facade
	local var_1_70 = var_2.registerCommand

	GAME = var_1_68

	local var_1_71 = var_1_68.GET_SHIP_CNT

	GetShipCntCommand = var_1_10005

	var_1_70(var_1_69, var_1_71, var_1_10005)

	local var_1_72 = arg_1_0.facade
	local var_1_73 = var_2.registerCommand

	GAME = var_1_71

	local var_1_74 = var_1_71.RANDOM_FLAG_SHIP

	RandomFlagshipCommand = var_1_10005

	var_1_73(var_1_72, var_1_74, var_1_10005)

	local var_1_75 = arg_1_0.facade
	local var_1_76 = var_2.registerCommand

	GAME = var_1_74

	local var_1_77 = var_1_74.CHANGE_RANDOM_SHIP_MODE

	ChangeRandomFlagShipModeCommand = var_1_10005

	var_1_76(var_1_75, var_1_77, var_1_10005)

	local var_1_78 = arg_1_0.facade
	local var_1_79 = var_2.registerCommand

	GAME = var_1_77

	local var_1_80 = var_1_77.CHANGE_RANDOM_SHIPS

	ChangeRandomFlagShipsCommand = var_1_10005

	var_1_79(var_1_78, var_1_80, var_1_10005)

	local var_1_81 = arg_1_0.facade
	local var_1_82 = var_2.registerCommand

	GAME = var_1_80

	local var_1_83 = var_1_80.CHANGE_LIVINGAREA_COVER

	ChangeLivingAreaCoverCommand = var_1_10005

	var_1_82(var_1_81, var_1_83, var_1_10005)

	local var_1_84 = arg_1_0.facade
	local var_1_85 = var_2.registerCommand

	GAME = var_1_83

	local var_1_86 = var_1_83.TRACK

	TrackCommand = var_1_10005

	var_1_85(var_1_84, var_1_86, var_1_10005)

	local var_1_87 = arg_1_0.facade
	local var_1_88 = var_2.registerCommand

	GAME = var_1_86

	local var_1_89 = var_1_86.NEW_TRACK

	NewTrackingCommand = var_1_10005

	var_1_88(var_1_87, var_1_89, var_1_10005)

	local var_1_90 = arg_1_0.facade
	local var_1_91 = var_2.registerCommand

	GAME = var_1_89

	local var_1_92 = var_1_89.MAIN_SCENE_TRACK

	MainSceneTrackingCommand = var_1_10005

	var_1_91(var_1_90, var_1_92, var_1_10005)

	local var_1_93 = arg_1_0.facade
	local var_1_94 = var_2.registerCommand

	GAME = var_1_92

	local var_1_95 = var_1_92.UR_EXCHANGE_TRACK

	UrExchangeTrackingCommand = var_1_10005

	var_1_94(var_1_93, var_1_95, var_1_10005)

	local var_1_96 = arg_1_0.facade
	local var_1_97 = var_2.registerCommand

	GAME = var_1_95

	local var_1_98 = var_1_95.GAME_TRACK

	GameTrackingCommand = var_1_10005

	var_1_97(var_1_96, var_1_98, var_1_10005)

	local var_1_99 = arg_1_0.facade
	local var_1_100 = var_2.registerCommand

	GAME = var_1_98

	local var_1_101 = var_1_98.UNLOCK_CRYPTOLALIA

	UnlockCryptolaliaCommand = var_1_10005

	var_1_100(var_1_99, var_1_101, var_1_10005)

	local var_1_102 = arg_1_0.facade
	local var_1_103 = var_2.registerCommand

	GAME = var_1_101

	local var_1_104 = var_1_101.CHEATER_MARK

	CheaterMarkCommand = var_1_10005

	var_1_103(var_1_102, var_1_104, var_1_10005)

	local var_1_105 = arg_1_0.facade
	local var_1_106 = var_2.registerCommand

	GAME = var_1_104

	local var_1_107 = var_1_104.COMMON_FLAG

	UpdateCommonFlagCommand = var_1_10005

	var_1_106(var_1_105, var_1_107, var_1_10005)

	local var_1_108 = arg_1_0.facade
	local var_1_109 = var_2.registerCommand

	GAME = var_1_107

	local var_1_110 = var_1_107.CANCEL_COMMON_FLAG

	CancelCommonFlagCommand = var_1_10005

	var_1_109(var_1_108, var_1_110, var_1_10005)

	local var_1_111 = arg_1_0.facade
	local var_1_112 = var_2.registerCommand

	GAME = var_1_110

	local var_1_113 = var_1_110.BUILD_SHIP

	BuildShipCommand = var_1_10005

	var_1_112(var_1_111, var_1_113, var_1_10005)

	local var_1_114 = arg_1_0.facade
	local var_1_115 = var_2.registerCommand

	GAME = var_1_113

	local var_1_116 = var_1_113.BUILD_SHIP_IMMEDIATELY

	BuildShipImmediatelyCommand = var_1_10005

	var_1_115(var_1_114, var_1_116, var_1_10005)

	local var_1_117 = arg_1_0.facade
	local var_1_118 = var_2.registerCommand

	GAME = var_1_116

	local var_1_119 = var_1_116.GET_SHIP

	GetShipCommand = var_1_10005

	var_1_118(var_1_117, var_1_119, var_1_10005)

	local var_1_120 = arg_1_0.facade
	local var_1_121 = var_2.registerCommand

	GAME = var_1_119

	local var_1_122 = var_1_119.DESTROY_SHIPS

	DestroyShipsCommand = var_1_10005

	var_1_121(var_1_120, var_1_122, var_1_10005)

	local var_1_123 = arg_1_0.facade
	local var_1_124 = var_2.registerCommand

	GAME = var_1_122

	local var_1_125 = var_1_122.UPGRADE_STAR

	UpgradeStarCommand = var_1_10005

	var_1_124(var_1_123, var_1_125, var_1_10005)

	local var_1_126 = arg_1_0.facade
	local var_1_127 = var_2.registerCommand

	GAME = var_1_125

	local var_1_128 = var_1_125.EQUIP_TO_SHIP

	EquipToShipCommand = var_1_10005

	var_1_127(var_1_126, var_1_128, var_1_10005)

	local var_1_129 = arg_1_0.facade
	local var_1_130 = var_2.registerCommand

	GAME = var_1_128

	local var_1_131 = var_1_128.EQUIP_FROM_SHIP

	EquipFromShipCommand = var_1_10005

	var_1_130(var_1_129, var_1_131, var_1_10005)

	local var_1_132 = arg_1_0.facade
	local var_1_133 = var_2.registerCommand

	GAME = var_1_131

	local var_1_134 = var_1_131.UNEQUIP_FROM_SHIP

	UnequipFromShipCommand = var_1_10005

	var_1_133(var_1_132, var_1_134, var_1_10005)

	local var_1_135 = arg_1_0.facade
	local var_1_136 = var_2.registerCommand

	GAME = var_1_134

	local var_1_137 = var_1_134.UNEQUIP_FROM_SHIP_ALL

	UnEquipFromShipAllCommand = var_1_10005

	var_1_136(var_1_135, var_1_137, var_1_10005)

	local var_1_138 = arg_1_0.facade
	local var_1_139 = var_2.registerCommand

	GAME = var_1_137

	local var_1_140 = var_1_137.SHIP_EQUIP_ALL_CHANGE

	ShipEquipAllChangeCommand = var_1_10005

	var_1_139(var_1_138, var_1_140, var_1_10005)

	local var_1_141 = arg_1_0.facade
	local var_1_142 = var_2.registerCommand

	GAME = var_1_140

	local var_1_143 = var_1_140.REMOULD_SHIP

	RemouldShipCommand = var_1_10005

	var_1_142(var_1_141, var_1_143, var_1_10005)

	local var_1_144 = arg_1_0.facade
	local var_1_145 = var_2.registerCommand

	GAME = var_1_143

	local var_1_146 = var_1_143.UPDATE_LOCK

	UpdateShipLockCommand = var_1_10005

	var_1_145(var_1_144, var_1_146, var_1_10005)

	local var_1_147 = arg_1_0.facade
	local var_1_148 = var_2.registerCommand

	GAME = var_1_146

	local var_1_149 = var_1_146.UPDATE_PREFERENCE

	UpdateShipPreferenceTagCommand = var_1_10005

	var_1_148(var_1_147, var_1_149, var_1_10005)

	local var_1_150 = arg_1_0.facade
	local var_1_151 = var_2.registerCommand

	GAME = var_1_149

	local var_1_152 = var_1_149.MOD_SHIP

	ModShipCommand = var_1_10005

	var_1_151(var_1_150, var_1_152, var_1_10005)

	local var_1_153 = arg_1_0.facade
	local var_1_154 = var_2.registerCommand

	GAME = var_1_152

	local var_1_155 = var_1_152.CONFIRM_GET_SHIP

	GetShipConfirmCommand = var_1_10005

	var_1_154(var_1_153, var_1_155, var_1_10005)

	local var_1_156 = arg_1_0.facade
	local var_1_157 = var_2.registerCommand

	GAME = var_1_155

	local var_1_158 = var_1_155.SUPPORT_SHIP

	SupportShipCommand = var_1_10005

	var_1_157(var_1_156, var_1_158, var_1_10005)

	local var_1_159 = arg_1_0.facade
	local var_1_160 = var_2.registerCommand

	GAME = var_1_158

	local var_1_161 = var_1_158.LIKE_SHIP

	LikeShipCommand = var_1_10005

	var_1_160(var_1_159, var_1_161, var_1_10005)

	local var_1_162 = arg_1_0.facade
	local var_1_163 = var_2.registerCommand

	GAME = var_1_161

	local var_1_164 = var_1_161.EVALUATE_SHIP

	EvaluateShipCommand = var_1_10005

	var_1_163(var_1_162, var_1_164, var_1_10005)

	local var_1_165 = arg_1_0.facade
	local var_1_166 = var_2.registerCommand

	GAME = var_1_164

	local var_1_167 = var_1_164.ZAN_SHIP_EVALUATION

	ZanShipEvaCommand = var_1_10005

	var_1_166(var_1_165, var_1_167, var_1_10005)

	local var_1_168 = arg_1_0.facade
	local var_1_169 = var_2.registerCommand

	GAME = var_1_167

	local var_1_170 = var_1_167.IMPEACH_SHIP_EVALUATION

	ImpeachShipEvaCommand = var_1_10005

	var_1_169(var_1_168, var_1_170, var_1_10005)

	local var_1_171 = arg_1_0.facade
	local var_1_172 = var_2.registerCommand

	GAME = var_1_170

	local var_1_173 = var_1_170.FETCH_EVALUATION

	FetchEvaluationCommand = var_1_10005

	var_1_172(var_1_171, var_1_173, var_1_10005)

	local var_1_174 = arg_1_0.facade
	local var_1_175 = var_2.registerCommand

	GAME = var_1_173

	local var_1_176 = var_1_173.SET_SHIP_SKIN

	SetShipSkinCommand = var_1_10005

	var_1_175(var_1_174, var_1_176, var_1_10005)

	local var_1_177 = arg_1_0.facade
	local var_1_178 = var_2.registerCommand

	GAME = var_1_176

	local var_1_179 = var_1_176.PROPOSE_SHIP

	ProposeCommand = var_1_10005

	var_1_178(var_1_177, var_1_179, var_1_10005)

	local var_1_180 = arg_1_0.facade
	local var_1_181 = var_2.registerCommand

	GAME = var_1_179

	local var_1_182 = var_1_179.PROPOSE_REGISTER_SHIP

	ProposeRegiesterShipCommand = var_1_10005

	var_1_181(var_1_180, var_1_182, var_1_10005)

	local var_1_183 = arg_1_0.facade
	local var_1_184 = var_2.registerCommand

	GAME = var_1_182

	local var_1_185 = var_1_182.PROPOSE_EXCHANGE_RING

	ProposeExchangeRingCommand = var_1_10005

	var_1_184(var_1_183, var_1_185, var_1_10005)

	local var_1_186 = arg_1_0.facade
	local var_1_187 = var_2.registerCommand

	GAME = var_1_185

	local var_1_188 = var_1_185.RENAME_SHIP

	RenameShipCommand = var_1_10005

	var_1_187(var_1_186, var_1_188, var_1_10005)

	local var_1_189 = arg_1_0.facade
	local var_1_190 = var_2.registerCommand

	GAME = var_1_188

	local var_1_191 = var_1_188.REQ_PLAYER_ASSIST_SHIP

	ReqPlayerAssistShipCommand = var_1_10005

	var_1_190(var_1_189, var_1_191, var_1_10005)

	local var_1_192 = arg_1_0.facade
	local var_1_193 = var_2.registerCommand

	GAME = var_1_191

	local var_1_194 = var_1_191.RECORD_SHIP_EQUIPMENT

	RecordShipEquipmentCommand = var_1_10005

	var_1_193(var_1_192, var_1_194, var_1_10005)

	local var_1_195 = arg_1_0.facade
	local var_1_196 = var_2.registerCommand

	GAME = var_1_194

	local var_1_197 = var_1_194.EQUIP_EQUIPMENTSKIN_TO_SHIP

	UpdateShipEquipmentSkinCommand = var_1_10005

	var_1_196(var_1_195, var_1_197, var_1_10005)

	local var_1_198 = arg_1_0.facade
	local var_1_199 = var_2.registerCommand

	GAME = var_1_197

	local var_1_200 = var_1_197.EQUIP_EQUIPMENTSKIN_FROM_SHIP

	EquipESkinFormShipCommand = var_1_10005

	var_1_199(var_1_198, var_1_200, var_1_10005)

	local var_1_201 = arg_1_0.facade
	local var_1_202 = var_2.registerCommand

	GAME = var_1_200

	local var_1_203 = var_1_200.UPGRADE_MAX_LEVEL

	UpgradeShipMaxLevelCommand = var_1_10005

	var_1_202(var_1_201, var_1_203, var_1_10005)

	local var_1_204 = arg_1_0.facade
	local var_1_205 = var_2.registerCommand

	GAME = var_1_203

	local var_1_206 = var_1_203.EQUIP_CODE_REQUEST

	EquipCodeRequestCommand = var_1_10005

	var_1_205(var_1_204, var_1_206, var_1_10005)

	local var_1_207 = arg_1_0.facade
	local var_1_208 = var_2.registerCommand

	GAME = var_1_206

	local var_1_209 = var_1_206.EQUIP_CODE_SHARE

	EquipCodeShareCommand = var_1_10005

	var_1_208(var_1_207, var_1_209, var_1_10005)

	local var_1_210 = arg_1_0.facade
	local var_1_211 = var_2.registerCommand

	GAME = var_1_209

	local var_1_212 = var_1_209.EQUIP_CODE_LIKE

	EquipCodeLikeCommand = var_1_10005

	var_1_211(var_1_210, var_1_212, var_1_10005)

	local var_1_213 = arg_1_0.facade
	local var_1_214 = var_2.registerCommand

	GAME = var_1_212

	local var_1_215 = var_1_212.EQUIP_CODE_IMPEACH

	EquipCodeImpeachCommand = var_1_10005

	var_1_214(var_1_213, var_1_215, var_1_10005)

	local var_1_216 = arg_1_0.facade
	local var_1_217 = var_2.registerCommand

	GAME = var_1_215

	local var_1_218 = var_1_215.CHANGE_SKIN_AB

	ChangeSkinABCommand = var_1_10005

	var_1_217(var_1_216, var_1_218, var_1_10005)

	local var_1_219 = arg_1_0.facade
	local var_1_220 = var_2.registerCommand

	GAME = var_1_218

	local var_1_221 = var_1_218.UPDATE_FLEET

	UpdateFleetCommand = var_1_10005

	var_1_220(var_1_219, var_1_221, var_1_10005)

	local var_1_222 = arg_1_0.facade
	local var_1_223 = var_2.registerCommand

	GAME = var_1_221

	local var_1_224 = var_1_221.RENAME_FLEET

	RenameFleetCommand = var_1_10005

	var_1_223(var_1_222, var_1_224, var_1_10005)

	local var_1_225 = arg_1_0.facade
	local var_1_226 = var_2.registerCommand

	GAME = var_1_224

	local var_1_227 = var_1_224.QUICK_REPAIR_SHIPS

	RepairShipsCommand = var_1_10005

	var_1_226(var_1_225, var_1_227, var_1_10005)

	local var_1_228 = arg_1_0.facade
	local var_1_229 = var_2.registerCommand

	GAME = var_1_227

	local var_1_230 = var_1_227.DESTROY_EQUIPMENTS

	DestroyEquipmentsCommand = var_1_10005

	var_1_229(var_1_228, var_1_230, var_1_10005)

	local var_1_231 = arg_1_0.facade
	local var_1_232 = var_2.registerCommand

	GAME = var_1_230

	local var_1_233 = var_1_230.COMPOSITE_EQUIPMENT

	CompositeEquipmentCommand = var_1_10005

	var_1_232(var_1_231, var_1_233, var_1_10005)

	local var_1_234 = arg_1_0.facade
	local var_1_235 = var_2.registerCommand

	GAME = var_1_233

	local var_1_236 = var_1_233.UPGRADE_EQUIPMENTS

	UpGradeEquipmentCommand = var_1_10005

	var_1_235(var_1_234, var_1_236, var_1_10005)

	local var_1_237 = arg_1_0.facade
	local var_1_238 = var_2.registerCommand

	GAME = var_1_236

	local var_1_239 = var_1_236.REVERT_EQUIPMENT

	RevertEquipmentCommand = var_1_10005

	var_1_238(var_1_237, var_1_239, var_1_10005)

	local var_1_240 = arg_1_0.facade
	local var_1_241 = var_2.registerCommand

	GAME = var_1_239

	local var_1_242 = var_1_239.TRANSFORM_EQUIPMENT

	TransformEquipmentCommand = var_1_10005

	var_1_241(var_1_240, var_1_242, var_1_10005)

	local var_1_243 = arg_1_0.facade
	local var_1_244 = var_2.registerCommand

	GAME = var_1_242

	local var_1_245 = var_1_242.ATTIRE_APPLY

	AttireApplyCommand = var_1_10005

	var_1_244(var_1_243, var_1_245, var_1_10005)

	local var_1_246 = arg_1_0.facade
	local var_1_247 = var_2.registerCommand

	GAME = var_1_245

	local var_1_248 = var_1_245.HANDLE_OVERDUE_ATTIRE

	HandleOverDueAttireCommand = var_1_10005

	var_1_247(var_1_246, var_1_248, var_1_10005)

	local var_1_249 = arg_1_0.facade
	local var_1_250 = var_2.registerCommand

	GAME = var_1_248

	local var_1_251 = var_1_248.CHAPTER_OP

	ChapterOpCommand = var_1_10005

	var_1_250(var_1_249, var_1_251, var_1_10005)

	local var_1_252 = arg_1_0.facade
	local var_1_253 = var_2.registerCommand

	GAME = var_1_251

	local var_1_254 = var_1_251.CHAPTER_BATTLE_RESULT_REQUEST

	ChapterBattleResultRequestCommand = var_1_10005

	var_1_253(var_1_252, var_1_254, var_1_10005)

	local var_1_255 = arg_1_0.facade
	local var_1_256 = var_2.registerCommand

	GAME = var_1_254

	local var_1_257 = var_1_254.TRACKING

	TrackingCommand = var_1_10005

	var_1_256(var_1_255, var_1_257, var_1_10005)

	local var_1_258 = arg_1_0.facade
	local var_1_259 = var_2.registerCommand

	GAME = var_1_257

	local var_1_260 = var_1_257.BEGIN_STAGE

	BeginStageCommand = var_1_10005

	var_1_259(var_1_258, var_1_260, var_1_10005)

	local var_1_261 = arg_1_0.facade
	local var_1_262 = var_2.registerCommand

	GAME = var_1_260

	local var_1_263 = var_1_260.FINISH_STAGE

	FinishStageCommand = var_1_10005

	var_1_262(var_1_261, var_1_263, var_1_10005)

	local var_1_264 = arg_1_0.facade
	local var_1_265 = var_2.registerCommand

	GAME = var_1_263

	local var_1_266 = var_1_263.AUTO_BOT

	AutoBotCommand = var_1_10005

	var_1_265(var_1_264, var_1_266, var_1_10005)

	local var_1_267 = arg_1_0.facade
	local var_1_268 = var_2.registerCommand

	GAME = var_1_266

	local var_1_269 = var_1_266.AUTO_SUB

	AutoSubCommand = var_1_10005

	var_1_268(var_1_267, var_1_269, var_1_10005)

	local var_1_270 = arg_1_0.facade
	local var_1_271 = var_2.registerCommand

	GAME = var_1_269

	local var_1_272 = var_1_269.UPDATE_CUSTOM_FLEET

	UpdateCustomFleetCommand = var_1_10005

	var_1_271(var_1_270, var_1_272, var_1_10005)

	local var_1_273 = arg_1_0.facade
	local var_1_274 = var_2.registerCommand

	GAME = var_1_272

	local var_1_275 = var_1_272.GET_CHAPTER_DROP_SHIP_LIST

	GetChapterDropShipListCommand = var_1_10005

	var_1_274(var_1_273, var_1_275, var_1_10005)

	local var_1_276 = arg_1_0.facade
	local var_1_277 = var_2.registerCommand

	GAME = var_1_275

	local var_1_278 = var_1_275.DAILY_LEVEL_QUICK_BATTLE

	DailiyQuickBattleCommand = var_1_10005

	var_1_277(var_1_276, var_1_278, var_1_10005)

	local var_1_279 = arg_1_0.facade
	local var_1_280 = var_2.registerCommand

	GAME = var_1_278

	local var_1_281 = var_1_278.CHAPTER_REMASTER_INFO_REQUEST

	RemasterInfoRequestCommand = var_1_10005

	var_1_280(var_1_279, var_1_281, var_1_10005)

	local var_1_282 = arg_1_0.facade
	local var_1_283 = var_2.registerCommand

	GAME = var_1_281

	local var_1_284 = var_1_281.CHAPTER_REMASTER_AWARD_RECEIVE

	RemasterAwardReceiveCommand = var_1_10005

	var_1_283(var_1_282, var_1_284, var_1_10005)

	local var_1_285 = arg_1_0.facade
	local var_1_286 = var_2.registerCommand

	GAME = var_1_284

	local var_1_287 = var_1_284.CHALLENGE2_INITIAL

	Challenge2InitialRequestCommand = var_1_10005

	var_1_286(var_1_285, var_1_287, var_1_10005)

	local var_1_288 = arg_1_0.facade
	local var_1_289 = var_2.registerCommand

	GAME = var_1_287

	local var_1_290 = var_1_287.CHALLENGE2_RESET

	Challenge2ResetRequestCommand = var_1_10005

	var_1_289(var_1_288, var_1_290, var_1_10005)

	local var_1_291 = arg_1_0.facade
	local var_1_292 = var_2.registerCommand

	GAME = var_1_290

	local var_1_293 = var_1_290.CHALLENGE2_INFO

	Challenge2InfoRequestCommand = var_1_10005

	var_1_292(var_1_291, var_1_293, var_1_10005)

	local var_1_294 = arg_1_0.facade
	local var_1_295 = var_2.registerCommand

	GAME = var_1_293

	local var_1_296 = var_1_293.CHALLENGE2_SETTLE

	Challenge2SettleRequestCommand = var_1_10005

	var_1_295(var_1_294, var_1_296, var_1_10005)

	local var_1_297 = arg_1_0.facade
	local var_1_298 = var_2.registerCommand

	GAME = var_1_296

	local var_1_299 = var_1_296.FETCH_NPC_SHIP

	FetchNpcShipCommand = var_1_10005

	var_1_298(var_1_297, var_1_299, var_1_10005)

	local var_1_300 = arg_1_0.facade
	local var_1_301 = var_2.registerCommand

	GAME = var_1_299

	local var_1_302 = var_1_299.FETCH_NPC_SHIP_ACTIVITY

	FetchNpcShipActivityCommand = var_1_10005

	var_1_301(var_1_300, var_1_302, var_1_10005)

	local var_1_303 = arg_1_0.facade
	local var_1_304 = var_2.registerCommand

	GAME = var_1_302

	local var_1_305 = var_1_302.GET_SEASON_INFO

	GetSeasonInfoCommand = var_1_10005

	var_1_304(var_1_303, var_1_305, var_1_10005)

	local var_1_306 = arg_1_0.facade
	local var_1_307 = var_2.registerCommand

	GAME = var_1_305

	local var_1_308 = var_1_305.REPLACE_RIVALS

	ReplaceRivalsCommand = var_1_10005

	var_1_307(var_1_306, var_1_308, var_1_10005)

	local var_1_309 = arg_1_0.facade
	local var_1_310 = var_2.registerCommand

	GAME = var_1_308

	local var_1_311 = var_1_308.REFRESH_MILITARY_SHOP

	RefreshMilitaryShopCommand = var_1_10005

	var_1_310(var_1_309, var_1_311, var_1_10005)

	local var_1_312 = arg_1_0.facade
	local var_1_313 = var_2.registerCommand

	GAME = var_1_311

	local var_1_314 = var_1_311.UPDATE_EXERCISE_FLEET

	UpdateExerciseFleetCommand = var_1_10005

	var_1_313(var_1_312, var_1_314, var_1_10005)

	local var_1_315 = arg_1_0.facade
	local var_1_316 = var_2.registerCommand

	GAME = var_1_314

	local var_1_317 = var_1_314.EXERCISE_COUNT_RECOVER_UP

	ExerciseCountRecoverUpCommand = var_1_10005

	var_1_316(var_1_315, var_1_317, var_1_10005)

	local var_1_318 = arg_1_0.facade
	local var_1_319 = var_2.registerCommand

	GAME = var_1_317

	local var_1_320 = var_1_317.GET_MILITARY_SHOP

	GetMilitaryShopCommand = var_1_10005

	var_1_319(var_1_318, var_1_320, var_1_10005)

	local var_1_321 = arg_1_0.facade
	local var_1_322 = var_2.registerCommand

	GAME = var_1_320

	local var_1_323 = var_1_320.GET_RIVAL_INFO

	GetRivalInfoCommand = var_1_10005

	var_1_322(var_1_321, var_1_323, var_1_10005)

	local var_1_324 = arg_1_0.facade
	local var_1_325 = var_2.registerCommand

	GAME = var_1_323

	local var_1_326 = var_1_323.GET_POWERRANK

	GetPowerRankCommand = var_1_10005

	var_1_325(var_1_324, var_1_326, var_1_10005)

	local var_1_327 = arg_1_0.facade
	local var_1_328 = var_2.registerCommand

	GAME = var_1_326

	local var_1_329 = var_1_326.BACKYARD_GET_VISITOR_SHIP

	GetBackYardVisitorCommand = var_1_10005

	var_1_328(var_1_327, var_1_329, var_1_10005)

	local var_1_330 = arg_1_0.facade
	local var_1_331 = var_2.registerCommand

	GAME = var_1_329

	local var_1_332 = var_1_329.ADD_FOOD

	AddFoodCommand = var_1_10005

	var_1_331(var_1_330, var_1_332, var_1_10005)

	local var_1_333 = arg_1_0.facade
	local var_1_334 = var_2.registerCommand

	GAME = var_1_332

	local var_1_335 = var_1_332.BUY_FURNITURE

	BuyFurnitureCommand = var_1_10005

	var_1_334(var_1_333, var_1_335, var_1_10005)

	local var_1_336 = arg_1_0.facade
	local var_1_337 = var_2.registerCommand

	GAME = var_1_335

	local var_1_338 = var_1_335.ADD_SHIP

	AddShipCommand = var_1_10005

	var_1_337(var_1_336, var_1_338, var_1_10005)

	local var_1_339 = arg_1_0.facade
	local var_1_340 = var_2.registerCommand

	GAME = var_1_338

	local var_1_341 = var_1_338.EXIT_SHIP

	ShipExitCommand = var_1_10005

	var_1_340(var_1_339, var_1_341, var_1_10005)

	local var_1_342 = arg_1_0.facade
	local var_1_343 = var_2.registerCommand

	GAME = var_1_341

	local var_1_344 = var_1_341.PUT_FURNITURE

	PutFurnitureCommand = var_1_10005

	var_1_343(var_1_342, var_1_344, var_1_10005)

	local var_1_345 = arg_1_0.facade
	local var_1_346 = var_2.registerCommand

	GAME = var_1_344

	local var_1_347 = var_1_344.BACKYARD_ADD_INTIMACY

	ShipAddInimacyCommand = var_1_10005

	var_1_346(var_1_345, var_1_347, var_1_10005)

	local var_1_348 = arg_1_0.facade
	local var_1_349 = var_2.registerCommand

	GAME = var_1_347

	local var_1_350 = var_1_347.BACKYARD_ADD_MONEY

	ShipAddMoneyCommand = var_1_10005

	var_1_349(var_1_348, var_1_350, var_1_10005)

	local var_1_351 = arg_1_0.facade
	local var_1_352 = var_2.registerCommand

	GAME = var_1_350

	local var_1_353 = var_1_350.OPEN_ADD_EXP

	BackYardOpenAddExpCommand = var_1_10005

	var_1_352(var_1_351, var_1_353, var_1_10005)

	local var_1_354 = arg_1_0.facade
	local var_1_355 = var_2.registerCommand

	GAME = var_1_353

	local var_1_356 = var_1_353.EXTEND_BACKYARD_AREA

	ExtendBackYardAreaCommand = var_1_10005

	var_1_355(var_1_354, var_1_356, var_1_10005)

	local var_1_357 = arg_1_0.facade
	local var_1_358 = var_2.registerCommand

	GAME = var_1_356

	local var_1_359 = var_1_356.BACKYARD_RENAME

	BackYardRenameCommand = var_1_10005

	var_1_358(var_1_357, var_1_359, var_1_10005)

	local var_1_360 = arg_1_0.facade
	local var_1_361 = var_2.registerCommand

	GAME = var_1_359

	local var_1_362 = var_1_359.GET_DORMTHEME

	GetDormThemeListCommand = var_1_10005

	var_1_361(var_1_360, var_1_362, var_1_10005)

	local var_1_363 = arg_1_0.facade
	local var_1_364 = var_2.registerCommand

	GAME = var_1_362

	local var_1_365 = var_1_362.GET_BACKYARD_DATA

	GetBackYardDataCommand = var_1_10005

	var_1_364(var_1_363, var_1_365, var_1_10005)

	local var_1_366 = arg_1_0.facade
	local var_1_367 = var_2.registerCommand

	GAME = var_1_365

	local var_1_368 = var_1_365.GET_CANPUT_FURNITURES_FOR_THEME

	GetCanBePutFurnituresForThemeCommand = var_1_10005

	var_1_367(var_1_366, var_1_368, var_1_10005)

	local var_1_369 = arg_1_0.facade
	local var_1_370 = var_2.registerCommand

	GAME = var_1_368

	local var_1_371 = var_1_368.GET_ALL_BACKYARD_THEME_TEMPLATE

	GetAllBackYardThemeTemplateCommand = var_1_10005

	var_1_370(var_1_369, var_1_371, var_1_10005)

	local var_1_372 = arg_1_0.facade
	local var_1_373 = var_2.registerCommand

	GAME = var_1_371

	local var_1_374 = var_1_371.BACKYARD_LIKE_THEME_TEMPLATE

	BackYardLikeThemeTemplateCommand = var_1_10005

	var_1_373(var_1_372, var_1_374, var_1_10005)

	local var_1_375 = arg_1_0.facade
	local var_1_376 = var_2.registerCommand

	GAME = var_1_374

	local var_1_377 = var_1_374.BACKYARD_COLLECT_THEME_TEMPLATE

	BackYardCollectThemeTemplateCommand = var_1_10005

	var_1_376(var_1_375, var_1_377, var_1_10005)

	local var_1_378 = arg_1_0.facade
	local var_1_379 = var_2.registerCommand

	GAME = var_1_377

	local var_1_380 = var_1_377.BACKYARD_GET_THEME_TEMPLATE

	BackYardGetThemeTemplateCommand = var_1_10005

	var_1_379(var_1_378, var_1_380, var_1_10005)

	local var_1_381 = arg_1_0.facade
	local var_1_382 = var_2.registerCommand

	GAME = var_1_380

	local var_1_383 = var_1_380.BACKYARD_GET_THEME_TEMPLATE_PLAYE_INFO

	GetThemeTemplatePlayerInfoCommand = var_5

	var_1_382(var_1_381, var_1_383, var_5)

	local var_1_384 = arg_1_0.facade
	local var_1_385 = var_2.registerCommand

	GAME = var_1_383

	local var_1_386 = var_1_383.BACKYARD_UNLOAD_THEME_TEMPLATE

	BackYardUnloadThemeTemplateCommand = var_5

	var_1_385(var_1_384, var_1_386, var_5)

	local var_1_387 = arg_1_0.facade
	local var_1_388 = var_2.registerCommand

	GAME = var_1_386

	local var_1_389 = var_1_386.BACKYARD_UPLOAD_THEME_TEMPLATE

	BackYardUploadThemeTemplateCommand = var_5

	var_1_388(var_1_387, var_1_389, var_5)

	local var_1_390 = arg_1_0.facade
	local var_1_391 = var_2.registerCommand

	GAME = var_1_389

	local var_1_392 = var_1_389.BACKYARD_APPLY_THEME_TEMPLATE

	BackYardApplyThemeTemplateCommand = var_5

	var_1_391(var_1_390, var_1_392, var_5)

	local var_1_393 = arg_1_0.facade
	local var_1_394 = var_2.registerCommand

	GAME = var_1_392

	local var_1_395 = var_1_392.BACKYARD_SEARCH_THEME_TEMPLATE

	BackYardSeachThemeTemplateCommand = var_5

	var_1_394(var_1_393, var_1_395, var_5)

	local var_1_396 = arg_1_0.facade
	local var_1_397 = var_2.registerCommand

	GAME = var_1_395

	local var_1_398 = var_1_395.BACKYARD_DELETE_THEME_TEMPLATE

	BackYardDeleteThemeTemplateCommand = var_5

	var_1_397(var_1_396, var_1_398, var_5)

	local var_1_399 = arg_1_0.facade
	local var_1_400 = var_2.registerCommand

	GAME = var_1_398

	local var_1_401 = var_1_398.BACKYARD_SAVE_THEME_TEMPLATE

	AddBackYardThemeTemplateCommand = var_5

	var_1_400(var_1_399, var_1_401, var_5)

	local var_1_402 = arg_1_0.facade
	local var_1_403 = var_2.registerCommand

	GAME = var_1_401

	local var_1_404 = var_1_401.BACKYARD_GET_THEME_TEMPLATE_DATA

	BackYardGetThemeTemplateDataCommand = var_5

	var_1_403(var_1_402, var_1_404, var_5)

	local var_1_405 = arg_1_0.facade
	local var_1_406 = var_2.registerCommand

	GAME = var_1_404

	local var_1_407 = var_1_404.BACKYARD_REFRESH_SHOP_TEMPLATE

	BackYardRefreshShopTemplateCommand = var_5

	var_1_406(var_1_405, var_1_407, var_5)

	local var_1_408 = arg_1_0.facade
	local var_1_409 = var_2.registerCommand

	GAME = var_1_407

	local var_1_410 = var_1_407.INFORM_THEME_TEMPLATE

	InformBackYardThemeTemplateCommand = var_5

	var_1_409(var_1_408, var_1_410, var_5)

	local var_1_411 = arg_1_0.facade
	local var_1_412 = var_2.registerCommand

	GAME = var_1_410

	local var_1_413 = var_1_410.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE

	BackYardGetSpecifiedTypeThemplateCommand = var_5

	var_1_412(var_1_411, var_1_413, var_5)

	local var_1_414 = arg_1_0.facade
	local var_1_415 = var_2.registerCommand

	GAME = var_1_413

	local var_1_416 = var_1_413.BACKYARD_GET_IMG_MD5

	BackYardGetPreviewImageMd5Command = var_5

	var_1_415(var_1_414, var_1_416, var_5)

	local var_1_417 = arg_1_0.facade
	local var_1_418 = var_2.registerCommand

	GAME = var_1_416

	local var_1_419 = var_1_416.BACKYARD_ONE_KEY

	ShipAddIntimacyAndMoneyCommand = var_5

	var_1_418(var_1_417, var_1_419, var_5)

	local var_1_420 = arg_1_0.facade
	local var_1_421 = var_2.registerCommand

	GAME = var_1_419

	local var_1_422 = var_1_419.BACKYARD_REQUEST_POP_EVENT

	BackYardRequestPopEventCommand = var_5

	var_1_421(var_1_420, var_1_422, var_5)

	local var_1_423 = arg_1_0.facade
	local var_1_424 = var_2.registerCommand

	GAME = var_1_422

	local var_1_425 = var_1_422.BACKYARD_REQUEST_SHIP_EXP

	BackYardRequestShipExpCommand = var_5

	var_1_424(var_1_423, var_1_425, var_5)

	local var_1_426 = arg_1_0.facade
	local var_1_427 = var_2.registerCommand

	GAME = var_1_425

	local var_1_428 = var_1_425.SHOPPING

	ShoppingCommand = var_5

	var_1_427(var_1_426, var_1_428, var_5)

	local var_1_429 = arg_1_0.facade
	local var_1_430 = var_2.registerCommand

	GAME = var_1_428

	local var_1_431 = var_1_428.EXTEND

	ExtendCommand = var_5

	var_1_430(var_1_429, var_1_431, var_5)

	local var_1_432 = arg_1_0.facade
	local var_1_433 = var_2.registerCommand

	GAME = var_1_431

	local var_1_434 = var_1_431.FRAG_SHOPPING

	FragmentShoppingCommand = var_5

	var_1_433(var_1_432, var_1_434, var_5)

	local var_1_435 = arg_1_0.facade
	local var_1_436 = var_2.registerCommand

	GAME = var_1_434

	local var_1_437 = var_1_434.FRAG_SELL

	FragmentSellCommand = var_5

	var_1_436(var_1_435, var_1_437, var_5)

	local var_1_438 = arg_1_0.facade
	local var_1_439 = var_2.registerCommand

	GAME = var_1_437

	local var_1_440 = var_1_437.GET_OPEN_SHOPS

	GetOpeningUpShopCommand = var_5

	var_1_439(var_1_438, var_1_440, var_5)

	local var_1_441 = arg_1_0.facade
	local var_1_442 = var_2.registerCommand

	GAME = var_1_440

	local var_1_443 = var_1_440.SKIN_SHOPPIGN

	SkinShoppingCommand = var_5

	var_1_442(var_1_441, var_1_443, var_5)

	local var_1_444 = arg_1_0.facade
	local var_1_445 = var_2.registerCommand

	GAME = var_1_443

	local var_1_446 = var_1_443.SKIN_COUPON_SHOPPING

	SkinCoupunShoppingCommand = var_5

	var_1_445(var_1_444, var_1_446, var_5)

	local var_1_447 = arg_1_0.facade
	local var_1_448 = var_2.registerCommand

	GAME = var_1_446

	local var_1_449 = var_1_446.RECORD_SKIN_ANIM_PREVIEW

	RecordSkinAnimPreviwBtnUsageCommand = var_5

	var_1_448(var_1_447, var_1_449, var_5)

	local var_1_450 = arg_1_0.facade
	local var_1_451 = var_2.registerCommand

	GAME = var_1_449

	local var_1_452 = var_1_449.USE_ITEM

	UseItemCommand = var_5

	var_1_451(var_1_450, var_1_452, var_5)

	local var_1_453 = arg_1_0.facade
	local var_1_454 = var_2.registerCommand

	GAME = var_1_452

	local var_1_455 = var_1_452.USE_ADD_SHIPEXP_ITEM

	UseAddShipExpCommand = var_5

	var_1_454(var_1_453, var_1_455, var_5)

	local var_1_456 = arg_1_0.facade
	local var_1_457 = var_2.registerCommand

	GAME = var_1_455

	local var_1_458 = var_1_455.USE_FUDAI_ITEM

	UseFudaiItemCommand = var_5

	var_1_457(var_1_456, var_1_458, var_5)

	local var_1_459 = arg_1_0.facade
	local var_1_460 = var_2.registerCommand

	GAME = var_1_458

	local var_1_461 = var_1_458.COMPOSE_ITEM

	ComposeItemCommand = var_5

	var_1_460(var_1_459, var_1_461, var_5)

	local var_1_462 = arg_1_0.facade
	local var_1_463 = var_2.registerCommand

	GAME = var_1_461

	local var_1_464 = var_1_461.LOVE_ITEM_MAIL_CHECK

	CheckLoveLetterItemMailCommand = var_5

	var_1_463(var_1_462, var_1_464, var_5)

	local var_1_465 = arg_1_0.facade
	local var_1_466 = var_2.registerCommand

	GAME = var_1_464

	local var_1_467 = var_1_464.LOVE_ITEM_MAIL_REPAIR

	RepairLoveLetterItemMailCommand = var_5

	var_1_466(var_1_465, var_1_467, var_5)

	local var_1_468 = arg_1_0.facade
	local var_1_469 = var_2.registerCommand

	GAME = var_1_467

	local var_1_470 = var_1_467.SELL_ITEM

	SellItemCommand = var_5

	var_1_469(var_1_468, var_1_470, var_5)

	local var_1_471 = arg_1_0.facade
	local var_1_472 = var_2.registerCommand

	GAME = var_1_470

	local var_1_473 = var_1_470.GET_FEAST_DATA

	GetFeastDataCommand = var_5

	var_1_472(var_1_471, var_1_473, var_5)

	local var_1_474 = arg_1_0.facade
	local var_1_475 = var_2.registerCommand

	GAME = var_1_473

	local var_1_476 = var_1_473.FEAST_OP

	FeastOpCommand = var_5

	var_1_475(var_1_474, var_1_476, var_5)

	local var_1_477 = arg_1_0.facade
	local var_1_478 = var_2.registerCommand

	GAME = var_1_476

	local var_1_479 = var_1_476.GET_MAIL_LIST

	GetMailListCommand = var_5

	var_1_478(var_1_477, var_1_479, var_5)

	local var_1_480 = arg_1_0.facade
	local var_1_481 = var_2.registerCommand

	GAME = var_1_479

	local var_1_482 = var_1_479.GET_MAIL_LIST_TO_INDEX

	GetMailListToIndexCommand = var_5

	var_1_481(var_1_480, var_1_482, var_5)

	local var_1_483 = arg_1_0.facade
	local var_1_484 = var_2.registerCommand

	GAME = var_1_482

	local var_1_485 = var_1_482.GET_COLLECTION_MAIL_LIST

	GetCollectionMailListCommand = var_5

	var_1_484(var_1_483, var_1_485, var_5)

	local var_1_486 = arg_1_0.facade
	local var_1_487 = var_2.registerCommand

	GAME = var_1_485

	local var_1_488 = var_1_485.DEAL_MAIL_OPERATION

	DealMailOperationCommand = var_5

	var_1_487(var_1_486, var_1_488, var_5)

	local var_1_489 = arg_1_0.facade
	local var_1_490 = var_2.registerCommand

	GAME = var_1_488

	local var_1_491 = var_1_488.DELETE_COLLECTION_MAIL

	DeleteCollectionMailCommand = var_5

	var_1_490(var_1_489, var_1_491, var_5)

	local var_1_492 = arg_1_0.facade
	local var_1_493 = var_2.registerCommand

	GAME = var_1_491

	local var_1_494 = var_1_491.GET_STORE_RES

	GetStoreResCommand = var_5

	var_1_493(var_1_492, var_1_494, var_5)

	local var_1_495 = arg_1_0.facade
	local var_1_496 = var_2.registerCommand

	GAME = var_1_494

	local var_1_497 = var_1_494.EXTEND_STORE_CAPACITY

	ExtendStoreCapacityCommand = var_5

	var_1_496(var_1_495, var_1_497, var_5)

	local var_1_498 = arg_1_0.facade
	local var_1_499 = var_2.registerCommand

	GAME = var_1_497

	local var_1_500 = var_1_497.GET_MAIL_TITLE_LIST

	GetMailTitleCommand = var_5

	var_1_499(var_1_498, var_1_500, var_5)

	local var_1_501 = arg_1_0.facade
	local var_1_502 = var_2.registerCommand

	GAME = var_1_500

	local var_1_503 = var_1_500.GET_COMPENSATE_LIST

	GetCompensateCommand = var_5

	var_1_502(var_1_501, var_1_503, var_5)

	local var_1_504 = arg_1_0.facade
	local var_1_505 = var_2.registerCommand

	GAME = var_1_503

	local var_1_506 = var_1_503.GET_COMPENSATE_REWARD

	GetCompensateRewardCommand = var_5

	var_1_505(var_1_504, var_1_506, var_5)

	local var_1_507 = arg_1_0.facade
	local var_1_508 = var_2.registerCommand

	GAME = var_1_506

	local var_1_509 = var_1_506.SEND_MSG

	SendMsgCommand = var_5

	var_1_508(var_1_507, var_1_509, var_5)

	local var_1_510 = arg_1_0.facade
	local var_1_511 = var_2.registerCommand

	GAME = var_1_509

	local var_1_512 = var_1_509.SEND_CMD

	SendCmdCommand = var_5

	var_1_511(var_1_510, var_1_512, var_5)

	local var_1_513 = arg_1_0.facade
	local var_1_514 = var_2.registerCommand

	GAME = var_1_512

	local var_1_515 = var_1_512.CHANGE_CHAT_ROOM

	ChangeChatRoomCommand = var_5

	var_1_514(var_1_513, var_1_515, var_5)

	local var_1_516 = arg_1_0.facade
	local var_1_517 = var_2.registerCommand

	GAME = var_1_515

	local var_1_518 = var_1_515.SUBMIT_TASK

	SubmitTaskCommand = var_5

	var_1_517(var_1_516, var_1_518, var_5)

	local var_1_519 = arg_1_0.facade
	local var_1_520 = var_2.registerCommand

	GAME = var_1_518

	local var_1_521 = var_1_518.SUBMIT_TASK_V2

	SubmitTaskV2Command = var_5

	var_1_520(var_1_519, var_1_521, var_5)

	local var_1_522 = arg_1_0.facade
	local var_1_523 = var_2.registerCommand

	GAME = var_1_521

	local var_1_524 = var_1_521.TRIGGER_TASK

	TriggerTaskCommand = var_5

	var_1_523(var_1_522, var_1_524, var_5)

	local var_1_525 = arg_1_0.facade
	local var_1_526 = var_2.registerCommand

	GAME = var_1_524

	local var_1_527 = var_1_524.QUICK_TASK

	QuickTaskCommand = var_5

	var_1_526(var_1_525, var_1_527, var_5)

	local var_1_528 = arg_1_0.facade
	local var_1_529 = var_2.registerCommand

	GAME = var_1_527

	local var_1_530 = var_1_527.TASK_GO

	TaskGoCommand = var_5

	var_1_529(var_1_528, var_1_530, var_5)

	local var_1_531 = arg_1_0.facade
	local var_1_532 = var_2.registerCommand

	GAME = var_1_530

	local var_1_533 = var_1_530.ACCEPT_ACTIVITY_TASK

	AcceptActivityTaskCommand = var_5

	var_1_532(var_1_531, var_1_533, var_5)

	local var_1_534 = arg_1_0.facade
	local var_1_535 = var_2.registerCommand

	GAME = var_1_533

	local var_1_536 = var_1_533.UPDATE_TASK_PROGRESS

	UpdateTaskProgressCommand = var_5

	var_1_535(var_1_534, var_1_536, var_5)

	local var_1_537 = arg_1_0.facade
	local var_1_538 = var_2.registerCommand

	GAME = var_1_536

	local var_1_539 = var_1_536.SUBMIT_TASK_ONESTEP

	SubmitTaskOneStepCommand = var_5

	var_1_538(var_1_537, var_1_539, var_5)

	local var_1_540 = arg_1_0.facade
	local var_1_541 = var_2.registerCommand

	GAME = var_1_539

	local var_1_542 = var_1_539.SUBMIT_WEEK_TASK

	SubmitWeekTaskCommand = var_5

	var_1_541(var_1_540, var_1_542, var_5)

	local var_1_543 = arg_1_0.facade
	local var_1_544 = var_2.registerCommand

	GAME = var_1_542

	local var_1_545 = var_1_542.BATCH_SUBMIT_WEEK_TASK

	BatchSubmitWeekTaskCommand = var_5

	var_1_544(var_1_543, var_1_545, var_5)

	local var_1_546 = arg_1_0.facade
	local var_1_547 = var_2.registerCommand

	GAME = var_1_545

	local var_1_548 = var_1_545.SUBMIT_WEEK_TASK_PROGRESS

	SubmitWeekTaskProgressCommand = var_5

	var_1_547(var_1_546, var_1_548, var_5)

	local var_1_549 = arg_1_0.facade
	local var_1_550 = var_2.registerCommand

	GAME = var_1_548

	local var_1_551 = var_1_548.MERGE_TASK_ONE_STEP_AWARD

	MergeTaskOneStepAwardCommand = var_5

	var_1_550(var_1_549, var_1_551, var_5)

	local var_1_552 = arg_1_0.facade
	local var_1_553 = var_2.registerCommand

	GAME = var_1_551

	local var_1_554 = var_1_551.TASK_PROGRESS_UPDATE

	TaskProgressUpdateCommand = var_5

	var_1_553(var_1_552, var_1_554, var_5)

	local var_1_555 = arg_1_0.facade
	local var_1_556 = var_2.registerCommand

	GAME = var_1_554

	local var_1_557 = var_1_554.MINI_GAME_TASK_PROGRESS_UPDATE

	MiniGameTaskProgressUpdateCommand = var_5

	var_1_556(var_1_555, var_1_557, var_5)

	local var_1_558 = arg_1_0.facade
	local var_1_559 = var_2.registerCommand

	GAME = var_1_557

	local var_1_560 = var_1_557.UPDATE_LOW_PRIORITY_TASK_PROGRESS

	UpdateLowPriorityTaskProgressCommand = var_5

	var_1_559(var_1_558, var_1_560, var_5)

	local var_1_561 = arg_1_0.facade
	local var_1_562 = var_2.registerCommand

	GAME = var_1_560

	local var_1_563 = var_1_560.ADD_ITEM

	AddItemCommand = var_5

	var_1_562(var_1_561, var_1_563, var_5)

	local var_1_564 = arg_1_0.facade
	local var_1_565 = var_2.registerCommand

	GAME = var_1_563

	local var_1_566 = var_1_563.CONSUME_ITEM

	ConsumeItemCommand = var_5

	var_1_565(var_1_564, var_1_566, var_5)

	local var_1_567 = arg_1_0.facade
	local var_1_568 = var_2.registerCommand

	GAME = var_1_566

	local var_1_569 = var_1_566.START_TO_LEARN_TACTICS

	StartLearnTacticsCommand = var_5

	var_1_568(var_1_567, var_1_569, var_5)

	local var_1_570 = arg_1_0.facade
	local var_1_571 = var_2.registerCommand

	GAME = var_1_569

	local var_1_572 = var_1_569.CANCEL_LEARN_TACTICS

	CancelLearnTacticsCommand = var_5

	var_1_571(var_1_570, var_1_572, var_5)

	local var_1_573 = arg_1_0.facade
	local var_1_574 = var_2.registerCommand

	GAME = var_1_572

	local var_1_575 = var_1_572.QUICK_FINISH_LEARN_TACTICS

	QuickFinsihLearnTacticsCommand = var_5

	var_1_574(var_1_573, var_1_575, var_5)

	local var_1_576 = arg_1_0.facade
	local var_1_577 = var_2.registerCommand

	GAME = var_1_575

	local var_1_578 = var_1_575.GET_SHOPSTREET

	GetShopStreetCommand = var_5

	var_1_577(var_1_576, var_1_578, var_5)

	local var_1_579 = arg_1_0.facade
	local var_1_580 = var_2.registerCommand

	GAME = var_1_578

	local var_1_581 = var_1_578.GET_MEDALSHOP

	GetMedalShopCommand = var_5

	var_1_580(var_1_579, var_1_581, var_5)

	local var_1_582 = arg_1_0.facade
	local var_1_583 = var_2.registerCommand

	GAME = var_1_581

	local var_1_584 = var_1_581.ON_MEDAL_SHOP_PURCHASE

	MedalShopCommand = var_5

	var_1_583(var_1_582, var_1_584, var_5)

	local var_1_585 = arg_1_0.facade
	local var_1_586 = var_2.registerCommand

	GAME = var_1_584

	local var_1_587 = var_1_584.FRIEND_SEARCH

	SearchFriendCommand = var_5

	var_1_586(var_1_585, var_1_587, var_5)

	local var_1_588 = arg_1_0.facade
	local var_1_589 = var_2.registerCommand

	GAME = var_1_587

	local var_1_590 = var_1_587.FRIEND_DELETE

	DeleteFriendCommand = var_5

	var_1_589(var_1_588, var_1_590, var_5)

	local var_1_591 = arg_1_0.facade
	local var_1_592 = var_2.registerCommand

	GAME = var_1_590

	local var_1_593 = var_1_590.FRIEND_SEND_REQUEST

	SendFriendRequestCommand = var_5

	var_1_592(var_1_591, var_1_593, var_5)

	local var_1_594 = arg_1_0.facade
	local var_1_595 = var_2.registerCommand

	GAME = var_1_593

	local var_1_596 = var_1_593.FRIEND_SEND_MSG

	SendFriendMsgCommand = var_5

	var_1_595(var_1_594, var_1_596, var_5)

	local var_1_597 = arg_1_0.facade
	local var_1_598 = var_2.registerCommand

	GAME = var_1_596

	local var_1_599 = var_1_596.FRIEND_FETCH_MSG

	FetchFriendMsgCommand = var_5

	var_1_598(var_1_597, var_1_599, var_5)

	local var_1_600 = arg_1_0.facade
	local var_1_601 = var_2.registerCommand

	GAME = var_1_599

	local var_1_602 = var_1_599.FRIEND_ACCEPT_REQUEST

	AcceptFriendRequestCommand = var_5

	var_1_601(var_1_600, var_1_602, var_5)

	local var_1_603 = arg_1_0.facade
	local var_1_604 = var_2.registerCommand

	GAME = var_1_602

	local var_1_605 = var_1_602.FRIEND_REJECT_REQUEST

	RejectFriendRequestCommand = var_5

	var_1_604(var_1_603, var_1_605, var_5)

	local var_1_606 = arg_1_0.facade
	local var_1_607 = var_2.registerCommand

	GAME = var_1_605

	local var_1_608 = var_1_605.VISIT_BACKYARD

	VisitBackYardCommand = var_5

	var_1_607(var_1_606, var_1_608, var_5)

	local var_1_609 = arg_1_0.facade
	local var_1_610 = var_2.registerCommand

	GAME = var_1_608

	local var_1_611 = var_1_608.FRIEND_RELIEVE_BLACKLIST

	RelieveBlackListCommand = var_5

	var_1_610(var_1_609, var_1_611, var_5)

	local var_1_612 = arg_1_0.facade
	local var_1_613 = var_2.registerCommand

	GAME = var_1_611

	local var_1_614 = var_1_611.FRIEND_ADD_BLACKLIST

	AddBlackListCommand = var_5

	var_1_613(var_1_612, var_1_614, var_5)

	local var_1_615 = arg_1_0.facade
	local var_1_616 = var_2.registerCommand

	GAME = var_1_614

	local var_1_617 = var_1_614.GET_BLACK_LIST

	GetBlackListCommand = var_5

	var_1_616(var_1_615, var_1_617, var_5)

	local var_1_618 = arg_1_0.facade
	local var_1_619 = var_2.registerCommand

	GAME = var_1_617

	local var_1_620 = var_1_617.INFORM

	InformCommand = var_5

	var_1_619(var_1_618, var_1_620, var_5)

	local var_1_621 = arg_1_0.facade
	local var_1_622 = var_2.registerCommand

	GAME = var_1_620

	local var_1_623 = var_1_620.BATCH_GET_FRIEND

	BatchGetFriendsCommand = var_5

	var_1_622(var_1_621, var_1_623, var_5)

	local var_1_624 = arg_1_0.facade
	local var_1_625 = var_2.registerCommand

	GAME = var_1_623

	local var_1_626 = var_1_623.CHARGE_OPERATION

	ChargeCommand = var_5

	var_1_625(var_1_624, var_1_626, var_5)

	local var_1_627 = arg_1_0.facade
	local var_1_628 = var_2.registerCommand

	GAME = var_1_626

	local var_1_629 = var_1_626.GET_CHARGE_LIST

	GetChargeListCommand = var_5

	var_1_628(var_1_627, var_1_629, var_5)

	local var_1_630 = arg_1_0.facade
	local var_1_631 = var_2.registerCommand

	GAME = var_1_629

	local var_1_632 = var_1_629.CHARGE_SUCCESS

	ChargeSuccessCommand = var_5

	var_1_631(var_1_630, var_1_632, var_5)

	local var_1_633 = arg_1_0.facade
	local var_1_634 = var_2.registerCommand

	GAME = var_1_632

	local var_1_635 = var_1_632.CHARGE_CONFIRM

	ChargeConfirmCommand = var_5

	var_1_634(var_1_633, var_1_635, var_5)

	local var_1_636 = arg_1_0.facade
	local var_1_637 = var_2.registerCommand

	GAME = var_1_635

	local var_1_638 = var_1_635.CLICK_MING_SHI

	ClickMingShiCommand = var_5

	var_1_637(var_1_636, var_1_638, var_5)

	local var_1_639 = arg_1_0.facade
	local var_1_640 = var_2.registerCommand

	GAME = var_1_638

	local var_1_641 = var_1_638.CHARGE_FAILED

	ChargeFailedCommand = var_5

	var_1_640(var_1_639, var_1_641, var_5)

	local var_1_642 = arg_1_0.facade
	local var_1_643 = var_2.registerCommand

	GAME = var_1_641

	local var_1_644 = var_1_641.REFUND_CHHARGE

	RefundChargeCommand = var_5

	var_1_643(var_1_642, var_1_644, var_5)

	local var_1_645 = arg_1_0.facade
	local var_1_646 = var_2.registerCommand

	GAME = var_1_644

	local var_1_647 = var_1_644.CREATE_GUILD

	CreateGuildCommand = var_5

	var_1_646(var_1_645, var_1_647, var_5)

	local var_1_648 = arg_1_0.facade
	local var_1_649 = var_2.registerCommand

	GAME = var_1_647

	local var_1_650 = var_1_647.MODIFY_GUILD_INFO

	ModifyGuildInfoCommand = var_5

	var_1_649(var_1_648, var_1_650, var_5)

	local var_1_651 = arg_1_0.facade
	local var_1_652 = var_2.registerCommand

	GAME = var_1_650

	local var_1_653 = var_1_650.SET_GUILD_DUTY

	SetGuildDutyCommand = var_5

	var_1_652(var_1_651, var_1_653, var_5)

	local var_1_654 = arg_1_0.facade
	local var_1_655 = var_2.registerCommand

	GAME = var_1_653

	local var_1_656 = var_1_653.GUILD_FIRE

	GuildFireCommand = var_5

	var_1_655(var_1_654, var_1_656, var_5)

	local var_1_657 = arg_1_0.facade
	local var_1_658 = var_2.registerCommand

	GAME = var_1_656

	local var_1_659 = var_1_656.GUILD_QUIT

	GuildQuitCommand = var_5

	var_1_658(var_1_657, var_1_659, var_5)

	local var_1_660 = arg_1_0.facade
	local var_1_661 = var_2.registerCommand

	GAME = var_1_659

	local var_1_662 = var_1_659.GUILD_DISSOLVE

	GuildDissolveCommand = var_5

	var_1_661(var_1_660, var_1_662, var_5)

	local var_1_663 = arg_1_0.facade
	local var_1_664 = var_2.registerCommand

	GAME = var_1_662

	local var_1_665 = var_1_662.GUIDL_REQUEST_ACCEPT

	GuildRequestAcceptCommand = var_5

	var_1_664(var_1_663, var_1_665, var_5)

	local var_1_666 = arg_1_0.facade
	local var_1_667 = var_2.registerCommand

	GAME = var_1_665

	local var_1_668 = var_1_665.GUIDL_REQUEST_REJECT

	GuildRequestRejectCommand = var_5

	var_1_667(var_1_666, var_1_668, var_5)

	local var_1_669 = arg_1_0.facade
	local var_1_670 = var_2.registerCommand

	GAME = var_1_668

	local var_1_671 = var_1_668.GUILD_LIST_REFRESH

	GuildsRefreshCommand = var_5

	var_1_670(var_1_669, var_1_671, var_5)

	local var_1_672 = arg_1_0.facade
	local var_1_673 = var_2.registerCommand

	GAME = var_1_671

	local var_1_674 = var_1_671.GUILD_SEARCH

	GuildSearchCommand = var_5

	var_1_673(var_1_672, var_1_674, var_5)

	local var_1_675 = arg_1_0.facade
	local var_1_676 = var_2.registerCommand

	GAME = var_1_674

	local var_1_677 = var_1_674.GUILD_APPLY

	GuildApplyCommand = var_5

	var_1_676(var_1_675, var_1_677, var_5)

	local var_1_678 = arg_1_0.facade
	local var_1_679 = var_2.registerCommand

	GAME = var_1_677

	local var_1_680 = var_1_677.GUILD_IMPEACH

	GuildImpeachCommand = var_5

	var_1_679(var_1_678, var_1_680, var_5)

	local var_1_681 = arg_1_0.facade
	local var_1_682 = var_2.registerCommand

	GAME = var_1_680

	local var_1_683 = var_1_680.GUILD_GET_REQUEST_LIST

	GetGuildRequestsCommand = var_5

	var_1_682(var_1_681, var_1_683, var_5)

	local var_1_684 = arg_1_0.facade
	local var_1_685 = var_2.registerCommand

	GAME = var_1_683

	local var_1_686 = var_1_683.GUILD_SEND_MSG

	GuildSendMsgCommand = var_5

	var_1_685(var_1_684, var_1_686, var_5)

	local var_1_687 = arg_1_0.facade
	local var_1_688 = var_2.registerCommand

	GAME = var_1_686

	local var_1_689 = var_1_686.GET_GUILD_SHOP

	GetGuildShopCommand = var_5

	var_1_688(var_1_687, var_1_689, var_5)

	local var_1_690 = arg_1_0.facade
	local var_1_691 = var_2.registerCommand

	GAME = var_1_689

	local var_1_692 = var_1_689.GET_GUILD_RANK

	GetGuildRankCommand = var_5

	var_1_691(var_1_690, var_1_692, var_5)

	local var_1_693 = arg_1_0.facade
	local var_1_694 = var_2.registerCommand

	GAME = var_1_692

	local var_1_695 = var_1_692.GET_GUILD_CHAT_LIST

	GetGuildChatListCommand = var_5

	var_1_694(var_1_693, var_1_695, var_5)

	local var_1_696 = arg_1_0.facade
	local var_1_697 = var_2.registerCommand

	GAME = var_1_695

	local var_1_698 = var_1_695.GUILD_FETCH_CAPITAL_LOG

	GuildFetchCapitalLogCommand = var_5

	var_1_697(var_1_696, var_1_698, var_5)

	local var_1_699 = arg_1_0.facade
	local var_1_700 = var_2.registerCommand

	GAME = var_1_698

	local var_1_701 = var_1_698.GUILD_COMMIT_DONATE

	GuildCommitDonateCommand = var_5

	var_1_700(var_1_699, var_1_701, var_5)

	local var_1_702 = arg_1_0.facade
	local var_1_703 = var_2.registerCommand

	GAME = var_1_701

	local var_1_704 = var_1_701.GUILD_SELECT_TASK

	GuildSelectWeeklyTaskCommand = var_5

	var_1_703(var_1_702, var_1_704, var_5)

	local var_1_705 = arg_1_0.facade
	local var_1_706 = var_2.registerCommand

	GAME = var_1_704

	local var_1_707 = var_1_704.GUILD_GET_SUPPLY_AWARD

	GuildGetSupplyAwardCommand = var_5

	var_1_706(var_1_705, var_1_707, var_5)

	local var_1_708 = arg_1_0.facade
	local var_1_709 = var_2.registerCommand

	GAME = var_1_707

	local var_1_710 = var_1_707.GUILD_BUY_SUPPLY

	GuildBuySupplyCommand = var_5

	var_1_709(var_1_708, var_1_710, var_5)

	local var_1_711 = arg_1_0.facade
	local var_1_712 = var_2.registerCommand

	GAME = var_1_710

	local var_1_713 = var_1_710.GUILD_START_TECH

	GuildStartTechCommand = var_5

	var_1_712(var_1_711, var_1_713, var_5)

	local var_1_714 = arg_1_0.facade
	local var_1_715 = var_2.registerCommand

	GAME = var_1_713

	local var_1_716 = var_1_713.GUILD_START_TECH_TASK

	GuildStartTechGroupCommand = var_5

	var_1_715(var_1_714, var_1_716, var_5)

	local var_1_717 = arg_1_0.facade
	local var_1_718 = var_2.registerCommand

	GAME = var_1_716

	local var_1_719 = var_1_716.GUILD_GET_USER_INFO

	GuildGetUserInfoCommand = var_5

	var_1_718(var_1_717, var_1_719, var_5)

	local var_1_720 = arg_1_0.facade
	local var_1_721 = var_2.registerCommand

	GAME = var_1_719

	local var_1_722 = var_1_719.GUILD_WEEKLY_TASK_PROGREE_UPDATE

	GuildFetchWeeklyTaskProgreeCommand = var_5

	var_1_721(var_1_720, var_1_722, var_5)

	local var_1_723 = arg_1_0.facade
	local var_1_724 = var_2.registerCommand

	GAME = var_1_722

	local var_1_725 = var_1_722.GUILD_REFRESH_CAPITAL

	GuildFetchCapitalCommand = var_5

	var_1_724(var_1_723, var_1_725, var_5)

	local var_1_726 = arg_1_0.facade
	local var_1_727 = var_2.registerCommand

	GAME = var_1_725

	local var_1_728 = var_1_725.ON_GUILD_SHOP_PURCHASE

	GuildShopCommand = var_5

	var_1_727(var_1_726, var_1_728, var_5)

	local var_1_729 = arg_1_0.facade
	local var_1_730 = var_2.registerCommand

	GAME = var_1_728

	local var_1_731 = var_1_728.GUILD_CANCEL_TECH

	GuildCancelTechCommand = var_5

	var_1_730(var_1_729, var_1_731, var_5)

	local var_1_732 = arg_1_0.facade
	local var_1_733 = var_2.registerCommand

	GAME = var_1_731

	local var_1_734 = var_1_731.GET_GUILD_INFO

	GetGuildInfoCommand = var_5

	var_1_733(var_1_732, var_1_734, var_5)

	local var_1_735 = arg_1_0.facade
	local var_1_736 = var_2.registerCommand

	GAME = var_1_734

	local var_1_737 = var_1_734.GUILD_GET_RANK

	GetGuildRankCommand = var_5

	var_1_736(var_1_735, var_1_737, var_5)

	local var_1_738 = arg_1_0.facade
	local var_1_739 = var_2.registerCommand

	GAME = var_1_737

	local var_1_740 = var_1_737.GUILD_ACTIVE_EVENT

	GuildActiveEventCommand = var_5

	var_1_739(var_1_738, var_1_740, var_5)

	local var_1_741 = arg_1_0.facade
	local var_1_742 = var_2.registerCommand

	GAME = var_1_740

	local var_1_743 = var_1_740.GUILD_GET_ACTIVATION_EVENT

	GuildGetActivationEventCommand = var_5

	var_1_742(var_1_741, var_1_743, var_5)

	local var_1_744 = arg_1_0.facade
	local var_1_745 = var_2.registerCommand

	GAME = var_1_743

	local var_1_746 = var_1_743.GET_GUILD_REPORT

	GuildGetReportsCommand = var_5

	var_1_745(var_1_744, var_1_746, var_5)

	local var_1_747 = arg_1_0.facade
	local var_1_748 = var_2.registerCommand

	GAME = var_1_746

	local var_1_749 = var_1_746.GET_GUILD_REPORT_RANK

	GuildGetReportRankCommand = var_5

	var_1_748(var_1_747, var_1_749, var_5)

	local var_1_750 = arg_1_0.facade
	local var_1_751 = var_2.registerCommand

	GAME = var_1_749

	local var_1_752 = var_1_749.SUBMIT_GUILD_REPORT

	SubmitGuildReportCommand = var_5

	var_1_751(var_1_750, var_1_752, var_5)

	local var_1_753 = arg_1_0.facade
	local var_1_754 = var_2.registerCommand

	GAME = var_1_752

	local var_1_755 = var_1_752.GUILD_GET_ASSAULT_FLEET

	GuildGetAssaultFleetCommand = var_5

	var_1_754(var_1_753, var_1_755, var_5)

	local var_1_756 = arg_1_0.facade
	local var_1_757 = var_2.registerCommand

	GAME = var_1_755

	local var_1_758 = var_1_755.GUILD_GET_MY_ASSAULT_FLEET

	GetMyAssaultFleetCommand = var_5

	var_1_757(var_1_756, var_1_758, var_5)

	local var_1_759 = arg_1_0.facade
	local var_1_760 = var_2.registerCommand

	GAME = var_1_758

	local var_1_761 = var_1_758.GUILD_UPDATE_MY_ASSAULT_FLEET

	GuildUpdateAssaultFleetCommand = var_5

	var_1_760(var_1_759, var_1_761, var_5)

	local var_1_762 = arg_1_0.facade
	local var_1_763 = var_2.registerCommand

	GAME = var_1_761

	local var_1_764 = var_1_761.GUILD_JOIN_MISSION

	GuildJoinMissionCommand = var_5

	var_1_763(var_1_762, var_1_764, var_5)

	local var_1_765 = arg_1_0.facade
	local var_1_766 = var_2.registerCommand

	GAME = var_1_764

	local var_1_767 = var_1_764.GUILD_REFRESH_MISSION

	GuildRefreshMissionCommand = var_5

	var_1_766(var_1_765, var_1_767, var_5)

	local var_1_768 = arg_1_0.facade
	local var_1_769 = var_2.registerCommand

	GAME = var_1_767

	local var_1_770 = var_1_767.GUILD_UPDATE_NODE_ANIM_FLAG

	GuildUpdateNodeAnimFlagCommand = var_5

	var_1_769(var_1_768, var_1_770, var_5)

	local var_1_771 = arg_1_0.facade
	local var_1_772 = var_2.registerCommand

	GAME = var_1_770

	local var_1_773 = var_1_770.GUILD_GET_BOSS_INFO

	GetGuildBossInfoCommand = var_5

	var_1_772(var_1_771, var_1_773, var_5)

	local var_1_774 = arg_1_0.facade
	local var_1_775 = var_2.registerCommand

	GAME = var_1_773

	local var_1_776 = var_1_773.GET_GUILD_BOSS_RANK

	GetGuildBossRankCommand = var_5

	var_1_775(var_1_774, var_1_776, var_5)

	local var_1_777 = arg_1_0.facade
	local var_1_778 = var_2.registerCommand

	GAME = var_1_776

	local var_1_779 = var_1_776.GUILD_UPDATE_BOSS_FORMATION

	GuildUpdateBossMissionFleetCommand = var_5

	var_1_778(var_1_777, var_1_779, var_5)

	local var_1_780 = arg_1_0.facade
	local var_1_781 = var_2.registerCommand

	GAME = var_1_779

	local var_1_782 = var_1_779.ON_GUILD_JOIN_EVENT

	GuildJoinEventCommand = var_5

	var_1_781(var_1_780, var_1_782, var_5)

	local var_1_783 = arg_1_0.facade
	local var_1_784 = var_2.registerCommand

	GAME = var_1_782

	local var_1_785 = var_1_782.GUILD_RECOMMAND_ASSULT_SHIP

	MarkAssultShipRecommandCommand = var_5

	var_1_784(var_1_783, var_1_785, var_5)

	local var_1_786 = arg_1_0.facade
	local var_1_787 = var_2.registerCommand

	GAME = var_1_785

	local var_1_788 = var_1_785.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE

	GuildRefreshRecommandShipCommand = var_5

	var_1_787(var_1_786, var_1_788, var_5)

	local var_1_789 = arg_1_0.facade
	local var_1_790 = var_2.registerCommand

	GAME = var_1_788

	local var_1_791 = var_1_788.GET_PUBLIC_GUILD_USER_DATA

	GetPublicGuildUserDataCommand = var_5

	var_1_790(var_1_789, var_1_791, var_5)

	local var_1_792 = arg_1_0.facade
	local var_1_793 = var_2.registerCommand

	GAME = var_1_791

	local var_1_794 = var_1_791.PUBLIC_GUILD_COMMIT_DONATE

	PublicGuildCommitDonateCommand = var_5

	var_1_793(var_1_792, var_1_794, var_5)

	local var_1_795 = arg_1_0.facade
	local var_1_796 = var_2.registerCommand

	GAME = var_1_794

	local var_1_797 = var_1_794.PULIC_GUILD_UPGRADE_TECH

	PublicGuildUpgradeTechCommand = var_5

	var_1_796(var_1_795, var_1_797, var_5)

	local var_1_798 = arg_1_0.facade
	local var_1_799 = var_2.registerCommand

	GAME = var_1_797

	local var_1_800 = var_1_797.HANDLE_GUILD_AND_PUBLIC_GUILD_TECH

	HandleGuildAndPublicGuildTechCommand = var_5

	var_1_799(var_1_798, var_1_800, var_5)

	local var_1_801 = arg_1_0.facade
	local var_1_802 = var_2.registerCommand

	GAME = var_1_800

	local var_1_803 = var_1_800.COMMANDER_ON_OPEN_BOX

	GetCommanderCommand = var_5

	var_1_802(var_1_801, var_1_803, var_5)

	local var_1_804 = arg_1_0.facade
	local var_1_805 = var_2.registerCommand

	GAME = var_1_803

	local var_1_806 = var_1_803.COMMANDER_ON_BUILD

	BuildCommaderCommand = var_5

	var_1_805(var_1_804, var_1_806, var_5)

	local var_1_807 = arg_1_0.facade
	local var_1_808 = var_2.registerCommand

	GAME = var_1_806

	local var_1_809 = var_1_806.COMMANDER_RESET_TALENTS

	ResetCommanderTalentsCommand = var_5

	var_1_808(var_1_807, var_1_809, var_5)

	local var_1_810 = arg_1_0.facade
	local var_1_811 = var_2.registerCommand

	GAME = var_1_809

	local var_1_812 = var_1_809.COMMANDER_LEARN_TALENTS

	CommanderLearnTalentCommand = var_5

	var_1_811(var_1_810, var_1_812, var_5)

	local var_1_813 = arg_1_0.facade
	local var_1_814 = var_2.registerCommand

	GAME = var_1_812

	local var_1_815 = var_1_812.COMMANDER_FETCH_NOT_LEARNED_TALENT

	FetchCommanderTalentCommand = var_5

	var_1_814(var_1_813, var_1_815, var_5)

	local var_1_816 = arg_1_0.facade
	local var_1_817 = var_2.registerCommand

	GAME = var_1_815

	local var_1_818 = var_1_815.COMMANDER_UPGRADE

	UpgradeCommanderCommand = var_5

	var_1_817(var_1_816, var_1_818, var_5)

	local var_1_819 = arg_1_0.facade
	local var_1_820 = var_2.registerCommand

	GAME = var_1_818

	local var_1_821 = var_1_818.COOMMANDER_EQUIP_TO_FLEET

	EquipCommanderToFleetCommande = var_5

	var_1_820(var_1_819, var_1_821, var_5)

	local var_1_822 = arg_1_0.facade
	local var_1_823 = var_2.registerCommand

	GAME = var_1_821

	local var_1_824 = var_1_821.COMMANDER_LOCK

	LockCommanderCommande = var_5

	var_1_823(var_1_822, var_1_824, var_5)

	local var_1_825 = arg_1_0.facade
	local var_1_826 = var_2.registerCommand

	GAME = var_1_824

	local var_1_827 = var_1_824.COMMANDER_RESERVE_BOX

	ReserveCommanderBoxCommand = var_5

	var_1_826(var_1_825, var_1_827, var_5)

	local var_1_828 = arg_1_0.facade
	local var_1_829 = var_2.registerCommand

	GAME = var_1_827

	local var_1_830 = var_1_827.COMMANDER_RENAME

	RenameCommanderCommand = var_5

	var_1_829(var_1_828, var_1_830, var_5)

	local var_1_831 = arg_1_0.facade
	local var_1_832 = var_2.registerCommand

	GAME = var_1_830

	local var_1_833 = var_1_830.SET_COMMANDER_PREFAB

	SetComanderPrefabFleetCommand = var_5

	var_1_832(var_1_831, var_1_833, var_5)

	local var_1_834 = arg_1_0.facade
	local var_1_835 = var_2.registerCommand

	GAME = var_1_833

	local var_1_836 = var_1_833.SET_COMMANDER_PREFAB_NAME

	SetCommanderPrefabFleetNameCommand = var_5

	var_1_835(var_1_834, var_1_836, var_5)

	local var_1_837 = arg_1_0.facade
	local var_1_838 = var_2.registerCommand

	GAME = var_1_836

	local var_1_839 = var_1_836.USE_COMMANDER_PREFBA

	CommanderUsePrefabCommand = var_5

	var_1_838(var_1_837, var_1_839, var_5)

	local var_1_840 = arg_1_0.facade
	local var_1_841 = var_2.registerCommand

	GAME = var_1_839

	local var_1_842 = var_1_839.COMMANDER_FORMATION_OP

	CommanderFormationOPCommand = var_5

	var_1_841(var_1_840, var_1_842, var_5)

	local var_1_843 = arg_1_0.facade
	local var_1_844 = var_2.registerCommand

	GAME = var_1_842

	local var_1_845 = var_1_842.SELECT_ELIT_CHAPTER_COMMANDER

	SelectEliteCommanderCommand = var_5

	var_1_844(var_1_843, var_1_845, var_5)

	local var_1_846 = arg_1_0.facade
	local var_1_847 = var_2.registerCommand

	GAME = var_1_845

	local var_1_848 = var_1_845.SELECT_FLEET_COMMANDER

	SelectFleetCommanderCommand = var_5

	var_1_847(var_1_846, var_1_848, var_5)

	local var_1_849 = arg_1_0.facade
	local var_1_850 = var_2.registerCommand

	GAME = var_1_848

	local var_1_851 = var_1_848.REMOVE_ELITE_TARGET_SHIP

	RemoveEliteTargerShipCommand = var_5

	var_1_850(var_1_849, var_1_851, var_5)

	local var_1_852 = arg_1_0.facade
	local var_1_853 = var_2.registerCommand

	GAME = var_1_851

	local var_1_854 = var_1_851.COMMANDER_ON_BATCH

	BatchGetCommanderCommand = var_5

	var_1_853(var_1_852, var_1_854, var_5)

	local var_1_855 = arg_1_0.facade
	local var_1_856 = var_2.registerCommand

	GAME = var_1_854

	local var_1_857 = var_1_854.COMMANDER_CATTERY_OP

	CommanderCatteryOPCommand = var_5

	var_1_856(var_1_855, var_1_857, var_5)

	local var_1_858 = arg_1_0.facade
	local var_1_859 = var_2.registerCommand

	GAME = var_1_857

	local var_1_860 = var_1_857.GET_COMMANDER_HOME

	GetCommanderHomeCommand = var_5

	var_1_859(var_1_858, var_1_860, var_5)

	local var_1_861 = arg_1_0.facade
	local var_1_862 = var_2.registerCommand

	GAME = var_1_860

	local var_1_863 = var_1_860.PUT_COMMANDER_IN_CATTERY

	PutCommanderInCatteryCommand = var_5

	var_1_862(var_1_861, var_1_863, var_5)

	local var_1_864 = arg_1_0.facade
	local var_1_865 = var_2.registerCommand

	GAME = var_1_863

	local var_1_866 = var_1_863.COMMANDER_CHANGE_CATTERY_STYLE

	CommanderChangeCatteryStyleCommand = var_5

	var_1_865(var_1_864, var_1_866, var_5)

	local var_1_867 = arg_1_0.facade
	local var_1_868 = var_2.registerCommand

	GAME = var_1_866

	local var_1_869 = var_1_866.CALC_CATTERY_EXP

	CalcCatteryExpCommand = var_5

	var_1_868(var_1_867, var_1_869, var_5)

	local var_1_870 = arg_1_0.facade
	local var_1_871 = var_2.registerCommand

	GAME = var_1_869

	local var_1_872 = var_1_869.REFRESH_COMMANDER_BOXES

	RefreshCommanderBoxesCommand = var_5

	var_1_871(var_1_870, var_1_872, var_5)

	local var_1_873 = arg_1_0.facade
	local var_1_874 = var_2.registerCommand

	GAME = var_1_872

	local var_1_875 = var_1_872.OPEN_OR_CLOSE_CATTERY

	OpenOrCloseCatteryCommand = var_5

	var_1_874(var_1_873, var_1_875, var_5)

	local var_1_876 = arg_1_0.facade
	local var_1_877 = var_2.registerCommand

	GAME = var_1_875

	local var_1_878 = var_1_875.COMMANDER_QUICKLY_FINISH_BOXES

	CommanderQuicklyFinishBoxesCommand = var_5

	var_1_877(var_1_876, var_1_878, var_5)

	local var_1_879 = arg_1_0.facade
	local var_1_880 = var_2.registerCommand

	GAME = var_1_878

	local var_1_881 = var_1_878.COLLECT_GET_AWARD

	CollectionGetAwardCommand = var_5

	var_1_880(var_1_879, var_1_881, var_5)

	local var_1_882 = arg_1_0.facade
	local var_1_883 = var_2.registerCommand

	GAME = var_1_881

	local var_1_884 = var_1_881.APPRECIATE_GALLERY_UNLOCK

	GalleryUnlockCommand = var_5

	var_1_883(var_1_882, var_1_884, var_5)

	local var_1_885 = arg_1_0.facade
	local var_1_886 = var_2.registerCommand

	GAME = var_1_884

	local var_1_887 = var_1_884.APPRECIATE_MUSIC_UNLOCK

	MusicUnlockCommand = var_5

	var_1_886(var_1_885, var_1_887, var_5)

	local var_1_888 = arg_1_0.facade
	local var_1_889 = var_2.registerCommand

	GAME = var_1_887

	local var_1_890 = var_1_887.APPRECIATE_GALLERY_LIKE

	GalleryLikeCommand = var_5

	var_1_889(var_1_888, var_1_890, var_5)

	local var_1_891 = arg_1_0.facade
	local var_1_892 = var_2.registerCommand

	GAME = var_1_890

	local var_1_893 = var_1_890.APPRECIATE_MUSIC_LIKE

	MusicLikeCommand = var_5

	var_1_892(var_1_891, var_1_893, var_5)

	local var_1_894 = arg_1_0.facade
	local var_1_895 = var_2.registerCommand

	GAME = var_1_893

	local var_1_896 = var_1_893.APPRECIATE_MANGA_READ

	MangaReadCommand = var_5

	var_1_895(var_1_894, var_1_896, var_5)

	local var_1_897 = arg_1_0.facade
	local var_1_898 = var_2.registerCommand

	GAME = var_1_896

	local var_1_899 = var_1_896.APPRECIATE_MANGA_LIKE

	MangaLikeCommand = var_5

	var_1_898(var_1_897, var_1_899, var_5)

	local var_1_900 = arg_1_0.facade
	local var_1_901 = var_2.registerCommand

	GAME = var_1_899

	local var_1_902 = var_1_899.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM

	MusicMainPlayAlbumChangeCommand = var_5

	var_1_901(var_1_900, var_1_902, var_5)

	local var_1_903 = arg_1_0.facade
	local var_1_904 = var_2.registerCommand

	GAME = var_1_902

	local var_1_905 = var_1_902.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE

	MusicPlayLoopTypeChangeCommand = var_5

	var_1_904(var_1_903, var_1_905, var_5)

	local var_1_906 = arg_1_0.facade
	local var_1_907 = var_2.registerCommand

	GAME = var_1_905

	local var_1_908 = var_1_905.TROPHY_CLAIM

	TrophyClaimCommand = var_5

	var_1_907(var_1_906, var_1_908, var_5)

	local var_1_909 = arg_1_0.facade
	local var_1_910 = var_2.registerCommand

	GAME = var_1_908

	local var_1_911 = var_1_908.EVENT_FINISH

	EventFinishCommand = var_5

	var_1_910(var_1_909, var_1_911, var_5)

	local var_1_912 = arg_1_0.facade
	local var_1_913 = var_2.registerCommand

	GAME = var_1_911

	local var_1_914 = var_1_911.EVENT_FLUSH_ALL

	EventFlushCommand = var_5

	var_1_913(var_1_912, var_1_914, var_5)

	local var_1_915 = arg_1_0.facade
	local var_1_916 = var_2.registerCommand

	GAME = var_1_914

	local var_1_917 = var_1_914.EVENT_START

	EventStartCommand = var_5

	var_1_916(var_1_915, var_1_917, var_5)

	local var_1_918 = arg_1_0.facade
	local var_1_919 = var_2.registerCommand

	GAME = var_1_917

	local var_1_920 = var_1_917.EVENT_GIVEUP

	EventGiveUpCommand = var_5

	var_1_919(var_1_918, var_1_920, var_5)

	local var_1_921 = arg_1_0.facade
	local var_1_922 = var_2.registerCommand

	GAME = var_1_920

	local var_1_923 = var_1_920.ACTIVITY_OPERATION

	ActivityOperationCommand = var_5

	var_1_922(var_1_921, var_1_923, var_5)

	local var_1_924 = arg_1_0.facade
	local var_1_925 = var_2.registerCommand

	GAME = var_1_923

	local var_1_926 = var_1_923.ACTIVITY_BOSS_PAGE_UPDATE

	ActivityBossPageUpdateCommond = var_5

	var_1_925(var_1_924, var_1_926, var_5)

	local var_1_927 = arg_1_0.facade
	local var_1_928 = var_2.registerCommand

	GAME = var_1_926

	local var_1_929 = var_1_926.GET_ACTIVITY_SHOP

	GetActivityShopCommand = var_5

	var_1_928(var_1_927, var_1_929, var_5)

	local var_1_930 = arg_1_0.facade
	local var_1_931 = var_2.registerCommand

	GAME = var_1_929

	local var_1_932 = var_1_929.MONOPOLY_OP

	MonopolyOPCommand = var_5

	var_1_931(var_1_930, var_1_932, var_5)

	local var_1_933 = arg_1_0.facade
	local var_1_934 = var_2.registerCommand

	GAME = var_1_932

	local var_1_935 = var_1_932.EDIT_ACTIVITY_FLEET

	EditActivityFleetCommand = var_5

	var_1_934(var_1_933, var_1_935, var_5)

	local var_1_936 = arg_1_0.facade
	local var_1_937 = var_2.registerCommand

	GAME = var_1_935

	local var_1_938 = var_1_935.BLACK_WHITE_GRID_OP

	BlackWhiteGridOPCommand = var_5

	var_1_937(var_1_936, var_1_938, var_5)

	local var_1_939 = arg_1_0.facade
	local var_1_940 = var_2.registerCommand

	GAME = var_1_938

	local var_1_941 = var_1_938.ACT_NEW_PT

	ActivityNewPtOPCommand = var_5

	var_1_940(var_1_939, var_1_941, var_5)

	local var_1_942 = arg_1_0.facade
	local var_1_943 = var_2.registerCommand

	GAME = var_1_941

	local var_1_944 = var_1_941.MEMORYBOOK_UNLOCK

	ActivityMemoryOPCommand = var_5

	var_1_943(var_1_942, var_1_944, var_5)

	local var_1_945 = arg_1_0.facade
	local var_1_946 = var_2.registerCommand

	GAME = var_1_944

	local var_1_947 = var_1_944.RETURN_AWARD_OP

	ReturnAwardOPCommand = var_5

	var_1_946(var_1_945, var_1_947, var_5)

	local var_1_948 = arg_1_0.facade
	local var_1_949 = var_2.registerCommand

	GAME = var_1_947

	local var_1_950 = var_1_947.ACTIVITY_BE_UPDATED

	ActivityBeUpdatedCommand = var_5

	var_1_949(var_1_948, var_1_950, var_5)

	local var_1_951 = arg_1_0.facade
	local var_1_952 = var_2.registerCommand

	GAME = var_1_950

	local var_1_953 = var_1_950.ON_NEW_VOTE

	VoteCommand = var_5

	var_1_952(var_1_951, var_1_953, var_5)

	local var_1_954 = arg_1_0.facade
	local var_1_955 = var_2.registerCommand

	GAME = var_1_953

	local var_1_956 = var_1_953.ACT_BOSS_NORMAL_UPDATE

	ActivityBossNormalUpdateCommand = var_5

	var_1_955(var_1_954, var_1_956, var_5)

	local var_1_957 = arg_1_0.facade
	local var_1_958 = var_2.registerCommand

	GAME = var_1_956

	local var_1_959 = var_1_956.ACT_BOSS_EXCHANGE_TICKET

	ActivityBossExchangeTicketCommand = var_5

	var_1_958(var_1_957, var_1_959, var_5)

	local var_1_960 = arg_1_0.facade
	local var_1_961 = var_2.registerCommand

	GAME = var_1_959

	local var_1_962 = var_1_959.ACT_INSTAGRAM_OP

	InstagramActivityCommand = var_5

	var_1_961(var_1_960, var_1_962, var_5)

	local var_1_963 = arg_1_0.facade
	local var_1_964 = var_2.registerCommand

	GAME = var_1_962

	local var_1_965 = var_1_962.REQ_NEW_INSTAGRAM_DATA

	RequestNewInstagramDataCommand = var_5

	var_1_964(var_1_963, var_1_965, var_5)

	local var_1_966 = arg_1_0.facade
	local var_1_967 = var_2.registerCommand

	GAME = var_1_965

	local var_1_968 = var_1_965.REQ_OLD_INSTAGRAM_DATA

	RequestOldInstagramDataCommand = var_5

	var_1_967(var_1_966, var_1_968, var_5)

	local var_1_969 = arg_1_0.facade
	local var_1_970 = var_2.registerCommand

	GAME = var_1_968

	local var_1_971 = var_1_968.ACT_INSTAGRAM_FETCH

	InstagramFetchCommand = var_5

	var_1_970(var_1_969, var_1_971, var_5)

	local var_1_972 = arg_1_0.facade
	local var_1_973 = var_2.registerCommand

	GAME = var_1_971

	local var_1_974 = var_1_971.ACT_INSTAGRAM_CHAT

	InstagramChatCommand = var_5

	var_1_973(var_1_972, var_1_974, var_5)

	local var_1_975 = arg_1_0.facade
	local var_1_976 = var_2.registerCommand

	GAME = var_1_974

	local var_1_977 = var_1_974.ACT_BEAT_MONSTER_NIAN

	ActivityBeatMonsterNianCommand = var_5

	var_1_976(var_1_975, var_1_977, var_5)

	local var_1_978 = arg_1_0.facade
	local var_1_979 = var_2.registerCommand

	GAME = var_1_977

	local var_1_980 = var_1_977.PUZZLE_PIECE_OP

	ActivityPuzzlePicecOPCommand = var_5

	var_1_979(var_1_978, var_1_980, var_5)

	local var_1_981 = arg_1_0.facade
	local var_1_982 = var_2.registerCommand

	GAME = var_1_980

	local var_1_983 = var_1_980.ACTIVITY_BUILD_POOL_EXCHANGE

	BuildPoolExchangeCommand = var_5

	var_1_982(var_1_981, var_1_983, var_5)

	local var_1_984 = arg_1_0.facade
	local var_1_985 = var_2.registerCommand

	GAME = var_1_983

	local var_1_986 = var_1_983.REGULAR_BUILD_POOL_EXCHANGE

	BuildPoolRegularExchangeCommand = var_5

	var_1_985(var_1_984, var_1_986, var_5)

	local var_1_987 = arg_1_0.facade
	local var_1_988 = var_2.registerCommand

	GAME = var_1_986

	local var_1_989 = var_1_986.ACT_COLLECTION_EVENT_OP

	ActivityCollectionEventCommand = var_5

	var_1_988(var_1_987, var_1_989, var_5)

	local var_1_990 = arg_1_0.facade
	local var_1_991 = var_2.registerCommand

	GAME = var_1_989

	local var_1_992 = var_1_989.ACTIVITY_SHOP_PROGRESS_REWARD

	ActivityShopWithProgressRewardCommand = var_5

	var_1_991(var_1_990, var_1_992, var_5)

	local var_1_993 = arg_1_0.facade
	local var_1_994 = var_2.registerCommand

	GAME = var_1_992

	local var_1_995 = var_1_992.WORLDIN_PICTURE_OP

	ActivityWorldInPictureCommand = var_5

	var_1_994(var_1_993, var_1_995, var_5)

	local var_1_996 = arg_1_0.facade
	local var_1_997 = var_2.registerCommand

	GAME = var_1_995

	local var_1_998 = var_1_995.GET_NEW_SERVER_SHOP

	GetNewServerShopCommand = var_5

	var_1_997(var_1_996, var_1_998, var_5)

	local var_1_999 = arg_1_0.facade
	local var_1_1000 = var_2.registerCommand

	GAME = var_1_998

	local var_1_1001 = var_1_998.NEW_SERVER_SHOP_SHOPPING

	NewServerShopShoppingCommand = var_5

	var_1_1000(var_1_999, var_1_1001, var_5)

	local var_1_1002 = arg_1_0.facade
	local var_1_1003 = var_2.registerCommand

	GAME = var_1_1001

	local var_1_1004 = var_1_1001.SCULPTURE_ACT_OP

	SculptureActivityOpCommand = var_5

	var_1_1003(var_1_1002, var_1_1004, var_5)

	local var_1_1005 = arg_1_0.facade
	local var_1_1006 = var_2.registerCommand

	GAME = var_1_1004

	local var_1_1007 = var_1_1004.GRAFTING_ACT_OP

	GraftingActivityOpCommand = var_5

	var_1_1006(var_1_1005, var_1_1007, var_5)

	local var_1_1008 = arg_1_0.facade
	local var_1_1009 = var_2.registerCommand

	GAME = var_1_1007

	local var_1_1010 = var_1_1007.SYN_GRAFTING_ACTIVITY

	SynGraftingActivityCommand = var_5

	var_1_1009(var_1_1008, var_1_1010, var_5)

	local var_1_1011 = arg_1_0.facade
	local var_1_1012 = var_2.registerCommand

	GAME = var_1_1010

	local var_1_1013 = var_1_1010.ACT_CARD_PUZZLE

	ActivityCardPuzzleCombatCommand = var_5

	var_1_1012(var_1_1011, var_1_1013, var_5)

	local var_1_1014 = arg_1_0.facade
	local var_1_1015 = var_2.registerCommand

	GAME = var_1_1013

	local var_1_1016 = var_1_1013.CASTLE_ACT_OP

	CastleActivityCommand = var_5

	var_1_1015(var_1_1014, var_1_1016, var_5)

	local var_1_1017 = arg_1_0.facade
	local var_1_1018 = var_2.registerCommand

	GAME = var_1_1016

	local var_1_1019 = var_1_1016.ACT_MANUAL_SIGN

	ActivityManualSignCommand = var_5

	var_1_1018(var_1_1017, var_1_1019, var_5)

	local var_1_1020 = arg_1_0.facade
	local var_1_1021 = var_2.registerCommand

	GAME = var_1_1019

	local var_1_1022 = var_1_1019.SENRANKAGURA_TRAIN_ACT_OP

	SenrankaguraTrainCommand = var_5

	var_1_1021(var_1_1020, var_1_1022, var_5)

	local var_1_1023 = arg_1_0.facade
	local var_1_1024 = var_2.registerCommand

	GAME = var_1_1022

	local var_1_1025 = var_1_1022.ACT_RANDOM_DAILY_TASK

	ActivityRandomDailyTaskCommand = var_5

	var_1_1024(var_1_1023, var_1_1025, var_5)

	local var_1_1026 = arg_1_0.facade
	local var_1_1027 = var_2.registerCommand

	GAME = var_1_1025

	local var_1_1028 = var_1_1025.ACTIVITY_STORE_DATE

	ActivityStoreDataCommand = var_5

	var_1_1027(var_1_1026, var_1_1028, var_5)

	local var_1_1029 = arg_1_0.facade
	local var_1_1030 = var_2.registerCommand

	GAME = var_1_1028

	local var_1_1031 = var_1_1028.ACTIVITY_LINER_OP

	ActivityLinerOPCommand = var_5

	var_1_1030(var_1_1029, var_1_1031, var_5)

	local var_1_1032 = arg_1_0.facade
	local var_1_1033 = var_2.registerCommand

	GAME = var_1_1031

	local var_1_1034 = var_1_1031.ACTIVITY_TOWN_OP

	ActivityTownOPCommand = var_5

	var_1_1033(var_1_1032, var_1_1034, var_5)

	local var_1_1035 = arg_1_0.facade
	local var_1_1036 = var_2.registerCommand

	GAME = var_1_1034

	local var_1_1037 = var_1_1034.ACTIVITY_MALL_OP

	ActivityMallOPCommand = var_5

	var_1_1036(var_1_1035, var_1_1037, var_5)

	local var_1_1038 = arg_1_0.facade
	local var_1_1039 = var_2.registerCommand

	GAME = var_1_1037

	local var_1_1040 = var_1_1037.ACTIVITY_UNLOCKSTORY

	ActivityUnlockStoryCommand = var_5

	var_1_1039(var_1_1038, var_1_1040, var_5)

	local var_1_1041 = arg_1_0.facade
	local var_1_1042 = var_2.registerCommand

	GAME = var_1_1040

	local var_1_1043 = var_1_1040.ACTIVITY_DREAMLAND_OP

	ActivityDreamlandOPCommand = var_5

	var_1_1042(var_1_1041, var_1_1043, var_5)

	local var_1_1044 = arg_1_0.facade
	local var_1_1045 = var_2.registerCommand

	GAME = var_1_1043

	local var_1_1046 = var_1_1043.ACTIVITY_PERMANENT_START

	ActivityPermanentStartCommand = var_5

	var_1_1045(var_1_1044, var_1_1046, var_5)

	local var_1_1047 = arg_1_0.facade
	local var_1_1048 = var_2.registerCommand

	GAME = var_1_1046

	local var_1_1049 = var_1_1046.ACTIVITY_PERMANENT_FINISH

	ActivityPermanentFinishCommand = var_5

	var_1_1048(var_1_1047, var_1_1049, var_5)

	local var_1_1050 = arg_1_0.facade
	local var_1_1051 = var_2.registerCommand

	GAME = var_1_1049

	local var_1_1052 = var_1_1049.ACTIVITY_PERMANENT_STOP

	ActivityPermanentStopCommand = var_5

	var_1_1051(var_1_1050, var_1_1052, var_5)

	local var_1_1053 = arg_1_0.facade
	local var_1_1054 = var_2.registerCommand

	GAME = var_1_1052

	local var_1_1055 = var_1_1052.SHAM_SHOPPING

	ShamShoppingCommand = var_5

	var_1_1054(var_1_1053, var_1_1055, var_5)

	local var_1_1056 = arg_1_0.facade
	local var_1_1057 = var_2.registerCommand

	GAME = var_1_1055

	local var_1_1058 = var_1_1055.QUOTA_SHOPPING

	QuotaShoppingCommand = var_5

	var_1_1057(var_1_1056, var_1_1058, var_5)

	local var_1_1059 = arg_1_0.facade
	local var_1_1060 = var_2.registerCommand

	GAME = var_1_1058

	local var_1_1061 = var_1_1058.FETCH_VOTE_INFO

	FetchVoteInfoCommand = var_5

	var_1_1060(var_1_1059, var_1_1061, var_5)

	local var_1_1062 = arg_1_0.facade
	local var_1_1063 = var_2.registerCommand

	GAME = var_1_1061

	local var_1_1064 = var_1_1061.FETCH_VOTE_RANK

	FetchVoteRankCommand = var_5

	var_1_1063(var_1_1062, var_1_1064, var_5)

	local var_1_1065 = arg_1_0.facade
	local var_1_1066 = var_2.registerCommand

	GAME = var_1_1064

	local var_1_1067 = var_1_1064.CLASS_START_COURSE

	StartToLearnCommand = var_5

	var_1_1066(var_1_1065, var_1_1067, var_5)

	local var_1_1068 = arg_1_0.facade
	local var_1_1069 = var_2.registerCommand

	GAME = var_1_1067

	local var_1_1070 = var_1_1067.CLASS_STOP_COURSE

	EndToLearnCommand = var_5

	var_1_1069(var_1_1068, var_1_1070, var_5)

	local var_1_1071 = arg_1_0.facade
	local var_1_1072 = var_2.registerCommand

	GAME = var_1_1070

	local var_1_1073 = var_1_1070.START_TECHNOLOGY

	StartTechnologyCommand = var_5

	var_1_1072(var_1_1071, var_1_1073, var_5)

	local var_1_1074 = arg_1_0.facade
	local var_1_1075 = var_2.registerCommand

	GAME = var_1_1073

	local var_1_1076 = var_1_1073.FINISH_TECHNOLOGY

	FinishTechnologyCommand = var_5

	var_1_1075(var_1_1074, var_1_1076, var_5)

	local var_1_1077 = arg_1_0.facade
	local var_1_1078 = var_2.registerCommand

	GAME = var_1_1076

	local var_1_1079 = var_1_1076.STOP_TECHNOLOGY

	StopTechnologyCommand = var_5

	var_1_1078(var_1_1077, var_1_1079, var_5)

	local var_1_1080 = arg_1_0.facade
	local var_1_1081 = var_2.registerCommand

	GAME = var_1_1079

	local var_1_1082 = var_1_1079.JOIN_QUEUE_TECHNOLOGY

	JoinQueueTechnologyCommand = var_5

	var_1_1081(var_1_1080, var_1_1082, var_5)

	local var_1_1083 = arg_1_0.facade
	local var_1_1084 = var_2.registerCommand

	GAME = var_1_1082

	local var_1_1085 = var_1_1082.FINISH_QUEUE_TECHNOLOGY

	FinishQueueTechnologyCommand = var_5

	var_1_1084(var_1_1083, var_1_1085, var_5)

	local var_1_1086 = arg_1_0.facade
	local var_1_1087 = var_2.registerCommand

	GAME = var_1_1085

	local var_1_1088 = var_1_1085.REFRESH_TECHNOLOGYS

	RefreshTechnologysCommand = var_5

	var_1_1087(var_1_1086, var_1_1088, var_5)

	local var_1_1089 = arg_1_0.facade
	local var_1_1090 = var_2.registerCommand

	GAME = var_1_1088

	local var_1_1091 = var_1_1088.CHANGE_REFRESH_TECHNOLOGYS_TENDENCY

	ChangeRefreshTechnologysTendencyCommand = var_5

	var_1_1090(var_1_1089, var_1_1091, var_5)

	local var_1_1092 = arg_1_0.facade
	local var_1_1093 = var_2.registerCommand

	GAME = var_1_1091

	local var_1_1094 = var_1_1091.SELECT_TEC_TARGET_CATCHUP

	SelectTecTargetCatchupCommand = var_5

	var_1_1093(var_1_1092, var_1_1094, var_5)

	local var_1_1095 = arg_1_0.facade
	local var_1_1096 = var_2.registerCommand

	GAME = var_1_1094

	local var_1_1097 = var_1_1094.RESELECT_TEC_TARGET_CATCHUP

	ReSelectTecTargetCatchupCommand = var_5

	var_1_1096(var_1_1095, var_1_1097, var_5)

	local var_1_1098 = arg_1_0.facade
	local var_1_1099 = var_2.registerCommand

	GAME = var_1_1097

	local var_1_1100 = var_1_1097.USE_TEC_SPEEDUP_ITEM

	UseTecSpeedUpItemCommand = var_5

	var_1_1099(var_1_1098, var_1_1100, var_5)

	local var_1_1101 = arg_1_0.facade
	local var_1_1102 = var_2.registerCommand

	GAME = var_1_1100

	local var_1_1103 = var_1_1100.GET_PHANTOM_QUEST_PROGRESS

	GetPhantomQuestProgressCommand = var_5

	var_1_1102(var_1_1101, var_1_1103, var_5)

	local var_1_1104 = arg_1_0.facade
	local var_1_1105 = var_2.registerCommand

	GAME = var_1_1103

	local var_1_1106 = var_1_1103.FINISH_PHANTOM_QUEST

	FinishPhantomQuestCommand = var_5

	var_1_1105(var_1_1104, var_1_1106, var_5)

	local var_1_1107 = arg_1_0.facade
	local var_1_1108 = var_2.registerCommand

	GAME = var_1_1106

	local var_1_1109 = var_1_1106.BUILD_SHIP_BLUEPRINT

	BuildShipBluePrintCommand = var_5

	var_1_1108(var_1_1107, var_1_1109, var_5)

	local var_1_1110 = arg_1_0.facade
	local var_1_1111 = var_2.registerCommand

	GAME = var_1_1109

	local var_1_1112 = var_1_1109.FINISH_SHIP_BLUEPRINT

	FinishBluePrintCommand = var_5

	var_1_1111(var_1_1110, var_1_1112, var_5)

	local var_1_1113 = arg_1_0.facade
	local var_1_1114 = var_2.registerCommand

	GAME = var_1_1112

	local var_1_1115 = var_1_1112.ITEM_LOCK_SHIP_BLUPRINT

	ItemUnlockBluePrintCommand = var_5

	var_1_1114(var_1_1113, var_1_1115, var_5)

	local var_1_1116 = arg_1_0.facade
	local var_1_1117 = var_2.registerCommand

	GAME = var_1_1115

	local var_1_1118 = var_1_1115.MOD_BLUEPRINT

	ModBluePrintCommand = var_5

	var_1_1117(var_1_1116, var_1_1118, var_5)

	local var_1_1119 = arg_1_0.facade
	local var_1_1120 = var_2.registerCommand

	GAME = var_1_1118

	local var_1_1121 = var_1_1118.PURSUING_BLUEPRINT

	PursuingBluePrintCommand = var_5

	var_1_1120(var_1_1119, var_1_1121, var_5)

	local var_1_1122 = arg_1_0.facade
	local var_1_1123 = var_2.registerCommand

	GAME = var_1_1121

	local var_1_1124 = var_1_1121.STOP_BLUEPRINT

	StopBluePrintCommand = var_5

	var_1_1123(var_1_1122, var_1_1124, var_5)

	local var_1_1125 = arg_1_0.facade
	local var_1_1126 = var_2.registerCommand

	GAME = var_1_1124

	local var_1_1127 = var_1_1124.QUICK_EXCHANGE_BLUEPRINT

	QuickExchangeBlueprintCommand = var_5

	var_1_1126(var_1_1125, var_1_1127, var_5)

	local var_1_1128 = arg_1_0.facade
	local var_1_1129 = var_2.registerCommand

	GAME = var_1_1127

	local var_1_1130 = var_1_1127.START_CAMP_TEC

	StartCampTecCommand = var_5

	var_1_1129(var_1_1128, var_1_1130, var_5)

	local var_1_1131 = arg_1_0.facade
	local var_1_1132 = var_2.registerCommand

	GAME = var_1_1130

	local var_1_1133 = var_1_1130.FINISH_CAMP_TEC

	FinishCampTecCommand = var_5

	var_1_1132(var_1_1131, var_1_1133, var_5)

	local var_1_1134 = arg_1_0.facade
	local var_1_1135 = var_2.registerCommand

	GAME = var_1_1133

	local var_1_1136 = var_1_1133.GET_CAMP_TEC_AWARD

	AwardCampTecCommand = var_5

	var_1_1135(var_1_1134, var_1_1136, var_5)

	local var_1_1137 = arg_1_0.facade
	local var_1_1138 = var_2.registerCommand

	GAME = var_1_1136

	local var_1_1139 = var_1_1136.GET_CAMP_TEC_AWARD_ONESTEP

	AwardCampTecOneStepCommand = var_5

	var_1_1138(var_1_1137, var_1_1139, var_5)

	local var_1_1140 = arg_1_0.facade
	local var_1_1141 = var_2.registerCommand

	GAME = var_1_1139

	local var_1_1142 = var_1_1139.SET_TEC_ATTR_ADDITION

	SetTecAttrAdditionCommand = var_5

	var_1_1141(var_1_1140, var_1_1142, var_5)

	local var_1_1143 = arg_1_0.facade
	local var_1_1144 = var_2.registerCommand

	GAME = var_1_1142

	local var_1_1145 = var_1_1142.REPAIR_META_CHARACTER

	MetaCharacterRepairCommand = var_5

	var_1_1144(var_1_1143, var_1_1145, var_5)

	local var_1_1146 = arg_1_0.facade
	local var_1_1147 = var_2.registerCommand

	GAME = var_1_1145

	local var_1_1148 = var_1_1145.ENERGY_META_ACTIVATION

	MetaCharActiveEnergyCommand = var_5

	var_1_1147(var_1_1146, var_1_1148, var_5)

	local var_1_1149 = arg_1_0.facade
	local var_1_1150 = var_2.registerCommand

	GAME = var_1_1148

	local var_1_1151 = var_1_1148.TACTICS_EXP_META_INFO_REQUEST

	MetaCharacterTacticsInfoRequestCommand = var_5

	var_1_1150(var_1_1149, var_1_1151, var_5)

	local var_1_1152 = arg_1_0.facade
	local var_1_1153 = var_2.registerCommand

	GAME = var_1_1151

	local var_1_1154 = var_1_1151.TACTICS_META_INFO_REQUEST

	MetaCharacterTacticsRequestCommand = var_5

	var_1_1153(var_1_1152, var_1_1154, var_5)

	local var_1_1155 = arg_1_0.facade
	local var_1_1156 = var_2.registerCommand

	GAME = var_1_1154

	local var_1_1157 = var_1_1154.TACTICS_META_UNLOCK_SKILL

	MetaCharacterTacticsUnlockCommand = var_5

	var_1_1156(var_1_1155, var_1_1157, var_5)

	local var_1_1158 = arg_1_0.facade
	local var_1_1159 = var_2.registerCommand

	GAME = var_1_1157

	local var_1_1160 = var_1_1157.TACTICS_META_SWITCH_SKILL

	MetaCharacterTacticsSwitchCommand = var_5

	var_1_1159(var_1_1158, var_1_1160, var_5)

	local var_1_1161 = arg_1_0.facade
	local var_1_1162 = var_2.registerCommand

	GAME = var_1_1160

	local var_1_1163 = var_1_1160.TACTICS_META_LEVELUP_SKILL

	MetaCharacterTacticsLevelUpCommand = var_5

	var_1_1162(var_1_1161, var_1_1163, var_5)

	local var_1_1164 = arg_1_0.facade
	local var_1_1165 = var_2.registerCommand

	GAME = var_1_1163

	local var_1_1166 = var_1_1163.TACTICS_META_LEVELMAX_SHOW_BOX

	MetaCharacterLevelMaxBoxShowCommand = var_5

	var_1_1165(var_1_1164, var_1_1166, var_5)

	local var_1_1167 = arg_1_0.facade
	local var_1_1168 = var_2.registerCommand

	GAME = var_1_1166

	local var_1_1169 = var_1_1166.REQUEST_META_PT_DATA

	MetaPTDataRequestCommand = var_5

	var_1_1168(var_1_1167, var_1_1169, var_5)

	local var_1_1170 = arg_1_0.facade
	local var_1_1171 = var_2.registerCommand

	GAME = var_1_1169

	local var_1_1172 = var_1_1169.GET_META_PT_AWARD

	MetaPTAwardGetCommand = var_5

	var_1_1171(var_1_1170, var_1_1172, var_5)

	local var_1_1173 = arg_1_0.facade
	local var_1_1174 = var_2.registerCommand

	GAME = var_1_1172

	local var_1_1175 = var_1_1172.ON_META_SHOPPING

	MetaShoppingCommand = var_5

	var_1_1174(var_1_1173, var_1_1175, var_5)

	local var_1_1176 = arg_1_0.facade
	local var_1_1177 = var_2.registerCommand

	GAME = var_1_1175

	local var_1_1178 = var_1_1175.META_QUICK_TACTICS

	MetaQuickTacticsCommand = var_5

	var_1_1177(var_1_1176, var_1_1178, var_5)

	local var_1_1179 = arg_1_0.facade
	local var_1_1180 = var_2.registerCommand

	GAME = var_1_1178

	local var_1_1181 = var_1_1178.COLORING_CELL

	ColoringCellCommand = var_5

	var_1_1180(var_1_1179, var_1_1181, var_5)

	local var_1_1182 = arg_1_0.facade
	local var_1_1183 = var_2.registerCommand

	GAME = var_1_1181

	local var_1_1184 = var_1_1181.COLORING_ACHIEVE

	ColoringAchieveCommand = var_5

	var_1_1183(var_1_1182, var_1_1184, var_5)

	local var_1_1185 = arg_1_0.facade
	local var_1_1186 = var_2.registerCommand

	GAME = var_1_1184

	local var_1_1187 = var_1_1184.COLORING_CLEAR

	ColoringClearCommand = var_5

	var_1_1186(var_1_1185, var_1_1187, var_5)

	local var_1_1188 = arg_1_0.facade
	local var_1_1189 = var_2.registerCommand

	GAME = var_1_1187

	local var_1_1190 = var_1_1187.COLORING_FETCH

	ColoringFetchCommand = var_5

	var_1_1189(var_1_1188, var_1_1190, var_5)

	local var_1_1191 = arg_1_0.facade
	local var_1_1192 = var_2.registerCommand

	GAME = var_1_1190

	local var_1_1193 = var_1_1190.WORLD_ACTIVATE

	WorldActivateCommand = var_5

	var_1_1192(var_1_1191, var_1_1193, var_5)

	local var_1_1194 = arg_1_0.facade
	local var_1_1195 = var_2.registerCommand

	GAME = var_1_1193

	local var_1_1196 = var_1_1193.WORLD_MAP_REQ

	WorldMapReqCommand = var_5

	var_1_1195(var_1_1194, var_1_1196, var_5)

	local var_1_1197 = arg_1_0.facade
	local var_1_1198 = var_2.registerCommand

	GAME = var_1_1196

	local var_1_1199 = var_1_1196.WORLD_MAP_OP

	WorldMapOpCommand = var_5

	var_1_1198(var_1_1197, var_1_1199, var_5)

	local var_1_1200 = arg_1_0.facade
	local var_1_1201 = var_2.registerCommand

	GAME = var_1_1199

	local var_1_1202 = var_1_1199.WORLD_STAMINA_EXCHANGE

	WorldStaminaExchangeCommand = var_5

	var_1_1201(var_1_1200, var_1_1202, var_5)

	local var_1_1203 = arg_1_0.facade
	local var_1_1204 = var_2.registerCommand

	GAME = var_1_1202

	local var_1_1205 = var_1_1202.WORLD_KILL

	WorldKillCommand = var_5

	var_1_1204(var_1_1203, var_1_1205, var_5)

	local var_1_1206 = arg_1_0.facade
	local var_1_1207 = var_2.registerCommand

	GAME = var_1_1205

	local var_1_1208 = var_1_1205.WORLD_TRIGGER_TASK

	WorldTriggerTaskCommand = var_5

	var_1_1207(var_1_1206, var_1_1208, var_5)

	local var_1_1209 = arg_1_0.facade
	local var_1_1210 = var_2.registerCommand

	GAME = var_1_1208

	local var_1_1211 = var_1_1208.WORLD_TRIGGER_DAILY_TASK

	WorldTriggerDailyTaskCommand = var_5

	var_1_1210(var_1_1209, var_1_1211, var_5)

	local var_1_1212 = arg_1_0.facade
	local var_1_1213 = var_2.registerCommand

	GAME = var_1_1211

	local var_1_1214 = var_1_1211.WORLD_SUMBMIT_TASK

	WorldSubmitTaskCommand = var_5

	var_1_1213(var_1_1212, var_1_1214, var_5)

	local var_1_1215 = arg_1_0.facade
	local var_1_1216 = var_2.registerCommand

	GAME = var_1_1214

	local var_1_1217 = var_1_1214.WORLD_AUTO_SUMBMIT_TASK

	WorldAutoSubmitTaskCommand = var_5

	var_1_1216(var_1_1215, var_1_1217, var_5)

	local var_1_1218 = arg_1_0.facade
	local var_1_1219 = var_2.registerCommand

	GAME = var_1_1217

	local var_1_1220 = var_1_1217.WORLD_ITEM_USE

	WorldItemUseCommand = var_5

	var_1_1219(var_1_1218, var_1_1220, var_5)

	local var_1_1221 = arg_1_0.facade
	local var_1_1222 = var_2.registerCommand

	GAME = var_1_1220

	local var_1_1223 = var_1_1220.WORLD_PORT_REQ

	WorldPortReqCommand = var_5

	var_1_1222(var_1_1221, var_1_1223, var_5)

	local var_1_1224 = arg_1_0.facade
	local var_1_1225 = var_2.registerCommand

	GAME = var_1_1223

	local var_1_1226 = var_1_1223.WORLD_PORT_SHOPPING

	WorldPortShoppingCommand = var_5

	var_1_1225(var_1_1224, var_1_1226, var_5)

	local var_1_1227 = arg_1_0.facade
	local var_1_1228 = var_2.registerCommand

	GAME = var_1_1226

	local var_1_1229 = var_1_1226.WORLD_PORT_NEW_SHOPPING

	WorldPortNewShoppingCommand = var_5

	var_1_1228(var_1_1227, var_1_1229, var_5)

	local var_1_1230 = arg_1_0.facade
	local var_1_1231 = var_2.registerCommand

	GAME = var_1_1229

	local var_1_1232 = var_1_1229.WORLD_SHIP_REPAIR

	WorldShipRepairCommand = var_5

	var_1_1231(var_1_1230, var_1_1232, var_5)

	local var_1_1233 = arg_1_0.facade
	local var_1_1234 = var_2.registerCommand

	GAME = var_1_1232

	local var_1_1235 = var_1_1232.WORLD_FLEET_REDEPLOY

	WorldFleetRedeployCommand = var_5

	var_1_1234(var_1_1233, var_1_1235, var_5)

	local var_1_1236 = arg_1_0.facade
	local var_1_1237 = var_2.registerCommand

	GAME = var_1_1235

	local var_1_1238 = var_1_1235.WORLD_ACHIEVE

	WorldAchieveCommand = var_5

	var_1_1237(var_1_1236, var_1_1238, var_5)

	local var_1_1239 = arg_1_0.facade
	local var_1_1240 = var_2.registerCommand

	GAME = var_1_1238

	local var_1_1241 = var_1_1238.WORLD_GET_BOSS

	GetWorldBossCommand = var_5

	var_1_1240(var_1_1239, var_1_1241, var_5)

	local var_1_1242 = arg_1_0.facade
	local var_1_1243 = var_2.registerCommand

	GAME = var_1_1241

	local var_1_1244 = var_1_1241.WORLD_GET_BOSS_RANK

	GetWBDamageRankCommand = var_5

	var_1_1243(var_1_1242, var_1_1244, var_5)

	local var_1_1245 = arg_1_0.facade
	local var_1_1246 = var_2.registerCommand

	GAME = var_1_1244

	local var_1_1247 = var_1_1244.WORLD_BOSS_SUPPORT

	WorldBossSupportCommand = var_5

	var_1_1246(var_1_1245, var_1_1247, var_5)

	local var_1_1248 = arg_1_0.facade
	local var_1_1249 = var_2.registerCommand

	GAME = var_1_1247

	local var_1_1250 = var_1_1247.WORLD_BOSS_PT_RECOVER

	WorldBossPtRecoverCommand = var_5

	var_1_1249(var_1_1248, var_1_1250, var_5)

	local var_1_1251 = arg_1_0.facade
	local var_1_1252 = var_2.registerCommand

	GAME = var_1_1250

	local var_1_1253 = var_1_1250.WORLD_BOSS_SUBMIT_AWARD

	SubmitWBAwardCommand = var_5

	var_1_1252(var_1_1251, var_1_1253, var_5)

	local var_1_1254 = arg_1_0.facade
	local var_1_1255 = var_2.registerCommand

	GAME = var_1_1253

	local var_1_1256 = var_1_1253.WORLD_BOSS_START_BATTLE

	WorldBossStartBattleCommand = var_5

	var_1_1255(var_1_1254, var_1_1256, var_5)

	local var_1_1257 = arg_1_0.facade
	local var_1_1258 = var_2.registerCommand

	GAME = var_1_1256

	local var_1_1259 = var_1_1256.WORLD_SELF_BOSS_OVERTIME

	WorldBossOverTimeCommand = var_5

	var_1_1258(var_1_1257, var_1_1259, var_5)

	local var_1_1260 = arg_1_0.facade
	local var_1_1261 = var_2.registerCommand

	GAME = var_1_1259

	local var_1_1262 = var_1_1259.WORLD_ACTIVE_WORLD_BOSS

	ActiveWorldBossCommand = var_5

	var_1_1261(var_1_1260, var_1_1262, var_5)

	local var_1_1263 = arg_1_0.facade
	local var_1_1264 = var_2.registerCommand

	GAME = var_1_1262

	local var_1_1265 = var_1_1262.CHECK_WORLD_BOSS_STATE

	CheckWorldBossStateCommand = var_5

	var_1_1264(var_1_1263, var_1_1265, var_5)

	local var_1_1266 = arg_1_0.facade
	local var_1_1267 = var_2.registerCommand

	GAME = var_1_1265

	local var_1_1268 = var_1_1265.GET_CACHE_BOSS_HP

	GetCacheBossHpCommand = var_5

	var_1_1267(var_1_1266, var_1_1268, var_5)

	local var_1_1269 = arg_1_0.facade
	local var_1_1270 = var_2.registerCommand

	GAME = var_1_1268

	local var_1_1271 = var_1_1268.WORLD_BOSS_BATTLE_QUIT

	WorldBossBattleQuitCommand = var_5

	var_1_1270(var_1_1269, var_1_1271, var_5)

	local var_1_1272 = arg_1_0.facade
	local var_1_1273 = var_2.registerCommand

	GAME = var_1_1271

	local var_1_1274 = var_1_1271.WORLD_BOSS_GET_FORMATION

	WorldBossGetOtherFormationCommand = var_5

	var_1_1273(var_1_1272, var_1_1274, var_5)

	local var_1_1275 = arg_1_0.facade
	local var_1_1276 = var_2.registerCommand

	GAME = var_1_1274

	local var_1_1277 = var_1_1274.SWITCH_WORLD_BOSS_ARCHIVES

	SwitchWorldBossArchivesCommand = var_5

	var_1_1276(var_1_1275, var_1_1277, var_5)

	local var_1_1278 = arg_1_0.facade
	local var_1_1279 = var_2.registerCommand

	GAME = var_1_1277

	local var_1_1280 = var_1_1277.WORLD_ARCHIVES_BOSS_AUTO_BATTLE

	WorldBossArchivesAutoBattleCommand = var_5

	var_1_1279(var_1_1278, var_1_1280, var_5)

	local var_1_1281 = arg_1_0.facade
	local var_1_1282 = var_2.registerCommand

	GAME = var_1_1280

	local var_1_1283 = var_1_1280.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE

	WorldBossArchivesStopAutoBattleCommand = var_5

	var_1_1282(var_1_1281, var_1_1283, var_5)

	local var_1_1284 = arg_1_0.facade
	local var_1_1285 = var_2.registerCommand

	GAME = var_1_1283

	local var_1_1286 = var_1_1283.EXCHANGECODE_USE

	ExchangeCodeUseCommand = var_5

	var_1_1285(var_1_1284, var_1_1286, var_5)

	local var_1_1287 = arg_1_0.facade
	local var_1_1288 = var_2.registerCommand

	GAME = var_1_1286

	local var_1_1289 = var_1_1286.STORY_UPDATE

	UpdateStoryCommand = var_5

	var_1_1288(var_1_1287, var_1_1289, var_5)

	local var_1_1290 = arg_1_0.facade
	local var_1_1291 = var_2.registerCommand

	GAME = var_1_1289

	local var_1_1292 = var_1_1289.STORY_UPDATE_LIST

	UpdateStoryListCommand = var_5

	var_1_1291(var_1_1290, var_1_1292, var_5)

	local var_1_1293 = arg_1_0.facade
	local var_1_1294 = var_2.registerCommand

	GAME = var_1_1292

	local var_1_1295 = var_1_1292.MONTH_CARD_SET_RATIO

	SetMonthCardRatioCommand = var_5

	var_1_1294(var_1_1293, var_1_1295, var_5)

	local var_1_1296 = arg_1_0.facade
	local var_1_1297 = var_2.registerCommand

	GAME = var_1_1295

	local var_1_1298 = var_1_1295.TIME_SYNCHRONIZATION

	TimeSynchronizationCommand = var_5

	var_1_1297(var_1_1296, var_1_1298, var_5)

	local var_1_1299 = arg_1_0.facade
	local var_1_1300 = var_2.registerCommand

	GAME = var_1_1298

	local var_1_1301 = var_1_1298.GET_REMASTER_TICKETS

	GetRemasterCommand = var_5

	var_1_1300(var_1_1299, var_1_1301, var_5)

	local var_1_1302 = arg_1_0.facade
	local var_1_1303 = var_2.registerCommand

	PrayPoolConst = var_1_1301

	local var_1_1304 = var_1_1301.BUILD_PRAY_POOL_CMD

	PrayPoolBuildCommand = var_5

	var_1_1303(var_1_1302, var_1_1304, var_5)

	local var_1_1305 = arg_1_0.facade
	local var_1_1306 = var_2.registerCommand

	GAME = var_1_1304

	local var_1_1307 = var_1_1304.REQUEST_EMOJI_INFO_FROM_SERVER

	EmojiInfoRequestCommand = var_5

	var_1_1306(var_1_1305, var_1_1307, var_5)

	local var_1_1308 = arg_1_0.facade
	local var_1_1309 = var_2.registerCommand

	GAME = var_1_1307

	local var_1_1310 = var_1_1307.FETCH_PASSWORD_STATE

	FetchSecondaryPasswordCommand = var_5

	var_1_1309(var_1_1308, var_1_1310, var_5)

	local var_1_1311 = arg_1_0.facade
	local var_1_1312 = var_2.registerCommand

	GAME = var_1_1310

	local var_1_1313 = var_1_1310.SET_PASSWORD

	SetSecondaryPasswordCommand = var_5

	var_1_1312(var_1_1311, var_1_1313, var_5)

	local var_1_1314 = arg_1_0.facade
	local var_1_1315 = var_2.registerCommand

	GAME = var_1_1313

	local var_1_1316 = var_1_1313.SET_PASSWORD_SETTINGS

	SetSecondaryPasswordSettingsCommand = var_5

	var_1_1315(var_1_1314, var_1_1316, var_5)

	local var_1_1317 = arg_1_0.facade
	local var_1_1318 = var_2.registerCommand

	GAME = var_1_1316

	local var_1_1319 = var_1_1316.CONFIRM_PASSWORD

	ConfirmSecondaryPasswordCommand = var_5

	var_1_1318(var_1_1317, var_1_1319, var_5)

	local var_1_1320 = arg_1_0.facade
	local var_1_1321 = var_2.registerCommand

	GAME = var_1_1319

	local var_1_1322 = var_1_1319.SEND_MINI_GAME_OP

	MiniGameOPCommand = var_5

	var_1_1321(var_1_1320, var_1_1322, var_5)

	local var_1_1323 = arg_1_0.facade
	local var_1_1324 = var_2.registerCommand

	GAME = var_1_1322

	local var_1_1325 = var_1_1322.REQUEST_MINI_GAME

	MiniGameRequestCommand = var_5

	var_1_1324(var_1_1323, var_1_1325, var_5)

	local var_1_1326 = arg_1_0.facade
	local var_1_1327 = var_2.registerCommand

	GAME = var_1_1325

	local var_1_1328 = var_1_1325.MODIFY_MINI_GAME_DATA

	MiniGameModifyDataCommand = var_5

	var_1_1327(var_1_1326, var_1_1328, var_5)

	local var_1_1329 = arg_1_0.facade
	local var_1_1330 = var_2.registerCommand

	GAME = var_1_1328

	local var_1_1331 = var_1_1328.MINI_GAME_TIME

	MiniGameTimeCommand = var_5

	var_1_1330(var_1_1329, var_1_1331, var_5)

	local var_1_1332 = arg_1_0.facade
	local var_1_1333 = var_2.registerCommand

	GAME = var_1_1331

	local var_1_1334 = var_1_1331.MINI_GAME_FRIEND_RANK

	MiniGameFriendRankCommand = var_5

	var_1_1333(var_1_1332, var_1_1334, var_5)

	local var_1_1335 = arg_1_0.facade
	local var_1_1336 = var_2.registerCommand

	GAME = var_1_1334

	local var_1_1337 = var_1_1334.GET_OSS_ARGS

	GetOSSArgsCommand = var_5

	var_1_1336(var_1_1335, var_1_1337, var_5)

	local var_1_1338 = arg_1_0.facade
	local var_1_1339 = var_2.registerCommand

	GAME = var_1_1337

	local var_1_1340 = var_1_1337.CHECK_HOTFIX_VER

	CheckHotfixCommand = var_5

	var_1_1339(var_1_1338, var_1_1340, var_5)

	local var_1_1341 = arg_1_0.facade
	local var_1_1342 = var_2.registerCommand

	GAME = var_1_1340

	local var_1_1343 = var_1_1340.EXTRA_PROTO_RESULT

	ExtraProtoResultCommand = var_5

	var_1_1342(var_1_1341, var_1_1343, var_5)

	local var_1_1344 = arg_1_0.facade
	local var_1_1345 = var_2.registerCommand

	GAME = var_1_1343

	local var_1_1346 = var_1_1343.GET_REFUND_INFO

	GetRefundInfoCommand = var_5

	var_1_1345(var_1_1344, var_1_1346, var_5)

	local var_1_1347 = arg_1_0.facade
	local var_1_1348 = var_2.registerCommand

	GAME = var_1_1346

	local var_1_1349 = var_1_1346.ACCOUNT_SEARCH

	AccountSearchCommand = var_5

	var_1_1348(var_1_1347, var_1_1349, var_5)

	local var_1_1350 = arg_1_0.facade
	local var_1_1351 = var_2.registerCommand

	GAME = var_1_1349

	local var_1_1352 = var_1_1349.CRUSING_CMD

	ActivityCrusingOPCommand = var_5

	var_1_1351(var_1_1350, var_1_1352, var_5)

	local var_1_1353 = arg_1_0.facade
	local var_1_1354 = var_2.registerCommand

	GAME = var_1_1352

	local var_1_1355 = var_1_1352.CRUSING_LAST_TIME_MSGBOX

	ActivityCrusingLastTimeCommand = var_5

	var_1_1354(var_1_1353, var_1_1355, var_5)

	local var_1_1356 = arg_1_0.facade
	local var_1_1357 = var_2.registerCommand

	GAME = var_1_1355

	local var_1_1358 = var_1_1355.COMPOSITE_SPWEAPON

	CompositeSpWeaponCommand = var_5

	var_1_1357(var_1_1356, var_1_1358, var_5)

	local var_1_1359 = arg_1_0.facade
	local var_1_1360 = var_2.registerCommand

	GAME = var_1_1358

	local var_1_1361 = var_1_1358.UPGRADE_SPWEAPON

	UpgradeSpWeaponCommand = var_5

	var_1_1360(var_1_1359, var_1_1361, var_5)

	local var_1_1362 = arg_1_0.facade
	local var_1_1363 = var_2.registerCommand

	GAME = var_1_1361

	local var_1_1364 = var_1_1361.REFORGE_SPWEAPON

	ReforgeSpWeaponCommand = var_5

	var_1_1363(var_1_1362, var_1_1364, var_5)

	local var_1_1365 = arg_1_0.facade
	local var_1_1366 = var_2.registerCommand

	GAME = var_1_1364

	local var_1_1367 = var_1_1364.CONFIRM_REFORGE_SPWEAPON

	ConfirmReforgeSpWeaponCommand = var_5

	var_1_1366(var_1_1365, var_1_1367, var_5)

	local var_1_1368 = arg_1_0.facade
	local var_1_1369 = var_2.registerCommand

	GAME = var_1_1367

	local var_1_1370 = var_1_1367.EQUIP_SPWEAPON_TO_SHIP

	UpdateShipSpWeaponCommand = var_5

	var_1_1369(var_1_1368, var_1_1370, var_5)

	local var_1_1371 = arg_1_0.facade
	local var_1_1372 = var_2.registerCommand

	GAME = var_1_1370

	local var_1_1373 = var_1_1370.EQUIP_SPWEAPON_FROM_SHIP

	EquipSpWeaponFromShipCommand = var_5

	var_1_1372(var_1_1371, var_1_1373, var_5)

	local var_1_1374 = arg_1_0.facade
	local var_1_1375 = var_2.registerCommand

	GAME = var_1_1373

	local var_1_1376 = var_1_1373.SUBMIT_ACTIVITY_TASK

	SubmitActiveTaskCommand = var_5

	var_1_1375(var_1_1374, var_1_1376, var_5)

	local var_1_1377 = arg_1_0.facade
	local var_1_1378 = var_2.registerCommand

	GAME = var_1_1376

	local var_1_1379 = var_1_1376.SUBMIT_ACTIVITY_TASK_V2

	SubmitActiveTaskV2Command = var_5

	var_1_1378(var_1_1377, var_1_1379, var_5)

	local var_1_1380 = arg_1_0.facade
	local var_1_1381 = var_2.registerCommand

	GAME = var_1_1379

	local var_1_1382 = var_1_1379.REFLUX_REQUEST_DATA

	RefluxRequestDataCommand = var_5

	var_1_1381(var_1_1380, var_1_1382, var_5)

	local var_1_1383 = arg_1_0.facade
	local var_1_1384 = var_2.registerCommand

	GAME = var_1_1382

	local var_1_1385 = var_1_1382.REFLUX_SIGN

	RefluxSignCommand = var_5

	var_1_1384(var_1_1383, var_1_1385, var_5)

	local var_1_1386 = arg_1_0.facade
	local var_1_1387 = var_2.registerCommand

	GAME = var_1_1385

	local var_1_1388 = var_1_1385.REFLUX_GET_PT_AWARD

	RefluxGetPTAwardCommand = var_5

	var_1_1387(var_1_1386, var_1_1388, var_5)

	local var_1_1389 = arg_1_0.facade
	local var_1_1390 = var_2.registerCommand

	GAME = var_1_1388

	local var_1_1391 = var_1_1388.REQUEST_ATELIER

	AtelierRequestCommand = var_5

	var_1_1390(var_1_1389, var_1_1391, var_5)

	local var_1_1392 = arg_1_0.facade
	local var_1_1393 = var_2.registerCommand

	GAME = var_1_1391

	local var_1_1394 = var_1_1391.COMPOSITE_ATELIER_RECIPE

	AtelierCompositeCommand = var_5

	var_1_1393(var_1_1392, var_1_1394, var_5)

	local var_1_1395 = arg_1_0.facade
	local var_1_1396 = var_2.registerCommand

	GAME = var_1_1394

	local var_1_1397 = var_1_1394.UPDATE_ATELIER_BUFF

	AtelierRefreshBuffCommand = var_5

	var_1_1396(var_1_1395, var_1_1397, var_5)

	local var_1_1398 = arg_1_0.facade
	local var_1_1399 = var_2.registerCommand

	GAME = var_1_1397

	local var_1_1400 = var_1_1397.BOSSRUSH_TRACE

	BossRushTracingCommand = var_5

	var_1_1399(var_1_1398, var_1_1400, var_5)

	local var_1_1401 = arg_1_0.facade
	local var_1_1402 = var_2.registerCommand

	GAME = var_1_1400

	local var_1_1403 = var_1_1400.BOSSRUSH_SETTLE

	BossRushSettlementCommand = var_5

	var_1_1402(var_1_1401, var_1_1403, var_5)

	local var_1_1404 = arg_1_0.facade
	local var_1_1405 = var_2.registerCommand

	GAME = var_1_1403

	local var_1_1406 = var_1_1403.COLLABRATE_BOSS_RUSH_REQUEST_DATA

	CollabrateBossRushRequestDataCommand = var_5

	var_1_1405(var_1_1404, var_1_1406, var_5)

	local var_1_1407 = arg_1_0.facade
	local var_1_1408 = var_2.registerCommand

	GAME = var_1_1406

	local var_1_1409 = var_1_1406.WORKBENCH_COMPOSITE

	WorkBenchCompositeCommand = var_5

	var_1_1408(var_1_1407, var_1_1409, var_5)

	local var_1_1410 = arg_1_0.facade
	local var_1_1411 = var_2.registerCommand

	GAME = var_1_1409

	local var_1_1412 = var_1_1409.WORKBENCH_ITEM_GO

	WorkBenchItemGoCommand = var_5

	var_1_1411(var_1_1410, var_1_1412, var_5)

	local var_1_1413 = arg_1_0.facade
	local var_1_1414 = var_2.registerCommand

	GAME = var_1_1412

	local var_1_1415 = var_1_1412.SURVEY_REQUEST

	SurveyCommand = var_5

	var_1_1414(var_1_1413, var_1_1415, var_5)

	local var_1_1416 = arg_1_0.facade
	local var_1_1417 = var_2.registerCommand

	GAME = var_1_1415

	local var_1_1418 = var_1_1415.GET_SURVEY_STATE

	SurveyStateCommand = var_5

	var_1_1417(var_1_1416, var_1_1418, var_5)

	local var_1_1419 = arg_1_0.facade
	local var_1_1420 = var_2.registerCommand

	GAME = var_1_1418

	local var_1_1421 = var_1_1418.REQUEST_NODE_LIST

	IslandRequestCommand = var_5

	var_1_1420(var_1_1419, var_1_1421, var_5)

	local var_1_1422 = arg_1_0.facade
	local var_1_1423 = var_2.registerCommand

	GAME = var_1_1421

	local var_1_1424 = var_1_1421.ISLAND_NODE_MARK

	IslandNodeMarkCommand = var_5

	var_1_1423(var_1_1422, var_1_1424, var_5)

	local var_1_1425 = arg_1_0.facade
	local var_1_1426 = var_2.registerCommand

	GAME = var_1_1424

	local var_1_1427 = var_1_1424.ISLAND_EVENT_TRIGGER

	IslandEventTriggerCommand = var_5

	var_1_1426(var_1_1425, var_1_1427, var_5)

	local var_1_1428 = arg_1_0.facade
	local var_1_1429 = var_2.registerCommand

	GAME = var_1_1427

	local var_1_1430 = var_1_1427.ISLAND_SHOPPING

	IslandShoppingCommand = var_5

	var_1_1429(var_1_1428, var_1_1430, var_5)

	local var_1_1431 = arg_1_0.facade
	local var_1_1432 = var_2.registerCommand

	GAME = var_1_1430

	local var_1_1433 = var_1_1430.ISLAND_FLOWER_GET

	IslandFlowerFieldGetAwardCommand = var_5

	var_1_1432(var_1_1431, var_1_1433, var_5)

	local var_1_1434 = arg_1_0.facade
	local var_1_1435 = var_2.registerCommand

	GAME = var_1_1433

	local var_1_1436 = var_1_1433.ISLAND_TASK_GO

	IslandTaskGoCommand = var_5

	var_1_1435(var_1_1434, var_1_1436, var_5)

	local var_1_1437 = arg_1_0.facade
	local var_1_1438 = var_2.registerCommand

	GAME = var_1_1436

	local var_1_1439 = var_1_1436.GET_MINI_GAME_SHOP

	GetMiniGameShopCommand = var_5

	var_1_1438(var_1_1437, var_1_1439, var_5)

	local var_1_1440 = arg_1_0.facade
	local var_1_1441 = var_2.registerCommand

	GAME = var_1_1439

	local var_1_1442 = var_1_1439.MINI_GAME_SHOP_FLUSH

	MiniGameShopFlushCommand = var_5

	var_1_1441(var_1_1440, var_1_1442, var_5)

	local var_1_1443 = arg_1_0.facade
	local var_1_1444 = var_2.registerCommand

	GAME = var_1_1442

	local var_1_1445 = var_1_1442.MINI_GAME_SHOP_BUY

	MiniGameShopBuyCommand = var_5

	var_1_1444(var_1_1443, var_1_1445, var_5)

	local var_1_1446 = arg_1_0.facade
	local var_1_1447 = var_2.registerCommand

	GAME = var_1_1445

	local var_1_1448 = var_1_1445.GAME_ROOM_WEEK_COIN

	GameRoomWeekCoinCommand = var_5

	var_1_1447(var_1_1446, var_1_1448, var_5)

	local var_1_1449 = arg_1_0.facade
	local var_1_1450 = var_2.registerCommand

	GAME = var_1_1448

	local var_1_1451 = var_1_1448.GAME_ROOM_FIRST_COIN

	GameRoomFirstCoinCommand = var_5

	var_1_1450(var_1_1449, var_1_1451, var_5)

	local var_1_1452 = arg_1_0.facade
	local var_1_1453 = var_2.registerCommand

	GAME = var_1_1451

	local var_1_1454 = var_1_1451.GAME_ROOM_EXCHANGE_COIN

	GameRoomExchangeCoinCommand = var_5

	var_1_1453(var_1_1452, var_1_1454, var_5)

	local var_1_1455 = arg_1_0.facade
	local var_1_1456 = var_2.registerCommand

	GAME = var_1_1454

	local var_1_1457 = var_1_1454.GAME_ROOM_SUCCESS

	GameRoomSuccessCommand = var_5

	var_1_1456(var_1_1455, var_1_1457, var_5)

	local var_1_1458 = arg_1_0.facade
	local var_1_1459 = var_2.registerCommand

	LimitChallengeConst = var_1_1457

	local var_1_1460 = var_1_1457.REQ_CHALLENGE_INFO

	LimitChallengeReqCommand = var_5

	var_1_1459(var_1_1458, var_1_1460, var_5)

	local var_1_1461 = arg_1_0.facade
	local var_1_1462 = var_2.registerCommand

	LimitChallengeConst = var_1_1460

	local var_1_1463 = var_1_1460.GET_CHALLENGE_AWARD

	LimitChallengeGetAwardCommand = var_5

	var_1_1462(var_1_1461, var_1_1463, var_5)

	local var_1_1464 = arg_1_0.facade
	local var_1_1465 = var_2.registerCommand

	GAME = var_1_1463

	local var_1_1466 = var_1_1463.EDUCATE_REQUEST

	EducateRequestCommand = var_5

	var_1_1465(var_1_1464, var_1_1466, var_5)

	local var_1_1467 = arg_1_0.facade
	local var_1_1468 = var_2.registerCommand

	GAME = var_1_1466

	local var_1_1469 = var_1_1466.EDUCATE_SET_CALL

	EducateSetCallCommand = var_5

	var_1_1468(var_1_1467, var_1_1469, var_5)

	local var_1_1470 = arg_1_0.facade
	local var_1_1471 = var_2.registerCommand

	GAME = var_1_1469

	local var_1_1472 = var_1_1469.EDUCATE_ADD_EXTRA_ATTR

	EducateAddExtraAttrCommand = var_5

	var_1_1471(var_1_1470, var_1_1472, var_5)

	local var_1_1473 = arg_1_0.facade
	local var_1_1474 = var_2.registerCommand

	GAME = var_1_1472

	local var_1_1475 = var_1_1472.EDUCATE_GET_PLANS

	EducateGetPlansCommand = var_5

	var_1_1474(var_1_1473, var_1_1475, var_5)

	local var_1_1476 = arg_1_0.facade
	local var_1_1477 = var_2.registerCommand

	GAME = var_1_1475

	local var_1_1478 = var_1_1475.EDUCATE_EXECUTE_PLANS

	EducateExecutePlansCommand = var_5

	var_1_1477(var_1_1476, var_1_1478, var_5)

	local var_1_1479 = arg_1_0.facade
	local var_1_1480 = var_2.registerCommand

	GAME = var_1_1478

	local var_1_1481 = var_1_1478.EDUCATE_MAP_SITE

	EducateMapSiteCommand = var_5

	var_1_1480(var_1_1479, var_1_1481, var_5)

	local var_1_1482 = arg_1_0.facade
	local var_1_1483 = var_2.registerCommand

	GAME = var_1_1481

	local var_1_1484 = var_1_1481.EDUCATE_REQUEST_OPTION

	EducateRequestOptionCommand = var_5

	var_1_1483(var_1_1482, var_1_1484, var_5)

	local var_1_1485 = arg_1_0.facade
	local var_1_1486 = var_2.registerCommand

	GAME = var_1_1484

	local var_1_1487 = var_1_1484.EDUCATE_SET_TARGET

	EducateSetTargetCommand = var_5

	var_1_1486(var_1_1485, var_1_1487, var_5)

	local var_1_1488 = arg_1_0.facade
	local var_1_1489 = var_2.registerCommand

	GAME = var_1_1487

	local var_1_1490 = var_1_1487.EDUCATE_GET_TARGET_AWARD

	EducateGetTargetAwardCommand = var_5

	var_1_1489(var_1_1488, var_1_1490, var_5)

	local var_1_1491 = arg_1_0.facade
	local var_1_1492 = var_2.registerCommand

	GAME = var_1_1490

	local var_1_1493 = var_1_1490.EDUCATE_SUBMIT_TASK

	EducateSubmitTaskCommand = var_5

	var_1_1492(var_1_1491, var_1_1493, var_5)

	local var_1_1494 = arg_1_0.facade
	local var_1_1495 = var_2.registerCommand

	GAME = var_1_1493

	local var_1_1496 = var_1_1493.EDUCATE_ADD_TASK_PROGRESS

	EducateAddTaskProgressCommand = var_5

	var_1_1495(var_1_1494, var_1_1496, var_5)

	local var_1_1497 = arg_1_0.facade
	local var_1_1498 = var_2.registerCommand

	GAME = var_1_1496

	local var_1_1499 = var_1_1496.EDUCATE_UPGRADE_FAVOR

	EducateUpgradeFavorCommand = var_5

	var_1_1498(var_1_1497, var_1_1499, var_5)

	local var_1_1500 = arg_1_0.facade
	local var_1_1501 = var_2.registerCommand

	GAME = var_1_1499

	local var_1_1502 = var_1_1499.EDUCATE_GET_EVENTS

	EducateGetEventsCommand = var_5

	var_1_1501(var_1_1500, var_1_1502, var_5)

	local var_1_1503 = arg_1_0.facade
	local var_1_1504 = var_2.registerCommand

	GAME = var_1_1502

	local var_1_1505 = var_1_1502.EDUCATE_TRIGGER_EVENT

	EducateTriggerEventCommand = var_5

	var_1_1504(var_1_1503, var_1_1505, var_5)

	local var_1_1506 = arg_1_0.facade
	local var_1_1507 = var_2.registerCommand

	GAME = var_1_1505

	local var_1_1508 = var_1_1505.EDUCATE_TRIGGER_SPEC_EVENT

	EducateTriggerSpecEventCommand = var_5

	var_1_1507(var_1_1506, var_1_1508, var_5)

	local var_1_1509 = arg_1_0.facade
	local var_1_1510 = var_2.registerCommand

	GAME = var_1_1508

	local var_1_1511 = var_1_1508.EDUCATE_REQUEST_SHOP_DATA

	EducateRequestShopDataCommand = var_5

	var_1_1510(var_1_1509, var_1_1511, var_5)

	local var_1_1512 = arg_1_0.facade
	local var_1_1513 = var_2.registerCommand

	GAME = var_1_1511

	local var_1_1514 = var_1_1511.EDUCATE_SHOPPING

	EducateShoppingCommand = var_5

	var_1_1513(var_1_1512, var_1_1514, var_5)

	local var_1_1515 = arg_1_0.facade
	local var_1_1516 = var_2.registerCommand

	GAME = var_1_1514

	local var_1_1517 = var_1_1514.EDUCATE_TRIGGER_END

	EducateTriggerEndCommand = var_5

	var_1_1516(var_1_1515, var_1_1517, var_5)

	local var_1_1518 = arg_1_0.facade
	local var_1_1519 = var_2.registerCommand

	GAME = var_1_1517

	local var_1_1520 = var_1_1517.EDUCATE_GET_ENDINGS

	EducateGetEndingsCommand = var_5

	var_1_1519(var_1_1518, var_1_1520, var_5)

	local var_1_1521 = arg_1_0.facade
	local var_1_1522 = var_2.registerCommand

	GAME = var_1_1520

	local var_1_1523 = var_1_1520.EDUCATE_RESET

	EducateResetCommand = var_5

	var_1_1522(var_1_1521, var_1_1523, var_5)

	local var_1_1524 = arg_1_0.facade
	local var_1_1525 = var_2.registerCommand

	GAME = var_1_1523

	local var_1_1526 = var_1_1523.EDUCATE_REFRESH

	EducateRefreshCommand = var_5

	var_1_1525(var_1_1524, var_1_1526, var_5)

	local var_1_1527 = arg_1_0.facade
	local var_1_1528 = var_2.registerCommand

	GAME = var_1_1526

	local var_1_1529 = var_1_1526.EDUCATE_BUY_COLLECT

	EducateBuyCollectCommand = var_5

	var_1_1528(var_1_1527, var_1_1529, var_5)

	local var_1_1530 = arg_1_0.facade
	local var_1_1531 = var_2.registerCommand

	GAME = var_1_1529

	local var_1_1532 = var_1_1529.CHANGE_EDUCATE

	ChangeEducateCharacterCommand = var_5

	var_1_1531(var_1_1530, var_1_1532, var_5)

	local var_1_1533 = arg_1_0.facade
	local var_1_1534 = var_2.registerCommand

	GAME = var_1_1532

	local var_1_1535 = var_1_1532.NEW_EDUCATE_REQUEST

	NewEducateRequestCommand = var_5

	var_1_1534(var_1_1533, var_1_1535, var_5)

	local var_1_1536 = arg_1_0.facade
	local var_1_1537 = var_2.registerCommand

	GAME = var_1_1535

	local var_1_1538 = var_1_1535.NEW_EDUCATE_SET_CALL

	NewEducateSetCallCommand = var_5

	var_1_1537(var_1_1536, var_1_1538, var_5)

	local var_1_1539 = arg_1_0.facade
	local var_1_1540 = var_2.registerCommand

	GAME = var_1_1538

	local var_1_1541 = var_1_1538.NEW_EDUCATE_UPGRADE_FAVOR

	NewEducateUpgradeFavorCommand = var_5

	var_1_1540(var_1_1539, var_1_1541, var_5)

	local var_1_1542 = arg_1_0.facade
	local var_1_1543 = var_2.registerCommand

	GAME = var_1_1541

	local var_1_1544 = var_1_1541.NEW_EDUCATE_TRIGGER_NODE

	NewEducateTriggerNodeCommand = var_5

	var_1_1543(var_1_1542, var_1_1544, var_5)

	local var_1_1545 = arg_1_0.facade
	local var_1_1546 = var_2.registerCommand

	GAME = var_1_1544

	local var_1_1547 = var_1_1544.NEW_EDUCATE_UPGRADE_PLAN

	NewEducateUpgradePlanCommand = var_5

	var_1_1546(var_1_1545, var_1_1547, var_5)

	local var_1_1548 = arg_1_0.facade
	local var_1_1549 = var_2.registerCommand

	GAME = var_1_1547

	local var_1_1550 = var_1_1547.NEW_EDUCATE_SCHEDULE

	NewEducateScheduleCommand = var_5

	var_1_1549(var_1_1548, var_1_1550, var_5)

	local var_1_1551 = arg_1_0.facade
	local var_1_1552 = var_2.registerCommand

	GAME = var_1_1550

	local var_1_1553 = var_1_1550.NEW_EDUCATE_SCHEDULE_SKIP

	NewEducateScheduleSkipCommand = var_5

	var_1_1552(var_1_1551, var_1_1553, var_5)

	local var_1_1554 = arg_1_0.facade
	local var_1_1555 = var_2.registerCommand

	GAME = var_1_1553

	local var_1_1556 = var_1_1553.NEW_EDUCATE_NEXT_PLAN

	NewEducateNextPlanCommand = var_5

	var_1_1555(var_1_1554, var_1_1556, var_5)

	local var_1_1557 = arg_1_0.facade
	local var_1_1558 = var_2.registerCommand

	GAME = var_1_1556

	local var_1_1559 = var_1_1556.NEW_EDUCATE_GET_EXTRA_DROP

	NewEducateGetExtraDropCommand = var_5

	var_1_1558(var_1_1557, var_1_1559, var_5)

	local var_1_1560 = arg_1_0.facade
	local var_1_1561 = var_2.registerCommand

	GAME = var_1_1559

	local var_1_1562 = var_1_1559.NEW_EDUCATE_MAIN_EVENT

	NewEducateMainEventCommand = var_5

	var_1_1561(var_1_1560, var_1_1562, var_5)

	local var_1_1563 = arg_1_0.facade
	local var_1_1564 = var_2.registerCommand

	GAME = var_1_1562

	local var_1_1565 = var_1_1562.NEW_EDUCATE_GET_TALENTS

	NewEducateGetTalentsCommand = var_5

	var_1_1564(var_1_1563, var_1_1565, var_5)

	local var_1_1566 = arg_1_0.facade
	local var_1_1567 = var_2.registerCommand

	GAME = var_1_1565

	local var_1_1568 = var_1_1565.NEW_EDUCATE_REFRESH_TALENT

	NewEducateRefreshTalentCommand = var_5

	var_1_1567(var_1_1566, var_1_1568, var_5)

	local var_1_1569 = arg_1_0.facade
	local var_1_1570 = var_2.registerCommand

	GAME = var_1_1568

	local var_1_1571 = var_1_1568.NEW_EDUCATE_SEL_TALENT

	NewEducateSelTalentCommand = var_5

	var_1_1570(var_1_1569, var_1_1571, var_5)

	local var_1_1572 = arg_1_0.facade
	local var_1_1573 = var_2.registerCommand

	GAME = var_1_1571

	local var_1_1574 = var_1_1571.NEW_EDUCATE_GET_CHOOSE

	NewEducateGetChooseCommand = var_5

	var_1_1573(var_1_1572, var_1_1574, var_5)

	local var_1_1575 = arg_1_0.facade
	local var_1_1576 = var_2.registerCommand

	GAME = var_1_1574

	local var_1_1577 = var_1_1574.NEW_EDUCATE_GET_TOPICS

	NewEducateGetTopicsCommand = var_5

	var_1_1576(var_1_1575, var_1_1577, var_5)

	local var_1_1578 = arg_1_0.facade
	local var_1_1579 = var_2.registerCommand

	GAME = var_1_1577

	local var_1_1580 = var_1_1577.NEW_EDUCATE_SEL_TOPIC

	NewEducateSelTopicCommand = var_5

	var_1_1579(var_1_1578, var_1_1580, var_5)

	local var_1_1581 = arg_1_0.facade
	local var_1_1582 = var_2.registerCommand

	GAME = var_1_1580

	local var_1_1583 = var_1_1580.NEW_EDUCATE_SEL_MIND

	NewEducateSelMindCommand = var_5

	var_1_1582(var_1_1581, var_1_1583, var_5)

	local var_1_1584 = arg_1_0.facade
	local var_1_1585 = var_2.registerCommand

	GAME = var_1_1583

	local var_1_1586 = var_1_1583.NEW_EDUCATE_ENTER_ASSESS

	NewEducateEnterAssessCommand = var_5

	var_1_1585(var_1_1584, var_1_1586, var_5)

	local var_1_1587 = arg_1_0.facade
	local var_1_1588 = var_2.registerCommand

	GAME = var_1_1586

	local var_1_1589 = var_1_1586.NEW_EDUCATE_ASSESS

	NewEducateAssessCommand = var_5

	var_1_1588(var_1_1587, var_1_1589, var_5)

	local var_1_1590 = arg_1_0.facade
	local var_1_1591 = var_2.registerCommand

	GAME = var_1_1589

	local var_1_1592 = var_1_1589.NEW_EDUCATE_CHANGE_PHASE

	NewEducateChangePhaseCommand = var_5

	var_1_1591(var_1_1590, var_1_1592, var_5)

	local var_1_1593 = arg_1_0.facade
	local var_1_1594 = var_2.registerCommand

	GAME = var_1_1592

	local var_1_1595 = var_1_1592.NEW_EDUCATE_GET_MAP

	NewEducateGetMapCommand = var_5

	var_1_1594(var_1_1593, var_1_1595, var_5)

	local var_1_1596 = arg_1_0.facade
	local var_1_1597 = var_2.registerCommand

	GAME = var_1_1595

	local var_1_1598 = var_1_1595.NEW_EDUCATE_UPGRADE_NORMAL_SITE

	NewEducateUpgradeNormalSiteCommand = var_5

	var_1_1597(var_1_1596, var_1_1598, var_5)

	local var_1_1599 = arg_1_0.facade
	local var_1_1600 = var_2.registerCommand

	GAME = var_1_1598

	local var_1_1601 = var_1_1598.NEW_EDUCATE_MAP_NORMAL

	NewEducateMapNormalCommand = var_5

	var_1_1600(var_1_1599, var_1_1601, var_5)

	local var_1_1602 = arg_1_0.facade
	local var_1_1603 = var_2.registerCommand

	GAME = var_1_1601

	local var_1_1604 = var_1_1601.NEW_EDUCATE_MAP_EVENT

	NewEducateMapEventCommand = var_5

	var_1_1603(var_1_1602, var_1_1604, var_5)

	local var_1_1605 = arg_1_0.facade
	local var_1_1606 = var_2.registerCommand

	GAME = var_1_1604

	local var_1_1607 = var_1_1604.NEW_EDUCATE_MAP_SHIP

	NewEducateMapShipCommand = var_5

	var_1_1606(var_1_1605, var_1_1607, var_5)

	local var_1_1608 = arg_1_0.facade
	local var_1_1609 = var_2.registerCommand

	GAME = var_1_1607

	local var_1_1610 = var_1_1607.NEW_EDUCATE_SHOPPING

	NewEducateShoppingCommand = var_5

	var_1_1609(var_1_1608, var_1_1610, var_5)

	local var_1_1611 = arg_1_0.facade
	local var_1_1612 = var_2.registerCommand

	GAME = var_1_1610

	local var_1_1613 = var_1_1610.NEW_EDUCATE_GET_ENDINGS

	NewEducateGetEndingsCommand = var_5

	var_1_1612(var_1_1611, var_1_1613, var_5)

	local var_1_1614 = arg_1_0.facade
	local var_1_1615 = var_2.registerCommand

	GAME = var_1_1613

	local var_1_1616 = var_1_1613.NEW_EDUCATE_SEL_ENDING

	NewEducateSelEndingCommand = var_5

	var_1_1615(var_1_1614, var_1_1616, var_5)

	local var_1_1617 = arg_1_0.facade
	local var_1_1618 = var_2.registerCommand

	GAME = var_1_1616

	local var_1_1619 = var_1_1616.NEW_EDUCATE_RESET

	NewEducateResetCommand = var_5

	var_1_1618(var_1_1617, var_1_1619, var_5)

	local var_1_1620 = arg_1_0.facade
	local var_1_1621 = var_2.registerCommand

	GAME = var_1_1619

	local var_1_1622 = var_1_1619.NEW_EDUCATE_REFRESH

	NewEducateRefreshCommand = var_5

	var_1_1621(var_1_1620, var_1_1622, var_5)

	local var_1_1623 = arg_1_0.facade
	local var_1_1624 = var_2.registerCommand

	GAME = var_1_1622

	local var_1_1625 = var_1_1622.NEW_EDUCATE_CLEAR_NODE_CHAIN

	NewEducateClearNodeChainCommand = var_5

	var_1_1624(var_1_1623, var_1_1625, var_5)

	local var_1_1626 = arg_1_0.facade
	local var_1_1627 = var_2.registerCommand

	GAME = var_1_1625

	local var_1_1628 = var_1_1625.NEW_EDUCATE_TRACK

	NewEducateTrackCommand = var_5

	var_1_1627(var_1_1626, var_1_1628, var_5)

	local var_1_1629 = arg_1_0.facade
	local var_1_1630 = var_2.registerCommand

	GAME = var_1_1628

	local var_1_1631 = var_1_1628.NEW_EDUCATE_REFRESH_SHOP

	NewEducateRefreshShopCommand = var_5

	var_1_1630(var_1_1629, var_1_1631, var_5)

	local var_1_1632 = arg_1_0.facade
	local var_1_1633 = var_2.registerCommand

	GAME = var_1_1631

	local var_1_1634 = var_1_1631.NEW_EDUCATE_REQUEST_CHOICES

	NewEducateRequestChoicesCommand = var_5

	var_1_1633(var_1_1632, var_1_1634, var_5)

	local var_1_1635 = arg_1_0.facade
	local var_1_1636 = var_2.registerCommand

	GAME = var_1_1634

	local var_1_1637 = var_1_1634.NEW_EDUCATE_GIVE_UP_CHOICE

	NewEducateGiveUpChoiceCommand = var_5

	var_1_1636(var_1_1635, var_1_1637, var_5)

	local var_1_1638 = arg_1_0.facade
	local var_1_1639 = var_2.registerCommand

	GAME = var_1_1637

	local var_1_1640 = var_1_1637.NEW_EDUCATE_MAKE_CHOICE

	NewEducateMakeChoiceCommand = var_5

	var_1_1639(var_1_1638, var_1_1640, var_5)

	local var_1_1641 = arg_1_0.facade
	local var_1_1642 = var_2.registerCommand

	GAME = var_1_1640

	local var_1_1643 = var_1_1640.NEW_EDUCATE_REFRESH_CHOICE

	NewEducateRefreshChoiceCommand = var_5

	var_1_1642(var_1_1641, var_1_1643, var_5)

	local var_1_1644 = arg_1_0.facade
	local var_1_1645 = var_2.registerCommand

	GAME = var_1_1643

	local var_1_1646 = var_1_1643.NEW_EDUCATE_REPLACE_TAROT

	NewEducateReplaceTarotCommand = var_5

	var_1_1645(var_1_1644, var_1_1646, var_5)

	local var_1_1647 = arg_1_0.facade
	local var_1_1648 = var_2.registerCommand

	GAME = var_1_1646

	local var_1_1649 = var_1_1646.NEW_EDUCATE_GIVE_UP_ENTRY_UP

	NewEducateGiveUpEntryUpCommand = var_5

	var_1_1648(var_1_1647, var_1_1649, var_5)

	local var_1_1650 = arg_1_0.facade
	local var_1_1651 = var_2.registerCommand

	GAME = var_1_1649

	local var_1_1652 = var_1_1649.NEW_EDUCATE_UPGRADE_ENTRY

	NewEducateUpgradeEntryCommand = var_5

	var_1_1651(var_1_1650, var_1_1652, var_5)

	local var_1_1653 = arg_1_0.facade
	local var_1_1654 = var_2.registerCommand

	GAME = var_1_1652

	local var_1_1655 = var_1_1652.NEW_EDUCATE_GET_RANK

	NewEducateGetRankCommand = var_5

	var_1_1654(var_1_1653, var_1_1655, var_5)

	local var_1_1656 = arg_1_0.facade
	local var_1_1657 = var_2.registerCommand

	GAME = var_1_1655

	local var_1_1658 = var_1_1655.SINGLE_EVENT_TRIGGER

	SingleEventTriggerCommand = var_5

	var_1_1657(var_1_1656, var_1_1658, var_5)

	local var_1_1659 = arg_1_0.facade
	local var_1_1660 = var_2.registerCommand

	GAME = var_1_1658

	local var_1_1661 = var_1_1658.SINGLE_EVENT_REFRESH

	SingleEventRefreshCommand = var_5

	var_1_1660(var_1_1659, var_1_1661, var_5)

	local var_1_1662 = arg_1_0.facade
	local var_1_1663 = var_2.registerCommand

	GAME = var_1_1661

	local var_1_1664 = var_1_1661.APARTMENT_ROOM_UNLOCK

	ApartmentRoomUnlockCommand = var_5

	var_1_1663(var_1_1662, var_1_1664, var_5)

	local var_1_1665 = arg_1_0.facade
	local var_1_1666 = var_2.registerCommand

	GAME = var_1_1664

	local var_1_1667 = var_1_1664.APARTMENT_ROOM_INVITE_UNLOCK

	ApartmentRoomInviteUnlockCommand = var_5

	var_1_1666(var_1_1665, var_1_1667, var_5)

	local var_1_1668 = arg_1_0.facade
	local var_1_1669 = var_2.registerCommand

	GAME = var_1_1667

	local var_1_1670 = var_1_1667.APARTMENT_TRIGGER_FAVOR

	ApartmentTriggerFavorCommand = var_5

	var_1_1669(var_1_1668, var_1_1670, var_5)

	local var_1_1671 = arg_1_0.facade
	local var_1_1672 = var_2.registerCommand

	GAME = var_1_1670

	local var_1_1673 = var_1_1670.APARTMENT_LEVEL_UP

	ApartmentLevelUpCommand = var_5

	var_1_1672(var_1_1671, var_1_1673, var_5)

	local var_1_1674 = arg_1_0.facade
	local var_1_1675 = var_2.registerCommand

	GAME = var_1_1673

	local var_1_1676 = var_1_1673.APARTMENT_GIVE_GIFT

	ApartmentGiveGiftCommand = var_5

	var_1_1675(var_1_1674, var_1_1676, var_5)

	local var_1_1677 = arg_1_0.facade
	local var_1_1678 = var_2.registerCommand

	GAME = var_1_1676

	local var_1_1679 = var_1_1676.APARTMENT_REPLACE_FURNITURE

	ApartmentReplaceFurnitureCommand = var_5

	var_1_1678(var_1_1677, var_1_1679, var_5)

	local var_1_1680 = arg_1_0.facade
	local var_1_1681 = var_2.registerCommand

	GAME = var_1_1679

	local var_1_1682 = var_1_1679.APARTMENT_CHANGE_SKIN

	ApartmentChangeSkinCommand = var_5

	var_1_1681(var_1_1680, var_1_1682, var_5)

	local var_1_1683 = arg_1_0.facade
	local var_1_1684 = var_2.registerCommand

	GAME = var_1_1682

	local var_1_1685 = var_1_1682.APARTMENT_DO_TALK

	ApartmentDoTalkCommand = var_5

	var_1_1684(var_1_1683, var_1_1685, var_5)

	local var_1_1686 = arg_1_0.facade
	local var_1_1687 = var_2.registerCommand

	GAME = var_1_1685

	local var_1_1688 = var_1_1685.APARTMENT_COLLECTION_ITEM

	ApartmentCollectionItemCommand = var_5

	var_1_1687(var_1_1686, var_1_1688, var_5)

	local var_1_1689 = arg_1_0.facade
	local var_1_1690 = var_2.registerCommand

	GAME = var_1_1688

	local var_1_1691 = var_1_1688.APARTMENT_TRACK

	Dorm3dTrackCommand = var_5

	var_1_1690(var_1_1689, var_1_1691, var_5)

	local var_1_1692 = arg_1_0.facade
	local var_1_1693 = var_2.registerCommand

	GAME = var_1_1691

	local var_1_1694 = var_1_1691.SELECT_DORM_ENTER

	SelectDorm3dEnterCommand = var_5

	var_1_1693(var_1_1692, var_1_1694, var_5)

	local var_1_1695 = arg_1_0.facade
	local var_1_1696 = var_2.registerCommand

	GAME = var_1_1694

	local var_1_1697 = var_1_1694.DORM_SET_CALL

	DormSetCallCommand = var_5

	var_1_1696(var_1_1695, var_1_1697, var_5)

	local var_1_1698 = arg_1_0.facade
	local var_1_1699 = var_2.registerCommand

	GAME = var_1_1697

	local var_1_1700 = var_1_1697.APARTMENT_INS_OP

	ApartmentInstagramOpCommand = var_5

	var_1_1699(var_1_1698, var_1_1700, var_5)

	local var_1_1701 = arg_1_0.facade
	local var_1_1702 = var_2.registerCommand

	GAME = var_1_1700

	local var_1_1703 = var_1_1700.APARTMENT_CHAT_OP

	Dorm3dChatCommand = var_5

	var_1_1702(var_1_1701, var_1_1703, var_5)

	local var_1_1704 = arg_1_0.facade
	local var_1_1705 = var_2.registerCommand

	GAME = var_1_1703

	local var_1_1706 = var_1_1703.DORM_RECORD_VISIT

	Dorm3dRecordVisitCommand = var_5

	var_1_1705(var_1_1704, var_1_1706, var_5)

	local var_1_1707 = arg_1_0.facade
	local var_1_1708 = var_2.registerCommand

	GAME = var_1_1706

	local var_1_1709 = var_1_1706.APARTMENT_SKIN_PART_HIDDEN

	ApartmentSkinPartHiddenCommand = var_5

	var_1_1708(var_1_1707, var_1_1709, var_5)

	local var_1_1710 = arg_1_0.facade
	local var_1_1711 = var_2.registerCommand

	GAME = var_1_1709

	local var_1_1712 = var_1_1709.DORM3D_INS_PHONE_OP

	Dorm3dInsPhoneOpCommand = var_5

	var_1_1711(var_1_1710, var_1_1712, var_5)

	local var_1_1713 = arg_1_0.facade
	local var_1_1714 = var_2.registerCommand

	GAME = var_1_1712

	local var_1_1715 = var_1_1712.ISLAND_UPGRADE

	UpgradeIslandCommand = var_5

	var_1_1714(var_1_1713, var_1_1715, var_5)

	local var_1_1716 = arg_1_0.facade
	local var_1_1717 = var_2.registerCommand

	GAME = var_1_1715

	local var_1_1718 = var_1_1715.ISLAND_SET_NAME

	SetIslandNameCommand = var_5

	var_1_1717(var_1_1716, var_1_1718, var_5)

	local var_1_1719 = arg_1_0.facade
	local var_1_1720 = var_2.registerCommand

	GAME = var_1_1718

	local var_1_1721 = var_1_1718.ISLAND_SET_MANIFESTO

	SetIslandSetManifestoCommand = var_5

	var_1_1720(var_1_1719, var_1_1721, var_5)

	local var_1_1722 = arg_1_0.facade
	local var_1_1723 = var_2.registerCommand

	GAME = var_1_1721

	local var_1_1724 = var_1_1721.ISLAND_PROSPERITY_AWARD

	GetIslandProsperityAwardCommand = var_5

	var_1_1723(var_1_1722, var_1_1724, var_5)

	local var_1_1725 = arg_1_0.facade
	local var_1_1726 = var_2.registerCommand

	GAME = var_1_1724

	local var_1_1727 = var_1_1724.ISLAND_UPGRADE_INVENTORY

	UpgradeIslandInventoryCommand = var_5

	var_1_1726(var_1_1725, var_1_1727, var_5)

	local var_1_1728 = arg_1_0.facade
	local var_1_1729 = var_2.registerCommand

	GAME = var_1_1727

	local var_1_1730 = var_1_1727.ISLAND_GET_ORDER_EXP_AWARD

	GetIslandOrderExpAwardCommand = var_5

	var_1_1729(var_1_1728, var_1_1730, var_5)

	local var_1_1731 = arg_1_0.facade
	local var_1_1732 = var_2.registerCommand

	GAME = var_1_1730

	local var_1_1733 = var_1_1730.ISLAND_SUBMIT_ORDER

	IslandSubmitOrderCommand = var_5

	var_1_1732(var_1_1731, var_1_1733, var_5)

	local var_1_1734 = arg_1_0.facade
	local var_1_1735 = var_2.registerCommand

	GAME = var_1_1733

	local var_1_1736 = var_1_1733.ISLAND_REPLACE_ORDER

	IslandReplaceOrderCommand = var_5

	var_1_1735(var_1_1734, var_1_1736, var_5)

	local var_1_1737 = arg_1_0.facade
	local var_1_1738 = var_2.registerCommand

	GAME = var_1_1736

	local var_1_1739 = var_1_1736.ISLAND_USE_ITEM

	IslandUseItemCommand = var_5

	var_1_1738(var_1_1737, var_1_1739, var_5)

	local var_1_1740 = arg_1_0.facade
	local var_1_1741 = var_2.registerCommand

	GAME = var_1_1739

	local var_1_1742 = var_1_1739.ISLAND_GET_RANDOM_REFRESH_TASK

	GetIslandTaskRandomRefreshCommand = var_5

	var_1_1741(var_1_1740, var_1_1742, var_5)

	local var_1_1743 = arg_1_0.facade
	local var_1_1744 = var_2.registerCommand

	GAME = var_1_1742

	local var_1_1745 = var_1_1742.ISLAND_ACCEPT_TASK

	IslandAcceptTaskCommand = var_5

	var_1_1744(var_1_1743, var_1_1745, var_5)

	local var_1_1746 = arg_1_0.facade
	local var_1_1747 = var_2.registerCommand

	GAME = var_1_1745

	local var_1_1748 = var_1_1745.ISLAND_SUBMIT_TASK

	IslandSubmitTaskCommand = var_5

	var_1_1747(var_1_1746, var_1_1748, var_5)

	local var_1_1749 = arg_1_0.facade
	local var_1_1750 = var_2.registerCommand

	GAME = var_1_1748

	local var_1_1751 = var_1_1748.ISLAND_SUBMIT_TASK_ONE_STEP

	IslandSubmitTaskOneStepCommand = var_5

	var_1_1750(var_1_1749, var_1_1751, var_5)

	local var_1_1752 = arg_1_0.facade
	local var_1_1753 = var_2.registerCommand

	GAME = var_1_1751

	local var_1_1754 = var_1_1751.ISLAND_UPDATE_TASK

	IslandUpdateTaskCommand = var_5

	var_1_1753(var_1_1752, var_1_1754, var_5)

	local var_1_1755 = arg_1_0.facade
	local var_1_1756 = var_2.registerCommand

	GAME = var_1_1754

	local var_1_1757 = var_1_1754.ISLAND_SET_TRACE_TASK

	SetIslandTraceTaskCommand = var_5

	var_1_1756(var_1_1755, var_1_1757, var_5)

	local var_1_1758 = arg_1_0.facade
	local var_1_1759 = var_2.registerCommand

	GAME = var_1_1757

	local var_1_1760 = var_1_1757.ISLAND_RESET_SEASON

	IslandResetSeasonCommand = var_5

	var_1_1759(var_1_1758, var_1_1760, var_5)

	local var_1_1761 = arg_1_0.facade
	local var_1_1762 = var_2.registerCommand

	GAME = var_1_1760

	local var_1_1763 = var_1_1760.ISLAND_GET_SEASON_PT_AWARD

	IslandGetSeasonPtAwardCommand = var_5

	var_1_1762(var_1_1761, var_1_1763, var_5)

	local var_1_1764 = arg_1_0.facade
	local var_1_1765 = var_2.registerCommand

	GAME = var_1_1763

	local var_1_1766 = var_1_1763.ISLAND_CONVERT_SEASON_PT

	IslandConvertSeasonPtCommand = var_5

	var_1_1765(var_1_1764, var_1_1766, var_5)

	local var_1_1767 = arg_1_0.facade
	local var_1_1768 = var_2.registerCommand

	GAME = var_1_1766

	local var_1_1769 = var_1_1766.ISLAND_GET_SEASON_RANK

	IslandGetSeasonRankCommand = var_5

	var_1_1768(var_1_1767, var_1_1769, var_5)

	local var_1_1770 = arg_1_0.facade
	local var_1_1771 = var_2.registerCommand

	GAME = var_1_1769

	local var_1_1772 = var_1_1769.ISLAND_OPEN_RESTAURANT

	IslandOpenRestaurantCommand = var_5

	var_1_1771(var_1_1770, var_1_1772, var_5)

	local var_1_1773 = arg_1_0.facade
	local var_1_1774 = var_2.registerCommand

	GAME = var_1_1772

	local var_1_1775 = var_1_1772.ISLAND_CLOSE_RESTAURANT

	IslandCloseRestaurantCommand = var_5

	var_1_1774(var_1_1773, var_1_1775, var_5)

	local var_1_1776 = arg_1_0.facade
	local var_1_1777 = var_2.registerCommand

	GAME = var_1_1775

	local var_1_1778 = var_1_1775.ISLAND_GET_ACHV_AWARD

	IslandGetAchvAwardCommand = var_5

	var_1_1777(var_1_1776, var_1_1778, var_5)

	local var_1_1779 = arg_1_0.facade
	local var_1_1780 = var_2.registerCommand

	GAME = var_1_1778

	local var_1_1781 = var_1_1778.ISLAND_UPDATE_ACHV

	IslandUpdateAchvCommand = var_5

	var_1_1780(var_1_1779, var_1_1781, var_5)

	local var_1_1782 = arg_1_0.facade
	local var_1_1783 = var_2.registerCommand

	GAME = var_1_1781

	local var_1_1784 = var_1_1781.ISLAND_GET_CARD_DATA

	IslandGetCardDataCommand = var_5

	var_1_1783(var_1_1782, var_1_1784, var_5)

	local var_1_1785 = arg_1_0.facade
	local var_1_1786 = var_2.registerCommand

	GAME = var_1_1784

	local var_1_1787 = var_1_1784.ISLAND_SET_CARD_PHOTO

	IslandSetCardPhotoCommand = var_5

	var_1_1786(var_1_1785, var_1_1787, var_5)

	local var_1_1788 = arg_1_0.facade
	local var_1_1789 = var_2.registerCommand

	GAME = var_1_1787

	local var_1_1790 = var_1_1787.ISLAND_SET_CARD_WORD

	IslandSetCardWordCommand = var_5

	var_1_1789(var_1_1788, var_1_1790, var_5)

	local var_1_1791 = arg_1_0.facade
	local var_1_1792 = var_2.registerCommand

	GAME = var_1_1790

	local var_1_1793 = var_1_1790.ISLAND_SET_CARD_ACHVS

	IslandSetCardAchvsCommand = var_5

	var_1_1792(var_1_1791, var_1_1793, var_5)

	local var_1_1794 = arg_1_0.facade
	local var_1_1795 = var_2.registerCommand

	GAME = var_1_1793

	local var_1_1796 = var_1_1793.ISLAND_GIVE_CARD_LIKE

	IslandGiveCardLikeCommand = var_5

	var_1_1795(var_1_1794, var_1_1796, var_5)

	local var_1_1797 = arg_1_0.facade
	local var_1_1798 = var_2.registerCommand

	GAME = var_1_1796

	local var_1_1799 = var_1_1796.ISLAND_GIVE_CARD_LABEL

	IslandGiveCardLabelCommand = var_5

	var_1_1798(var_1_1797, var_1_1799, var_5)

	local var_1_1800 = arg_1_0.facade
	local var_1_1801 = var_2.registerCommand

	GAME = var_1_1799

	local var_1_1802 = var_1_1799.ISLAND_SETTING_FLAG

	IslandSettingFlagCommand = var_5

	var_1_1801(var_1_1800, var_1_1802, var_5)

	local var_1_1803 = arg_1_0.facade
	local var_1_1804 = var_2.registerCommand

	GAME = var_1_1802

	local var_1_1805 = var_1_1802.ISLAND_UPDATE_ILLUSTRATION

	IslandUpdateIllustrationCommand = var_5

	var_1_1804(var_1_1803, var_1_1805, var_5)

	local var_1_1806 = arg_1_0.facade
	local var_1_1807 = var_2.registerCommand

	GAME = var_1_1805

	local var_1_1808 = var_1_1805.ISLAND_UNLOCK_ILLUSTRATION

	IslandUnlockIllustrationCommand = var_5

	var_1_1807(var_1_1806, var_1_1808, var_5)

	local var_1_1809 = arg_1_0.facade
	local var_1_1810 = var_2.registerCommand

	GAME = var_1_1808

	local var_1_1811 = var_1_1808.ISLAND_GET_COLLECT_POINT

	IslandGetCollectPointCommand = var_5

	var_1_1810(var_1_1809, var_1_1811, var_5)

	local var_1_1812 = arg_1_0.facade
	local var_1_1813 = var_2.registerCommand

	GAME = var_1_1811

	local var_1_1814 = var_1_1811.ISLAND_GET_POINT_AWARD

	IslandGetPointAwardCommand = var_5

	var_1_1813(var_1_1812, var_1_1814, var_5)

	local var_1_1815 = arg_1_0.facade
	local var_1_1816 = var_2.registerCommand

	GAME = var_1_1814

	local var_1_1817 = var_1_1814.ISLAND_USE_TICKET

	IslandUseTicketCommand = var_5

	var_1_1816(var_1_1815, var_1_1817, var_5)

	local var_1_1818 = arg_1_0.facade
	local var_1_1819 = var_2.registerCommand

	GAME = var_1_1817

	local var_1_1820 = var_1_1817.ISLAND_REMOVE_EXPIRED_TICKET

	IslandRemoveExpiredTicketCommand = var_5

	var_1_1819(var_1_1818, var_1_1820, var_5)

	local var_1_1821 = arg_1_0.facade
	local var_1_1822 = var_2.registerCommand

	GAME = var_1_1820

	local var_1_1823 = var_1_1820.ISLAND_EXCHANGE_ITEM

	IslandExchangeItemCommand = var_5

	var_1_1822(var_1_1821, var_1_1823, var_5)

	local var_1_1824 = arg_1_0.facade
	local var_1_1825 = var_2.registerCommand

	GAME = var_1_1823

	local var_1_1826 = var_1_1823.ISLAND_SYNC_DATA

	IslandSyncCommand = var_5

	var_1_1825(var_1_1824, var_1_1826, var_5)

	local var_1_1827 = arg_1_0.facade
	local var_1_1828 = var_2.registerCommand

	GAME = var_1_1826

	local var_1_1829 = var_1_1826.ISLAND_SYNC_CONTROL

	IslandSyncControlCommand = var_5

	var_1_1828(var_1_1827, var_1_1829, var_5)

	local var_1_1830 = arg_1_0.facade
	local var_1_1831 = var_2.registerCommand

	GAME = var_1_1829

	local var_1_1832 = var_1_1829.ISLAND_RECONNECT

	IslandReconnectCommand = var_5

	var_1_1831(var_1_1830, var_1_1832, var_5)

	local var_1_1833 = arg_1_0.facade
	local var_1_1834 = var_2.registerCommand

	GAME = var_1_1832

	local var_1_1835 = var_1_1832.ISLAND_ENTER

	EnterIslandCommand = var_5

	var_1_1834(var_1_1833, var_1_1835, var_5)

	local var_1_1836 = arg_1_0.facade
	local var_1_1837 = var_2.registerCommand

	GAME = var_1_1835

	local var_1_1838 = var_1_1835.ISLAND_CHANGE_ENTER

	ChangeToIslandCommand = var_5

	var_1_1837(var_1_1836, var_1_1838, var_5)

	local var_1_1839 = arg_1_0.facade
	local var_1_1840 = var_2.registerCommand

	GAME = var_1_1838

	local var_1_1841 = var_1_1838.ISLAND_GET_DATA

	GetIslandDataCommand = var_5

	var_1_1840(var_1_1839, var_1_1841, var_5)

	local var_1_1842 = arg_1_0.facade
	local var_1_1843 = var_2.registerCommand

	GAME = var_1_1841

	local var_1_1844 = var_1_1841.ISLAND_EXIT

	ExitIslandCommand = var_5

	var_1_1843(var_1_1842, var_1_1844, var_5)

	local var_1_1845 = arg_1_0.facade
	local var_1_1846 = var_2.registerCommand

	GAME = var_1_1844

	local var_1_1847 = var_1_1844.ISLAND_ENTER_MAP

	EnterMapCommand = var_5

	var_1_1846(var_1_1845, var_1_1847, var_5)

	local var_1_1848 = arg_1_0.facade
	local var_1_1849 = var_2.registerCommand

	GAME = var_1_1847

	local var_1_1850 = var_1_1847.ISLAND_SET_ACCESS_TYPE

	IslandSetAccessAuthorityCommand = var_5

	var_1_1849(var_1_1848, var_1_1850, var_5)

	local var_1_1851 = arg_1_0.facade
	local var_1_1852 = var_2.registerCommand

	GAME = var_1_1850

	local var_1_1853 = var_1_1850.ISLAND_ACCESS_OP

	IslandAccessOpCommand = var_5

	var_1_1852(var_1_1851, var_1_1853, var_5)

	local var_1_1854 = arg_1_0.facade
	local var_1_1855 = var_2.registerCommand

	GAME = var_1_1853

	local var_1_1856 = var_1_1853.ISLAND_SAVE_AGORA

	IslandSaveAgoraCommand = var_5

	var_1_1855(var_1_1854, var_1_1856, var_5)

	local var_1_1857 = arg_1_0.facade
	local var_1_1858 = var_2.registerCommand

	GAME = var_1_1856

	local var_1_1859 = var_1_1856.ISLAND_SAVE_AGORA_THEME

	IslandSaveAgoraThemeCommand = var_5

	var_1_1858(var_1_1857, var_1_1859, var_5)

	local var_1_1860 = arg_1_0.facade
	local var_1_1861 = var_2.registerCommand

	GAME = var_1_1859

	local var_1_1862 = var_1_1859.ISLAND_DEL_AGORA_THEME

	IslandDelAgoraThemeCommand = var_5

	var_1_1861(var_1_1860, var_1_1862, var_5)

	local var_1_1863 = arg_1_0.facade
	local var_1_1864 = var_2.registerCommand

	GAME = var_1_1862

	local var_1_1865 = var_1_1862.ISLAND_UPGRADE_AGORA

	IslandUpgradeAgoraCommand = var_5

	var_1_1864(var_1_1863, var_1_1865, var_5)

	local var_1_1866 = arg_1_0.facade
	local var_1_1867 = var_2.registerCommand

	GAME = var_1_1865

	local var_1_1868 = var_1_1865.ISLAND_GET_OVERFLOW_ITEM

	IslandGetOverFlowItemCommand = var_5

	var_1_1867(var_1_1866, var_1_1868, var_5)

	local var_1_1869 = arg_1_0.facade
	local var_1_1870 = var_2.registerCommand

	GAME = var_1_1868

	local var_1_1871 = var_1_1868.ISLAND_SET_ORDER_TENDENCY

	IslandSetOrderTendencyCommand = var_5

	var_1_1870(var_1_1869, var_1_1871, var_5)

	local var_1_1872 = arg_1_0.facade
	local var_1_1873 = var_2.registerCommand

	GAME = var_1_1871

	local var_1_1874 = var_1_1871.ISLAND_SHOP_OP

	IslandShopOpCommand = var_5

	var_1_1873(var_1_1872, var_1_1874, var_5)

	local var_1_1875 = arg_1_0.facade
	local var_1_1876 = var_2.registerCommand

	GAME = var_1_1874

	local var_1_1877 = var_1_1874.ISLAND_UNLOCK_TECH

	IslandUnlockTechCommand = var_5

	var_1_1876(var_1_1875, var_1_1877, var_5)

	local var_1_1878 = arg_1_0.facade
	local var_1_1879 = var_2.registerCommand

	GAME = var_1_1877

	local var_1_1880 = var_1_1877.ISLAND_FINISH_TECH_IMMD

	IslandFinishTechImmdCommand = var_5

	var_1_1879(var_1_1878, var_1_1880, var_5)

	local var_1_1881 = arg_1_0.facade
	local var_1_1882 = var_2.registerCommand

	GAME = var_1_1880

	local var_1_1883 = var_1_1880.ISLAND_START_DELEGATION

	IslandStartDelegationCommand = var_5

	var_1_1882(var_1_1881, var_1_1883, var_5)

	local var_1_1884 = arg_1_0.facade
	local var_1_1885 = var_2.registerCommand

	GAME = var_1_1883

	local var_1_1886 = var_1_1883.ISLAND_FINISH_DELEGATION

	IslandFinishDelegationCommand = var_5

	var_1_1885(var_1_1884, var_1_1886, var_5)

	local var_1_1887 = arg_1_0.facade
	local var_1_1888 = var_2.registerCommand

	GAME = var_1_1886

	local var_1_1889 = var_1_1886.ISLAND_ADD_DELEGATION

	IslandAddDelegationCommand = var_5

	var_1_1888(var_1_1887, var_1_1889, var_5)

	local var_1_1890 = arg_1_0.facade
	local var_1_1891 = var_2.registerCommand

	GAME = var_1_1889

	local var_1_1892 = var_1_1889.ISLAND_GET_DELEGATION_AWARD

	IslandGetDelegationAwardCommand = var_5

	var_1_1891(var_1_1890, var_1_1892, var_5)

	local var_1_1893 = arg_1_0.facade
	local var_1_1894 = var_2.registerCommand

	GAME = var_1_1892

	local var_1_1895 = var_1_1892.ISLAND_START_COLLECT

	IslandSlotCollectCommand = var_5

	var_1_1894(var_1_1893, var_1_1895, var_5)

	local var_1_1896 = arg_1_0.facade
	local var_1_1897 = var_2.registerCommand

	GAME = var_1_1895

	local var_1_1898 = var_1_1895.ISLAND_START_HANDLE_PLANT

	IslandSlotHandPlantCommand = var_5

	var_1_1897(var_1_1896, var_1_1898, var_5)

	local var_1_1899 = arg_1_0.facade
	local var_1_1900 = var_2.registerCommand

	GAME = var_1_1898

	local var_1_1901 = var_1_1898.ISLAND_START_HANDLE_HARVEST

	IslandSlotHandPlantAwardCommand = var_5

	var_1_1900(var_1_1899, var_1_1901, var_5)

	local var_1_1902 = arg_1_0.facade
	local var_1_1903 = var_2.registerCommand

	GAME = var_1_1901

	local var_1_1904 = var_1_1901.ISLAND_STOP_HANDLE_PLANT_HALFWAY

	IslandStopHandPlantHalfWayCommand = var_5

	var_1_1903(var_1_1902, var_1_1904, var_5)

	local var_1_1905 = arg_1_0.facade
	local var_1_1906 = var_2.registerCommand

	GAME = var_1_1904

	local var_1_1907 = var_1_1904.ISLAND_SHIP_ORDER_OP

	IslandShipOrderOpCommand = var_5

	var_1_1906(var_1_1905, var_1_1907, var_5)

	local var_1_1908 = arg_1_0.facade
	local var_1_1909 = var_2.registerCommand

	GAME = var_1_1907

	local var_1_1910 = var_1_1907.ISLAND_USE_SHIP_EXP_BOOK

	IslandUseShipExpBookCommand = var_5

	var_1_1909(var_1_1908, var_1_1910, var_5)

	local var_1_1911 = arg_1_0.facade
	local var_1_1912 = var_2.registerCommand

	GAME = var_1_1910

	local var_1_1913 = var_1_1910.ISLAND_SHIP_BREAKOUT

	IslandShipBreakOutCommand = var_5

	var_1_1912(var_1_1911, var_1_1913, var_5)

	local var_1_1914 = arg_1_0.facade
	local var_1_1915 = var_2.registerCommand

	GAME = var_1_1913

	local var_1_1916 = var_1_1913.ISLNAD_SHIP_ATTR_UPGRADE

	IslandShipAttrUpgradeCommand = var_5

	var_1_1915(var_1_1914, var_1_1916, var_5)

	local var_1_1917 = arg_1_0.facade
	local var_1_1918 = var_2.registerCommand

	GAME = var_1_1916

	local var_1_1919 = var_1_1916.ISLNAD_SHIP_ATTR_LIMIT_UNLOCK

	IslandShipAttrLimitUnlockCommand = var_5

	var_1_1918(var_1_1917, var_1_1919, var_5)

	local var_1_1920 = arg_1_0.facade
	local var_1_1921 = var_2.registerCommand

	GAME = var_1_1919

	local var_1_1922 = var_1_1919.ISLAND_SHIP_SKILL_UPGRADE

	IslandShipSkillUpgradeCommand = var_5

	var_1_1921(var_1_1920, var_1_1922, var_5)

	local var_1_1923 = arg_1_0.facade
	local var_1_1924 = var_2.registerCommand

	GAME = var_1_1922

	local var_1_1925 = var_1_1922.ISLAND_INVITE_SHIP

	IslandInviteShipCommand = var_5

	var_1_1924(var_1_1923, var_1_1925, var_5)

	local var_1_1926 = arg_1_0.facade
	local var_1_1927 = var_2.registerCommand

	GAME = var_1_1925

	local var_1_1928 = var_1_1925.ISLAND_GIVE_GIFT

	IslandGiveGiftCommand = var_5

	var_1_1927(var_1_1926, var_1_1928, var_5)

	local var_1_1929 = arg_1_0.facade
	local var_1_1930 = var_2.registerCommand

	GAME = var_1_1928

	local var_1_1931 = var_1_1928.ISLAND_SIGN_IN

	IslandSignInCommand = var_5

	var_1_1930(var_1_1929, var_1_1931, var_5)

	local var_1_1932 = arg_1_0.facade
	local var_1_1933 = var_2.registerCommand

	GAME = var_1_1931

	local var_1_1934 = var_1_1931.ISLAND_SELECT_GIFT

	IslandSelectgiftCommand = var_5

	var_1_1933(var_1_1932, var_1_1934, var_5)

	local var_1_1935 = arg_1_0.facade
	local var_1_1936 = var_2.registerCommand

	GAME = var_1_1934

	local var_1_1937 = var_1_1934.ISLAND_SIGN_IN_INVITATION

	IslandSignInInvitationCommand = var_5

	var_1_1936(var_1_1935, var_1_1937, var_5)

	local var_1_1938 = arg_1_0.facade
	local var_1_1939 = var_2.registerCommand

	GAME = var_1_1937

	local var_1_1940 = var_1_1937.ISLAND_SIGN_SHARE_SIGNIN

	IslandShareSignInCommand = var_5

	var_1_1939(var_1_1938, var_1_1940, var_5)

	local var_1_1941 = arg_1_0.facade
	local var_1_1942 = var_2.registerCommand

	GAME = var_1_1940

	local var_1_1943 = var_1_1940.ISLAND_REFRESH_INVITECODE

	IslandRefreshInviteCodeCommand = var_5

	var_1_1942(var_1_1941, var_1_1943, var_5)

	local var_1_1944 = arg_1_0.facade
	local var_1_1945 = var_2.registerCommand

	GAME = var_1_1943

	local var_1_1946 = var_1_1943.ISLAND_START_WILD_GATHER

	IslandWildGatherCommand = var_5

	var_1_1945(var_1_1944, var_1_1946, var_5)

	local var_1_1947 = arg_1_0.facade
	local var_1_1948 = var_2.registerCommand

	GAME = var_1_1946

	local var_1_1949 = var_1_1946.ISLAND_START_WILD_GATHER_SIGN

	IslandWildGatherSignCommand = var_5

	var_1_1948(var_1_1947, var_1_1949, var_5)

	local var_1_1950 = arg_1_0.facade
	local var_1_1951 = var_2.registerCommand

	GAME = var_1_1949

	local var_1_1952 = var_1_1949.ISLAND_START_WILD_COLLECT

	IslandWildCollectCommand = var_5

	var_1_1951(var_1_1950, var_1_1952, var_5)

	local var_1_1953 = arg_1_0.facade
	local var_1_1954 = var_2.registerCommand

	GAME = var_1_1952

	local var_1_1955 = var_1_1952.ISLAND_START_WILD_COLLECT_SIGN

	IslandWildCollectSignCommand = var_5

	var_1_1954(var_1_1953, var_1_1955, var_5)

	local var_1_1956 = arg_1_0.facade
	local var_1_1957 = var_2.registerCommand

	GAME = var_1_1955

	local var_1_1958 = var_1_1955.ISLAND_GET_FRIEND_RESUME

	IslandGetFriendResumeCommand = var_5

	var_1_1957(var_1_1956, var_1_1958, var_5)

	local var_1_1959 = arg_1_0.facade
	local var_1_1960 = var_2.registerCommand

	GAME = var_1_1958

	local var_1_1961 = var_1_1958.ISLAND_GET_GIFT_TAG

	IslandGetGiftTagCommand = var_5

	var_1_1960(var_1_1959, var_1_1961, var_5)

	local var_1_1962 = arg_1_0.facade
	local var_1_1963 = var_2.registerCommand

	GAME = var_1_1961

	local var_1_1964 = var_1_1961.ISLAND_RECORD_LAST_EXIT_POS

	IslandRecordLastPositionCommmand = var_5

	var_1_1963(var_1_1962, var_1_1964, var_5)

	local var_1_1965 = arg_1_0.facade
	local var_1_1966 = var_2.registerCommand

	GAME = var_1_1964

	local var_1_1967 = var_1_1964.ISLAND_GET_AGORA_THEME

	IslandGetAgoraThemesCommand = var_5

	var_1_1966(var_1_1965, var_1_1967, var_5)

	local var_1_1968 = arg_1_0.facade
	local var_1_1969 = var_2.registerCommand

	GAME = var_1_1967

	local var_1_1970 = var_1_1967.ISLAND_CHANGE_DRESS

	IslandChangeDressupCommand = var_5

	var_1_1969(var_1_1968, var_1_1970, var_5)

	local var_1_1971 = arg_1_0.facade
	local var_1_1972 = var_2.registerCommand

	GAME = var_1_1970

	local var_1_1973 = var_1_1970.ISLAND_CHANGE_COMMANDER_DRESS

	IslandChangeCommanderDressupCommand = var_5

	var_1_1972(var_1_1971, var_1_1973, var_5)

	local var_1_1974 = arg_1_0.facade
	local var_1_1975 = var_2.registerCommand

	GAME = var_1_1973

	local var_1_1976 = var_1_1973.ISLAND_MORPH_FORM_CHANGE

	IslandMorphFormChangeCommand = var_5

	var_1_1975(var_1_1974, var_1_1976, var_5)

	local var_1_1977 = arg_1_0.facade
	local var_1_1978 = var_2.registerCommand

	GAME = var_1_1976

	local var_1_1979 = var_1_1976.ISLAND_SEND_ROLE_DRESS

	IslandSendRoleDressCommand = var_5

	var_1_1978(var_1_1977, var_1_1979, var_5)

	local var_1_1980 = arg_1_0.facade
	local var_1_1981 = var_2.registerCommand

	GAME = var_1_1979

	local var_1_1982 = var_1_1979.ISLAND_SEND_ROLE_DRESS_READ

	IslandSetRoleDressupReadCommand = var_5

	var_1_1981(var_1_1980, var_1_1982, var_5)

	local var_1_1983 = arg_1_0.facade
	local var_1_1984 = var_2.registerCommand

	GAME = var_1_1982

	local var_1_1985 = var_1_1982.ISLAND_SEND_COMMANDER_DRESS_READ

	IslandSetCommanderDressupReadCommand = var_5

	var_1_1984(var_1_1983, var_1_1985, var_5)

	local var_1_1986 = arg_1_0.facade
	local var_1_1987 = var_2.registerCommand

	GAME = var_1_1985

	local var_1_1988 = var_1_1985.ISLAND_BUY_ROLE_SKIN_COLOR

	IslandSendRoleSkinColorCommand = var_5

	var_1_1987(var_1_1986, var_1_1988, var_5)

	local var_1_1989 = arg_1_0.facade
	local var_1_1990 = var_2.registerCommand

	GAME = var_1_1988

	local var_1_1991 = var_1_1988.ISLAND_BUY_ROLE_DRESS_COLOR

	IslandSendDressColorCommand = var_5

	var_1_1990(var_1_1989, var_1_1991, var_5)

	local var_1_1992 = arg_1_0.facade
	local var_1_1993 = var_2.registerCommand

	GAME = var_1_1991

	local var_1_1994 = var_1_1991.ISLAND_ANIMATION_OP

	IslandAniamtionOpCommand = var_5

	var_1_1993(var_1_1992, var_1_1994, var_5)

	local var_1_1995 = arg_1_0.facade
	local var_1_1996 = var_2.registerCommand

	GAME = var_1_1994

	local var_1_1997 = var_1_1994.ISLAND_GET_NPC_ACTION_AWARD

	IslandGetNpcActionAwardCommand = var_5

	var_1_1996(var_1_1995, var_1_1997, var_5)

	local var_1_1998 = arg_1_0.facade
	local var_1_1999 = var_2.registerCommand

	GAME = var_1_1997

	local var_1_2000 = var_1_1997.ISLAND_SEND_CHAT

	IslandSendChatCommand = var_5

	var_1_1999(var_1_1998, var_1_2000, var_5)

	local var_1_2001 = arg_1_0.facade
	local var_1_2002 = var_2.registerCommand

	GAME = var_1_2000

	local var_1_2003 = var_1_2000.ISLAND_FOLLOWER_OP

	IslandFollowerOpCommand = var_5

	var_1_2002(var_1_2001, var_1_2003, var_5)

	local var_1_2004 = arg_1_0.facade
	local var_1_2005 = var_2.registerCommand

	GAME = var_1_2003

	local var_1_2006 = var_1_2003.ISLAND_REFRESH_SHIP_ORDER

	IslandRefreshShipOrderCommand = var_5

	var_1_2005(var_1_2004, var_1_2006, var_5)

	local var_1_2007 = arg_1_0.facade
	local var_1_2008 = var_2.registerCommand

	GAME = var_1_2006

	local var_1_2009 = var_1_2006.ISLAND_EXCHANGE_SHIP_ORDER

	IslandExchangeShipOrderCommand = var_5

	var_1_2008(var_1_2007, var_1_2009, var_5)

	local var_1_2010 = arg_1_0.facade
	local var_1_2011 = var_2.registerCommand

	GAME = var_1_2009

	local var_1_2012 = var_1_2009.ISLAND_RESET_SHIP_ORDER

	IslandResetShipOrderCommand = var_5

	var_1_2011(var_1_2010, var_1_2012, var_5)

	local var_1_2013 = arg_1_0.facade
	local var_1_2014 = var_2.registerCommand

	GAME = var_1_2012

	local var_1_2015 = var_1_2012.ISLAND_GO_FISHING

	IslandGoFishingCommand = var_5

	var_1_2014(var_1_2013, var_1_2015, var_5)

	local var_1_2016 = arg_1_0.facade
	local var_1_2017 = var_2.registerCommand

	GAME = var_1_2015

	local var_1_2018 = var_1_2015.ISLAND_FISHING_REUSLT

	IslandFishingResultCommand = var_5

	var_1_2017(var_1_2016, var_1_2018, var_5)

	local var_1_2019 = arg_1_0.facade
	local var_1_2020 = var_2.registerCommand

	GAME = var_1_2018

	local var_1_2021 = var_1_2018.ISLAND_EXCHANGE_LURE

	IslandExchangeLureCommand = var_5

	var_1_2020(var_1_2019, var_1_2021, var_5)

	local var_1_2022 = arg_1_0.facade
	local var_1_2023 = var_2.registerCommand

	GAME = var_1_2021

	local var_1_2024 = var_1_2021.ISLAND_TRADE

	IslandTradeCommand = var_5

	var_1_2023(var_1_2022, var_1_2024, var_5)

	local var_1_2025 = arg_1_0.facade
	local var_1_2026 = var_2.registerCommand

	GAME = var_1_2024

	local var_1_2027 = var_1_2024.ISLAND_GET_FRIEND_TRADE_RANK

	IslandGetFriendTradeRankCommand = var_5

	var_1_2026(var_1_2025, var_1_2027, var_5)

	local var_1_2028 = arg_1_0.facade
	local var_1_2029 = var_2.registerCommand

	GAME = var_1_2027

	local var_1_2030 = var_1_2027.ISLAND_INVITE_TRADE

	IslandInviteTradeCommand = var_5

	var_1_2029(var_1_2028, var_1_2030, var_5)

	local var_1_2031 = arg_1_0.facade
	local var_1_2032 = var_2.registerCommand

	GAME = var_1_2030

	local var_1_2033 = var_1_2030.ISLAND_TAKE_AUTO_COLLECTION

	IslandAutomaticCollectionCommand = var_5

	var_1_2032(var_1_2031, var_1_2033, var_5)

	local var_1_2034 = arg_1_0.facade
	local var_1_2035 = var_2.registerCommand

	GAME = var_1_2033

	local var_1_2036 = var_1_2033.ISLAND_GET_AUTO_COLLECTION_DATA

	IslandGetAutoCollectionCommand = var_5

	var_1_2035(var_1_2034, var_1_2036, var_5)

	local var_1_2037 = arg_1_0.facade
	local var_1_2038 = var_2.registerCommand

	GAME = var_1_2036

	local var_1_2039 = var_1_2036.ISLAND_CHEATER_CHANGE_VIEW_DRESSID

	IslandChangeViewDressCommand = var_5

	var_1_2038(var_1_2037, var_1_2039, var_5)

	local var_1_2040 = arg_1_0.facade
	local var_1_2041 = var_2.registerCommand

	GAME = var_1_2039

	local var_1_2042 = var_1_2039.ACTIVITY_DRAW_AWARD_OPERATION

	ActivityDrawAwardCommand = var_5

	var_1_2041(var_1_2040, var_1_2042, var_5)

	local var_1_2043 = arg_1_0.facade
	local var_1_2044 = var_2.registerCommand

	GAME = var_1_2042

	local var_1_2045 = var_1_2042.COMMANDER_MANUAL_OP

	CommanderManualCommand = var_5

	var_1_2044(var_1_2043, var_1_2045, var_5)

	local var_1_2046 = arg_1_0.facade
	local var_1_2047 = var_2.registerCommand

	GAME = var_1_2045

	local var_1_2048 = var_1_2045.CITY_REBUILD

	CityRebuildCommand = var_5

	var_1_2047(var_1_2046, var_1_2048, var_5)

	local var_1_2049 = arg_1_0.facade
	local var_1_2050 = var_2.registerCommand

	GAME = var_1_2048

	local var_1_2051 = var_1_2048.LOVE_LETTER_LEVEL_UP

	LoveLetterLevelUpCommand = var_5

	var_1_2050(var_1_2049, var_1_2051, var_5)

	local var_1_2052 = arg_1_0.facade
	local var_1_2053 = var_2.registerCommand

	GAME = var_1_2051

	local var_1_2054 = var_1_2051.GET_ALL_LOVE_LETTER_DATA

	GetAllLoveLetterLevelDataCommand = var_5

	var_1_2053(var_1_2052, var_1_2054, var_5)

	local var_1_2055 = arg_1_0.facade
	local var_1_2056 = var_2.registerCommand

	GAME = var_1_2054

	local var_1_2057 = var_1_2054.UNLOCK_LOVE_LETTER

	UnlockLoveLetterCommand = var_5

	var_1_2056(var_1_2055, var_1_2057, var_5)

	local var_1_2058 = arg_1_0.facade
	local var_1_2059 = var_2.registerCommand

	GAME = var_1_2057

	local var_1_2060 = var_1_2057.GET_LOVE_LETTER_REWARD

	GetLoveLetterLevelRewardCommand = var_5

	var_1_2059(var_1_2058, var_1_2060, var_5)

	local var_1_2061 = arg_1_0.facade
	local var_1_2062 = var_2.registerCommand

	GAME = var_1_2060

	local var_1_2063 = var_1_2060.REALIZE_LOVE_LETTER_GIFT

	RealizeLoveLetterGiftCommand = var_5

	var_1_2062(var_1_2061, var_1_2063, var_5)

	local var_1_2064 = arg_1_0.facade
	local var_1_2065 = var_2.registerCommand

	GAME = var_1_2063

	local var_1_2066 = var_1_2063.REQUEST_LOVE_LETTER_TEXT

	RequestLoveLetterContentCommand = var_5

	var_1_2065(var_1_2064, var_1_2066, var_5)

	local var_1_2067 = arg_1_0.facade
	local var_1_2068 = var_2.registerCommand

	GAME = var_1_2066

	local var_1_2069 = var_1_2066.ACCEPT_LOVE_LETTER_MAIL

	AcceptLoveLetterMailCommand = var_5

	var_1_2068(var_1_2067, var_1_2069, var_5)

	local var_1_2070 = arg_1_0.facade
	local var_1_2071 = var_2.registerCommand

	GAME = var_1_2069

	local var_1_2072 = var_1_2069.PLAY_ROOM_REFRESH_ROOM

	PlayRoomRefreshRoomCommand = var_5

	var_1_2071(var_1_2070, var_1_2072, var_5)

	local var_1_2073 = arg_1_0.facade
	local var_1_2074 = var_2.registerCommand

	GAME = var_1_2072

	local var_1_2075 = var_1_2072.PLAY_ROOM_REFRESH_ROOM_INFO

	PlayRoomRefreshRoomInfoCommand = var_5

	var_1_2074(var_1_2073, var_1_2075, var_5)

	local var_1_2076 = arg_1_0.facade
	local var_1_2077 = var_2.registerCommand

	GAME = var_1_2075

	local var_1_2078 = var_1_2075.PLAY_ROOM_CREATE_ROOM

	PlayRoomCreateRoomCommand = var_5

	var_1_2077(var_1_2076, var_1_2078, var_5)

	local var_1_2079 = arg_1_0.facade
	local var_1_2080 = var_2.registerCommand

	GAME = var_1_2078

	local var_1_2081 = var_1_2078.PLAY_ROOM_SWITCH_ROOM_TYPE

	PlayRoomSwitchRoomTypeCommand = var_5

	var_1_2080(var_1_2079, var_1_2081, var_5)

	local var_1_2082 = arg_1_0.facade
	local var_1_2083 = var_2.registerCommand

	GAME = var_1_2081

	local var_1_2084 = var_1_2081.PLAY_ROOM_JOIN_ROOM

	PlayRoomJoinRoomCommand = var_5

	var_1_2083(var_1_2082, var_1_2084, var_5)

	local var_1_2085 = arg_1_0.facade
	local var_1_2086 = var_2.registerCommand

	GAME = var_1_2084

	local var_1_2087 = var_1_2084.PLAY_ROOM_EXIT_ROOM

	PlayRoomExitRoomCommand = var_5

	var_1_2086(var_1_2085, var_1_2087, var_5)

	local var_1_2088 = arg_1_0.facade
	local var_1_2089 = var_2.registerCommand

	GAME = var_1_2087

	local var_1_2090 = var_1_2087.PLAY_ROOM_READY

	PlayRoomReadyCommand = var_5

	var_1_2089(var_1_2088, var_1_2090, var_5)

	local var_1_2091 = arg_1_0.facade
	local var_1_2092 = var_2.registerCommand

	GAME = var_1_2090

	local var_1_2093 = var_1_2090.PLAY_ROOM_SWITCH_VIEWER

	PlayRoomSwitchViewerCommand = var_5

	var_1_2092(var_1_2091, var_1_2093, var_5)

	local var_1_2094 = arg_1_0.facade
	local var_1_2095 = var_2.registerCommand

	GAME = var_1_2093

	local var_1_2096 = var_1_2093.PLAY_ROOM_KICK

	PlayRoomKickCommand = var_5

	var_1_2095(var_1_2094, var_1_2096, var_5)

	local var_1_2097 = arg_1_0.facade
	local var_1_2098 = var_2.registerCommand

	GAME = var_1_2096

	local var_1_2099 = var_1_2096.PLAY_ROOM_START_GAME

	PlayRoomStartGameCommand = var_5

	var_1_2098(var_1_2097, var_1_2099, var_5)

	local var_1_2100 = arg_1_0.facade
	local var_1_2101 = var_2.registerCommand

	GAME = var_1_2099

	local var_1_2102 = var_1_2099.PLAY_ROOM_INVITE

	PlayRoomInviteCommand = var_5

	var_1_2101(var_1_2100, var_1_2102, var_5)

	local var_1_2103 = arg_1_0.facade
	local var_1_2104 = var_2.registerCommand

	GAME = var_1_2102

	local var_1_2105 = var_1_2102.PLAY_ROOM_INVITE_REFUSE

	PlayRoomInviteRefuseCommand = var_5

	var_1_2104(var_1_2103, var_1_2105, var_5)

	local var_1_2106 = arg_1_0.facade
	local var_1_2107 = var_2.registerCommand

	GAME = var_1_2105

	local var_1_2108 = var_1_2105.PLAY_ROOM_MATCH_READY

	PlayRoomMatchReadyCommand = var_5

	var_1_2107(var_1_2106, var_1_2108, var_5)

	local var_1_2109 = arg_1_0.facade
	local var_1_2110 = var_2.registerCommand

	GAME = var_1_2108

	local var_1_2111 = var_1_2108.PLAY_ROOM_SEND_CHAT

	PlayRoomSendChatCommand = var_5

	var_1_2110(var_1_2109, var_1_2111, var_5)

	local var_1_2112 = arg_1_0.facade
	local var_1_2113 = var_2.registerCommand

	GAME = var_1_2111

	local var_1_2114 = var_1_2111.PLAY_ROOM_REFRESH_RANK

	PlayRoomRefreshRankCommand = var_5

	var_1_2113(var_1_2112, var_1_2114, var_5)

	local var_1_2115 = arg_1_0.facade
	local var_1_2116 = var_2.registerCommand

	GAME = var_1_2114

	local var_1_2117 = var_1_2114.PLAY_ROOM_LOAD_SCENE_COMPLETE

	PlayRoomSendSceneLoadCompleteCommand = var_5

	var_1_2116(var_1_2115, var_1_2117, var_5)

	local var_1_2118 = arg_1_0.facade
	local var_1_2119 = var_2.registerCommand

	GAME = var_1_2117

	local var_1_2120 = var_1_2117.PLAY_ROOM_QUICK_MATCH

	PlayRoomQuickMatchCommand = var_5

	var_1_2119(var_1_2118, var_1_2120, var_5)

	local var_1_2121 = arg_1_0.facade
	local var_1_2122 = var_2.registerCommand

	GAME = var_1_2120

	local var_1_2123 = var_1_2120.ISLAND_PLAYER_CHEATER_OPERATE

	IslandCheaterOperateCommand = var_5

	var_1_2122(var_1_2121, var_1_2123, var_5)

	local var_1_2124 = arg_1_0.facade
	local var_1_2125 = var_2.registerCommand

	GAME = var_1_2123

	local var_1_2126 = var_1_2123.ISLAND_CHEATER_START_SOLO_GAME

	IslandStartSoloGameCommand = var_5

	var_1_2125(var_1_2124, var_1_2126, var_5)

	local var_1_2127 = arg_1_0.facade
	local var_1_2128 = var_2.registerCommand

	GAME = var_1_2126

	local var_1_2129 = var_1_2126.ISLAND_CHEATER_END_SOLO_GAME

	IslandEndSoloGameCommand = var_5

	var_1_2128(var_1_2127, var_1_2129, var_5)

	local var_1_2130 = arg_1_0.facade
	local var_1_2131 = var_2.registerCommand

	GAME = var_1_2129

	local var_1_2132 = var_1_2129.ISLAND_PLAYER_CHEATER_CANCEL_DELEGATE

	IslandCheaterCancelDelegateCommand = var_5

	var_1_2131(var_1_2130, var_1_2132, var_5)

	local var_1_2133 = arg_1_0.facade
	local var_1_2134 = var_2.registerCommand

	GAME = var_1_2132

	local var_1_2135 = var_1_2132.ISLAND_CHEATER_RECONECTING

	IslandCheaterReconectCommand = var_5

	var_1_2134(var_1_2133, var_1_2135, var_5)

	local var_1_2136 = arg_1_0.facade
	local var_1_2137 = var_2.registerCommand

	GAME = var_1_2135

	local var_1_2138 = var_1_2135.UPDATE_LOADING_PIC

	UpdateLoadingPicCommand = var_5

	var_1_2137(var_1_2136, var_1_2138, var_5)

	local var_1_2139 = arg_1_0.facade
	local var_1_2140 = var_2.registerCommand

	GAME = var_1_2138

	local var_1_2141 = var_1_2138.AUCTION_GAME_INIT

	AuctionGameInitCommand = var_5

	var_1_2140(var_1_2139, var_1_2141, var_5)

	local var_1_2142 = arg_1_0.facade
	local var_1_2143 = var_2.registerCommand

	GAME = var_1_2141

	local var_1_2144 = var_1_2141.AUCTION_GAME_BID

	AuctionGameBidCommand = var_5

	var_1_2143(var_1_2142, var_1_2144, var_5)

	local var_1_2145 = arg_1_0.facade
	local var_1_2146 = var_2.registerCommand

	GAME = var_1_2144

	local var_1_2147 = var_1_2144.AUCTION_GAME_FORFEIT

	AuctionGameForfeitCommand = var_5

	var_1_2146(var_1_2145, var_1_2147, var_5)

	local var_1_2148 = arg_1_0.facade
	local var_1_2149 = var_2.registerCommand

	GAME = var_1_2147

	local var_1_2150 = var_1_2147.AUCTION_GAME_EVENT_SELECTED_ID

	AuctionGameEventSelectedIDCommand = var_5

	var_1_2149(var_1_2148, var_1_2150, var_5)

	local var_1_2151 = arg_1_0.facade
	local var_1_2152 = var_2.registerCommand

	GAME = var_1_2150

	local var_1_2153 = var_1_2150.AUCTION_GAME_EMOJI

	AuctionGameEmojiCommand = var_5

	var_1_2152(var_1_2151, var_1_2153, var_5)

	local var_1_2154 = arg_1_0.facade
	local var_1_2155 = var_2.registerCommand

	GAME = var_1_2153

	local var_1_2156 = var_1_2153.AUCTION_GAME_SWITCH_EMOJI

	AuctionGameSwitchEmojiCommand = var_5

	var_1_2155(var_1_2154, var_1_2156, var_5)

	local var_1_2157 = arg_1_0.facade
	local var_1_2158 = var_2.registerCommand

	GAME = var_1_2156

	local var_1_2159 = var_1_2156.AUCTION_GAME_SHOW_MATCH_WARNING_TIP

	AuctionGameShowMatchWarningTipCommand = var_5

	var_1_2158(var_1_2157, var_1_2159, var_5)

	local var_1_2160 = arg_1_0.facade
	local var_1_2161 = var_2.registerCommand

	GAME = var_1_2159

	local var_1_2162 = var_1_2159.AUCTION_GAME_MATCHING_RECONNECT

	AuctionGameMatchingReconnectCommand = var_5

	var_1_2161(var_1_2160, var_1_2162, var_5)

	local var_1_2163 = arg_1_0.facade
	local var_1_2164 = var_2.registerCommand

	GAME = var_1_2162

	local var_1_2165 = var_1_2162.AUCTION_GAME_PREORDER_BOX

	AuctionGamePreorderBoxCommand = var_5

	var_1_2164(var_1_2163, var_1_2165, var_5)

	local var_1_2166 = arg_1_0.facade
	local var_1_2167 = var_2.registerCommand

	GAME = var_1_2165

	local var_1_2168 = var_1_2165.AUCTION_GAME_OPEN_BOX

	AuctionGameOpenBoxCommand = var_5

	var_1_2167(var_1_2166, var_1_2168, var_5)

	local var_1_2169 = arg_1_0.facade
	local var_1_2170 = var_2.registerCommand

	GAME = var_1_2168

	local var_1_2171 = var_1_2168.AUCTION_GAME_GET_RELIEF

	AuctionGameGetReliefCommand = var_5

	var_1_2170(var_1_2169, var_1_2171, var_5)

	return
end

return var_0_1
