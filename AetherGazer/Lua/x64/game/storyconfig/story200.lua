return {
	Play100 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100
		arg_1_1.duration_ = 85.34

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A03"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.A03

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "A00"

			if arg_1_1.bgs_[var_4_16] == nil then
				local var_4_17 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_16)
				var_4_17.name = var_4_16
				var_4_17.transform.parent = arg_1_1.stage_.transform
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_16] = var_4_17
			end

			local var_4_18 = 1.2

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = manager.ui.mainCamera.transform.localPosition
				local var_4_20 = Vector3.New(0, 0, 10) + Vector3.New(var_4_19.x, var_4_19.y, 0)
				local var_4_21 = arg_1_1.bgs_.A00

				var_4_21.transform.localPosition = var_4_20
				var_4_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_22 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_22 and var_4_22.sprite then
					local var_4_23 = (var_4_21.transform.localPosition - var_4_19).z
					local var_4_24 = manager.ui.mainCameraCom_
					local var_4_25 = 2 * var_4_23 * Mathf.Tan(var_4_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_26 = var_4_25 * var_4_24.aspect
					local var_4_27 = var_4_22.sprite.bounds.size.x
					local var_4_28 = var_4_22.sprite.bounds.size.y
					local var_4_29 = var_4_26 / var_4_27
					local var_4_30 = var_4_25 / var_4_28
					local var_4_31 = var_4_30 < var_4_29 and var_4_29 or var_4_30

					var_4_21.transform.localScale = Vector3.New(var_4_31, var_4_31, 0)
				end

				for iter_4_2, iter_4_3 in pairs(arg_1_1.bgs_) do
					if iter_4_2 ~= "A00" then
						iter_4_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_32 = "A07a"

			if arg_1_1.bgs_[var_4_32] == nil then
				local var_4_33 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_33:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_32)
				var_4_33.name = var_4_32
				var_4_33.transform.parent = arg_1_1.stage_.transform
				var_4_33.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_32] = var_4_33
			end

			local var_4_34 = 3.9

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = manager.ui.mainCamera.transform.localPosition
				local var_4_36 = Vector3.New(0, 0, 10) + Vector3.New(var_4_35.x, var_4_35.y, 0)
				local var_4_37 = arg_1_1.bgs_.A07a

				var_4_37.transform.localPosition = var_4_36
				var_4_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_38 = var_4_37:GetComponent("SpriteRenderer")

				if var_4_38 and var_4_38.sprite then
					local var_4_39 = (var_4_37.transform.localPosition - var_4_35).z
					local var_4_40 = manager.ui.mainCameraCom_
					local var_4_41 = 2 * var_4_39 * Mathf.Tan(var_4_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_42 = var_4_41 * var_4_40.aspect
					local var_4_43 = var_4_38.sprite.bounds.size.x
					local var_4_44 = var_4_38.sprite.bounds.size.y
					local var_4_45 = var_4_42 / var_4_43
					local var_4_46 = var_4_41 / var_4_44
					local var_4_47 = var_4_46 < var_4_45 and var_4_45 or var_4_46

					var_4_37.transform.localScale = Vector3.New(var_4_47, var_4_47, 0)
				end

				for iter_4_4, iter_4_5 in pairs(arg_1_1.bgs_) do
					if iter_4_4 ~= "A07a" then
						iter_4_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_48 = "A04"

			if arg_1_1.bgs_[var_4_48] == nil then
				local var_4_49 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_49:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_48)
				var_4_49.name = var_4_48
				var_4_49.transform.parent = arg_1_1.stage_.transform
				var_4_49.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_48] = var_4_49
			end

			local var_4_50 = 6.83333333333333

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_51 = manager.ui.mainCamera.transform.localPosition
				local var_4_52 = Vector3.New(0, 0, 10) + Vector3.New(var_4_51.x, var_4_51.y, 0)
				local var_4_53 = arg_1_1.bgs_.A04

				var_4_53.transform.localPosition = var_4_52
				var_4_53.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_54 = var_4_53:GetComponent("SpriteRenderer")

				if var_4_54 and var_4_54.sprite then
					local var_4_55 = (var_4_53.transform.localPosition - var_4_51).z
					local var_4_56 = manager.ui.mainCameraCom_
					local var_4_57 = 2 * var_4_55 * Mathf.Tan(var_4_56.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_58 = var_4_57 * var_4_56.aspect
					local var_4_59 = var_4_54.sprite.bounds.size.x
					local var_4_60 = var_4_54.sprite.bounds.size.y
					local var_4_61 = var_4_58 / var_4_59
					local var_4_62 = var_4_57 / var_4_60
					local var_4_63 = var_4_62 < var_4_61 and var_4_61 or var_4_62

					var_4_53.transform.localScale = Vector3.New(var_4_63, var_4_63, 0)
				end

				for iter_4_6, iter_4_7 in pairs(arg_1_1.bgs_) do
					if iter_4_6 ~= "A04" then
						iter_4_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_64 = "A06"

			if arg_1_1.bgs_[var_4_64] == nil then
				local var_4_65 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_65:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_64)
				var_4_65.name = var_4_64
				var_4_65.transform.parent = arg_1_1.stage_.transform
				var_4_65.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_64] = var_4_65
			end

			local var_4_66 = 9.7

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_67 = manager.ui.mainCamera.transform.localPosition
				local var_4_68 = Vector3.New(0, 0, 10) + Vector3.New(var_4_67.x, var_4_67.y, 0)
				local var_4_69 = arg_1_1.bgs_.A06

				var_4_69.transform.localPosition = var_4_68
				var_4_69.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_70 = var_4_69:GetComponent("SpriteRenderer")

				if var_4_70 and var_4_70.sprite then
					local var_4_71 = (var_4_69.transform.localPosition - var_4_67).z
					local var_4_72 = manager.ui.mainCameraCom_
					local var_4_73 = 2 * var_4_71 * Mathf.Tan(var_4_72.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_74 = var_4_73 * var_4_72.aspect
					local var_4_75 = var_4_70.sprite.bounds.size.x
					local var_4_76 = var_4_70.sprite.bounds.size.y
					local var_4_77 = var_4_74 / var_4_75
					local var_4_78 = var_4_73 / var_4_76
					local var_4_79 = var_4_78 < var_4_77 and var_4_77 or var_4_78

					var_4_69.transform.localScale = Vector3.New(var_4_79, var_4_79, 0)
				end

				for iter_4_8, iter_4_9 in pairs(arg_1_1.bgs_) do
					if iter_4_8 ~= "A06" then
						iter_4_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_80 = "SA0102"

			if arg_1_1.bgs_[var_4_80] == nil then
				local var_4_81 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_81:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_80)
				var_4_81.name = var_4_80
				var_4_81.transform.parent = arg_1_1.stage_.transform
				var_4_81.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_80] = var_4_81
			end

			local var_4_82 = 13.0217532408734

			if var_4_82 < arg_1_1.time_ and arg_1_1.time_ <= var_4_82 + arg_4_0 then
				local var_4_83 = manager.ui.mainCamera.transform.localPosition
				local var_4_84 = Vector3.New(0, 0, 10) + Vector3.New(var_4_83.x, var_4_83.y, 0)
				local var_4_85 = arg_1_1.bgs_.SA0102

				var_4_85.transform.localPosition = var_4_84
				var_4_85.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_86 = var_4_85:GetComponent("SpriteRenderer")

				if var_4_86 and var_4_86.sprite then
					local var_4_87 = (var_4_85.transform.localPosition - var_4_83).z
					local var_4_88 = manager.ui.mainCameraCom_
					local var_4_89 = 2 * var_4_87 * Mathf.Tan(var_4_88.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_90 = var_4_89 * var_4_88.aspect
					local var_4_91 = var_4_86.sprite.bounds.size.x
					local var_4_92 = var_4_86.sprite.bounds.size.y
					local var_4_93 = var_4_90 / var_4_91
					local var_4_94 = var_4_89 / var_4_92
					local var_4_95 = var_4_94 < var_4_93 and var_4_93 or var_4_94

					var_4_85.transform.localScale = Vector3.New(var_4_95, var_4_95, 0)
				end

				for iter_4_10, iter_4_11 in pairs(arg_1_1.bgs_) do
					if iter_4_10 ~= "SA0102" then
						iter_4_11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_96 = "L01h"

			if arg_1_1.bgs_[var_4_96] == nil then
				local var_4_97 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_97:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_96)
				var_4_97.name = var_4_96
				var_4_97.transform.parent = arg_1_1.stage_.transform
				var_4_97.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_96] = var_4_97
			end

			local var_4_98 = 15.9666666666667

			if var_4_98 < arg_1_1.time_ and arg_1_1.time_ <= var_4_98 + arg_4_0 then
				local var_4_99 = manager.ui.mainCamera.transform.localPosition
				local var_4_100 = Vector3.New(0, 0, 10) + Vector3.New(var_4_99.x, var_4_99.y, 0)
				local var_4_101 = arg_1_1.bgs_.L01h

				var_4_101.transform.localPosition = var_4_100
				var_4_101.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_102 = var_4_101:GetComponent("SpriteRenderer")

				if var_4_102 and var_4_102.sprite then
					local var_4_103 = (var_4_101.transform.localPosition - var_4_99).z
					local var_4_104 = manager.ui.mainCameraCom_
					local var_4_105 = 2 * var_4_103 * Mathf.Tan(var_4_104.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_106 = var_4_105 * var_4_104.aspect
					local var_4_107 = var_4_102.sprite.bounds.size.x
					local var_4_108 = var_4_102.sprite.bounds.size.y
					local var_4_109 = var_4_106 / var_4_107
					local var_4_110 = var_4_105 / var_4_108
					local var_4_111 = var_4_110 < var_4_109 and var_4_109 or var_4_110

					var_4_101.transform.localScale = Vector3.New(var_4_111, var_4_111, 0)
				end

				for iter_4_12, iter_4_13 in pairs(arg_1_1.bgs_) do
					if iter_4_12 ~= "L01h" then
						iter_4_13.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_112 = "1066ui_tpose"

			if arg_1_1.actors_[var_4_112] == nil then
				local var_4_113 = Asset.Load("Char/" .. "1066ui_tpose")

				if not isNil(var_4_113) then
					local var_4_114 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_tpose"), arg_1_1.stage_.transform)

					var_4_114.name = var_4_112
					var_4_114.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_112] = var_4_114

					local var_4_115 = var_4_114:GetComponentInChildren(typeof(CharacterEffect))

					var_4_115.enabled = true

					local var_4_116 = GameObjectTools.GetOrAddComponent(var_4_114, typeof(DynamicBoneHelper))

					if var_4_116 then
						var_4_116:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_115.transform, false)

					arg_1_1.var_[var_4_112 .. "Animator"] = var_4_115.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_112 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_112 .. "LipSync"] = var_4_115.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_117 = arg_1_1.actors_["1066ui_tpose"].transform
			local var_4_118 = 0

			if var_4_118 < arg_1_1.time_ and arg_1_1.time_ <= var_4_118 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_tpose = var_4_117.localPosition
			end

			local var_4_119 = 0.001

			if var_4_118 <= arg_1_1.time_ and arg_1_1.time_ < var_4_118 + var_4_119 then
				local var_4_120 = (arg_1_1.time_ - var_4_118) / var_4_119
				local var_4_121 = Vector3.New(0, 100, 0)

				var_4_117.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_tpose, var_4_121, var_4_120)

				local var_4_122 = manager.ui.mainCamera.transform.position - var_4_117.position

				var_4_117.forward = Vector3.New(var_4_122.x, var_4_122.y, var_4_122.z)

				local var_4_123 = var_4_117.localEulerAngles

				var_4_123.z = 0
				var_4_123.x = 0
				var_4_117.localEulerAngles = var_4_123
			end

			if arg_1_1.time_ >= var_4_118 + var_4_119 and arg_1_1.time_ < var_4_118 + var_4_119 + arg_4_0 then
				var_4_117.localPosition = Vector3.New(0, 100, 0)

				local var_4_124 = manager.ui.mainCamera.transform.position - var_4_117.position

				var_4_117.forward = Vector3.New(var_4_124.x, var_4_124.y, var_4_124.z)

				local var_4_125 = var_4_117.localEulerAngles

				var_4_125.z = 0
				var_4_125.x = 0
				var_4_117.localEulerAngles = var_4_125
			end

			local var_4_126 = manager.ui.mainCamera.transform
			local var_4_127 = 0

			if var_4_127 < arg_1_1.time_ and arg_1_1.time_ <= var_4_127 + arg_4_0 then
				local var_4_128 = arg_1_1.var_.effectzhuanchangyewan1
				local var_4_129
				local var_4_130 = var_4_126

				if not var_4_128 then
					var_4_128 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), var_4_130)
					var_4_128.name = "zhuanchangyewan1"
					arg_1_1.var_.effectzhuanchangyewan1 = var_4_128
				else
					var_4_128.transform:SetParent(var_4_130)
				end

				var_4_128.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_128.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_131 = manager.ui.mainCamera.transform
			local var_4_132 = 1.2

			if var_4_132 < arg_1_1.time_ and arg_1_1.time_ <= var_4_132 + arg_4_0 then
				local var_4_133 = arg_1_1.var_.effectzhuanchangyewan2
				local var_4_134
				local var_4_135 = var_4_131

				if not var_4_133 then
					var_4_133 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), var_4_135)
					var_4_133.name = "zhuanchangyewan2"
					arg_1_1.var_.effectzhuanchangyewan2 = var_4_133
				else
					var_4_133.transform:SetParent(var_4_135)
				end

				var_4_133.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_133.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_136 = manager.ui.mainCamera.transform
			local var_4_137 = 1.2

			if var_4_137 < arg_1_1.time_ and arg_1_1.time_ <= var_4_137 + arg_4_0 then
				local var_4_138 = arg_1_1.var_.effectzhuanchangyewan1

				if var_4_138 then
					Object.Destroy(var_4_138)

					arg_1_1.var_.effectzhuanchangyewan1 = nil
				end
			end

			local var_4_139 = manager.ui.mainCamera.transform
			local var_4_140 = 2

			if var_4_140 < arg_1_1.time_ and arg_1_1.time_ <= var_4_140 + arg_4_0 then
				local var_4_141 = arg_1_1.var_.effectzhuanchangyewan2

				if var_4_141 then
					Object.Destroy(var_4_141)

					arg_1_1.var_.effectzhuanchangyewan2 = nil
				end
			end

			local var_4_142 = manager.ui.mainCamera.transform
			local var_4_143 = 2.7

			if var_4_143 < arg_1_1.time_ and arg_1_1.time_ <= var_4_143 + arg_4_0 then
				local var_4_144 = arg_1_1.var_.effectzhuanchangyewan3
				local var_4_145
				local var_4_146 = var_4_142

				if not var_4_144 then
					var_4_144 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_in_keep"), var_4_146)
					var_4_144.name = "zhuanchangyewan3"
					arg_1_1.var_.effectzhuanchangyewan3 = var_4_144
				else
					var_4_144.transform:SetParent(var_4_146)
				end

				var_4_144.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_144.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_147 = manager.ui.mainCamera.transform
			local var_4_148 = 3.9

			if var_4_148 < arg_1_1.time_ and arg_1_1.time_ <= var_4_148 + arg_4_0 then
				local var_4_149 = arg_1_1.var_.effectzhuanchangyewan4
				local var_4_150
				local var_4_151 = var_4_147

				if not var_4_149 then
					var_4_149 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_out"), var_4_151)
					var_4_149.name = "zhuanchangyewan4"
					arg_1_1.var_.effectzhuanchangyewan4 = var_4_149
				else
					var_4_149.transform:SetParent(var_4_151)
				end

				var_4_149.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_149.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_152 = manager.ui.mainCamera.transform
			local var_4_153 = 5.83333333333333

			if var_4_153 < arg_1_1.time_ and arg_1_1.time_ <= var_4_153 + arg_4_0 then
				local var_4_154 = arg_1_1.var_.effectkejizhuanchang1
				local var_4_155
				local var_4_156 = var_4_152

				if not var_4_154 then
					var_4_154 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_slow"), var_4_156)
					var_4_154.name = "kejizhuanchang1"
					arg_1_1.var_.effectkejizhuanchang1 = var_4_154
				else
					var_4_154.transform:SetParent(var_4_156)
				end

				var_4_154.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_154.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_157 = manager.ui.mainCamera.transform
			local var_4_158 = 8.83333333333333

			if var_4_158 < arg_1_1.time_ and arg_1_1.time_ <= var_4_158 + arg_4_0 then
				local var_4_159 = arg_1_1.var_.effectkejizhuanchang2
				local var_4_160
				local var_4_161 = var_4_157

				if not var_4_159 then
					var_4_159 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_fast_in_keep"), var_4_161)
					var_4_159.name = "kejizhuanchang2"
					arg_1_1.var_.effectkejizhuanchang2 = var_4_159
				else
					var_4_159.transform:SetParent(var_4_161)
				end

				var_4_159.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_159.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_162 = manager.ui.mainCamera.transform
			local var_4_163 = 9.83333333333333

			if var_4_163 < arg_1_1.time_ and arg_1_1.time_ <= var_4_163 + arg_4_0 then
				local var_4_164 = arg_1_1.var_.effectkejizhuanchang3
				local var_4_165
				local var_4_166 = var_4_162

				if not var_4_164 then
					var_4_164 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_fast_out"), var_4_166)
					var_4_164.name = "kejizhuanchang3"
					arg_1_1.var_.effectkejizhuanchang3 = var_4_164
				else
					var_4_164.transform:SetParent(var_4_166)
				end

				var_4_164.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_164.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_167 = manager.ui.mainCamera.transform
			local var_4_168 = 12.0666666666667

			if var_4_168 < arg_1_1.time_ and arg_1_1.time_ <= var_4_168 + arg_4_0 then
				local var_4_169 = arg_1_1.var_.effectheisezhezhaozhuanchang1
				local var_4_170
				local var_4_171 = var_4_167

				if not var_4_169 then
					var_4_169 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_4_171)
					var_4_169.name = "heisezhezhaozhuanchang1"
					arg_1_1.var_.effectheisezhezhaozhuanchang1 = var_4_169
				else
					var_4_169.transform:SetParent(var_4_171)
				end

				var_4_169.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_169.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_172 = manager.ui.mainCamera.transform
			local var_4_173 = 13.7666666666667

			if var_4_173 < arg_1_1.time_ and arg_1_1.time_ <= var_4_173 + arg_4_0 then
				local var_4_174 = arg_1_1.var_.effectheisezhezhaozhuanchang1

				if var_4_174 then
					Object.Destroy(var_4_174)

					arg_1_1.var_.effectheisezhezhaozhuanchang1 = nil
				end
			end

			local var_4_175 = manager.ui.mainCamera.transform
			local var_4_176 = 15

			if var_4_176 < arg_1_1.time_ and arg_1_1.time_ <= var_4_176 + arg_4_0 then
				local var_4_177 = arg_1_1.var_.effectxiandaizhuanchang1
				local var_4_178
				local var_4_179 = var_4_175

				if not var_4_177 then
					var_4_177 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), var_4_179)
					var_4_177.name = "xiandaizhuanchang1"
					arg_1_1.var_.effectxiandaizhuanchang1 = var_4_177
				else
					var_4_177.transform:SetParent(var_4_179)
				end

				var_4_177.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_177.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_180 = manager.ui.mainCamera.transform
			local var_4_181 = 18

			if var_4_181 < arg_1_1.time_ and arg_1_1.time_ <= var_4_181 + arg_4_0 then
				local var_4_182 = arg_1_1.var_.effectxiandaizhuanchang1

				if var_4_182 then
					Object.Destroy(var_4_182)

					arg_1_1.var_.effectxiandaizhuanchang1 = nil
				end
			end

			local var_4_183 = manager.ui.mainCamera.transform
			local var_4_184 = 3.9

			if var_4_184 < arg_1_1.time_ and arg_1_1.time_ <= var_4_184 + arg_4_0 then
				local var_4_185 = arg_1_1.var_.effectzhuanchangyewan3

				if var_4_185 then
					Object.Destroy(var_4_185)

					arg_1_1.var_.effectzhuanchangyewan3 = nil
				end
			end

			local var_4_186 = manager.ui.mainCamera.transform
			local var_4_187 = 4.7

			if var_4_187 < arg_1_1.time_ and arg_1_1.time_ <= var_4_187 + arg_4_0 then
				local var_4_188 = arg_1_1.var_.effectzhuanchangyewan4

				if var_4_188 then
					Object.Destroy(var_4_188)

					arg_1_1.var_.effectzhuanchangyewan4 = nil
				end
			end

			local var_4_189 = manager.ui.mainCamera.transform
			local var_4_190 = 9.93333333333333

			if var_4_190 < arg_1_1.time_ and arg_1_1.time_ <= var_4_190 + arg_4_0 then
				local var_4_191 = arg_1_1.var_.effectkejizhuanchang2

				if var_4_191 then
					Object.Destroy(var_4_191)

					arg_1_1.var_.effectkejizhuanchang2 = nil
				end
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 101
		arg_5_1.duration_ = 2

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play102(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_0 = "A02a"

			if arg_5_1.bgs_[var_8_0] == nil then
				local var_8_1 = Object.Instantiate(arg_5_1.paintGo_)

				var_8_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_8_0)
				var_8_1.name = var_8_0
				var_8_1.transform.parent = arg_5_1.stage_.transform
				var_8_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_5_1.bgs_[var_8_0] = var_8_1
			end

			local var_8_2 = arg_5_1.bgs_.A02a
			local var_8_3 = 0

			if var_8_3 < arg_5_1.time_ and arg_5_1.time_ <= var_8_3 + arg_8_0 then
				local var_8_4 = var_8_2:GetComponent("SpriteRenderer")

				if var_8_4 then
					arg_5_1.var_.alphaOldValueA02a = var_8_4.color.a
					arg_5_1.var_.alphaMatValueA02a = var_8_4
				end

				arg_5_1.var_.alphaOldValueA02a = 0
			end

			local var_8_5 = 0.034

			if var_8_3 <= arg_5_1.time_ and arg_5_1.time_ < var_8_3 + var_8_5 then
				local var_8_6 = (arg_5_1.time_ - var_8_3) / var_8_5
				local var_8_7 = Mathf.Lerp(arg_5_1.var_.alphaOldValueA02a, 1, var_8_6)

				if arg_5_1.var_.alphaMatValueA02a then
					local var_8_8 = arg_5_1.var_.alphaMatValueA02a.color

					var_8_8.a = var_8_7
					arg_5_1.var_.alphaMatValueA02a.color = var_8_8
				end
			end

			if arg_5_1.time_ >= var_8_3 + var_8_5 and arg_5_1.time_ < var_8_3 + var_8_5 + arg_8_0 and arg_5_1.var_.alphaMatValueA02a then
				local var_8_9 = arg_5_1.var_.alphaMatValueA02a
				local var_8_10 = var_8_9.color

				var_8_10.a = 1
				var_8_9.color = var_8_10
			end

			local var_8_11 = arg_5_1.bgs_.A02a.transform
			local var_8_12 = 0.0333333333333333

			if var_8_12 < arg_5_1.time_ and arg_5_1.time_ <= var_8_12 + arg_8_0 then
				arg_5_1.var_.moveOldPosA02a = var_8_11.localPosition
			end

			local var_8_13 = 0.001

			if var_8_12 <= arg_5_1.time_ and arg_5_1.time_ < var_8_12 + var_8_13 then
				local var_8_14 = (arg_5_1.time_ - var_8_12) / var_8_13
				local var_8_15 = Vector3.New(0, 0, 0)

				var_8_11.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPosA02a, var_8_15, var_8_14)
			end

			if arg_5_1.time_ >= var_8_12 + var_8_13 and arg_5_1.time_ < var_8_12 + var_8_13 + arg_8_0 then
				var_8_11.localPosition = Vector3.New(0, 0, 0)
			end

			local var_8_16 = arg_5_1.bgs_.A03
			local var_8_17 = 0

			if var_8_17 < arg_5_1.time_ and arg_5_1.time_ <= var_8_17 + arg_8_0 then
				local var_8_18 = var_8_16:GetComponent("SpriteRenderer")

				if var_8_18 then
					arg_5_1.var_.alphaOldValueA03 = var_8_18.color.a
					arg_5_1.var_.alphaMatValueA03 = var_8_18
				end

				arg_5_1.var_.alphaOldValueA03 = 1
			end

			local var_8_19 = 0.034

			if var_8_17 <= arg_5_1.time_ and arg_5_1.time_ < var_8_17 + var_8_19 then
				local var_8_20 = (arg_5_1.time_ - var_8_17) / var_8_19
				local var_8_21 = Mathf.Lerp(arg_5_1.var_.alphaOldValueA03, 0, var_8_20)

				if arg_5_1.var_.alphaMatValueA03 then
					local var_8_22 = arg_5_1.var_.alphaMatValueA03.color

					var_8_22.a = var_8_21
					arg_5_1.var_.alphaMatValueA03.color = var_8_22
				end
			end

			if arg_5_1.time_ >= var_8_17 + var_8_19 and arg_5_1.time_ < var_8_17 + var_8_19 + arg_8_0 and arg_5_1.var_.alphaMatValueA03 then
				local var_8_23 = arg_5_1.var_.alphaMatValueA03
				local var_8_24 = var_8_23.color

				var_8_24.a = 0
				var_8_23.color = var_8_24
			end

			local var_8_25 = arg_5_1.bgs_.A03.transform
			local var_8_26 = 0.0333333333333333

			if var_8_26 < arg_5_1.time_ and arg_5_1.time_ <= var_8_26 + arg_8_0 then
				arg_5_1.var_.moveOldPosA03 = var_8_25.localPosition
			end

			local var_8_27 = 0.001

			if var_8_26 <= arg_5_1.time_ and arg_5_1.time_ < var_8_26 + var_8_27 then
				local var_8_28 = (arg_5_1.time_ - var_8_26) / var_8_27
				local var_8_29 = Vector3.New(0, 0, 0)

				var_8_25.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPosA03, var_8_29, var_8_28)
			end

			if arg_5_1.time_ >= var_8_26 + var_8_27 and arg_5_1.time_ < var_8_26 + var_8_27 + arg_8_0 then
				var_8_25.localPosition = Vector3.New(0, 0, 0)
			end

			local var_8_30 = arg_5_1.bgs_.A02a
			local var_8_31 = 0.133333333333333

			if var_8_31 < arg_5_1.time_ and arg_5_1.time_ <= var_8_31 + arg_8_0 then
				local var_8_32 = var_8_30:GetComponent("SpriteRenderer")

				if var_8_32 then
					arg_5_1.var_.alphaOldValueA02a = var_8_32.color.a
					arg_5_1.var_.alphaMatValueA02a = var_8_32
				end

				arg_5_1.var_.alphaOldValueA02a = 1
			end

			local var_8_33 = 1.86666666666667

			if var_8_31 <= arg_5_1.time_ and arg_5_1.time_ < var_8_31 + var_8_33 then
				local var_8_34 = (arg_5_1.time_ - var_8_31) / var_8_33
				local var_8_35 = Mathf.Lerp(arg_5_1.var_.alphaOldValueA02a, 0, var_8_34)

				if arg_5_1.var_.alphaMatValueA02a then
					local var_8_36 = arg_5_1.var_.alphaMatValueA02a.color

					var_8_36.a = var_8_35
					arg_5_1.var_.alphaMatValueA02a.color = var_8_36
				end
			end

			if arg_5_1.time_ >= var_8_31 + var_8_33 and arg_5_1.time_ < var_8_31 + var_8_33 + arg_8_0 and arg_5_1.var_.alphaMatValueA02a then
				local var_8_37 = arg_5_1.var_.alphaMatValueA02a
				local var_8_38 = var_8_37.color

				var_8_38.a = 0
				var_8_37.color = var_8_38
			end

			local var_8_39 = arg_5_1.bgs_.A03
			local var_8_40 = 0.133333333333333

			if var_8_40 < arg_5_1.time_ and arg_5_1.time_ <= var_8_40 + arg_8_0 then
				local var_8_41 = var_8_39:GetComponent("SpriteRenderer")

				if var_8_41 then
					arg_5_1.var_.alphaOldValueA03 = var_8_41.color.a
					arg_5_1.var_.alphaMatValueA03 = var_8_41
				end

				arg_5_1.var_.alphaOldValueA03 = 0
			end

			local var_8_42 = 1.86666666666667

			if var_8_40 <= arg_5_1.time_ and arg_5_1.time_ < var_8_40 + var_8_42 then
				local var_8_43 = (arg_5_1.time_ - var_8_40) / var_8_42
				local var_8_44 = Mathf.Lerp(arg_5_1.var_.alphaOldValueA03, 1, var_8_43)

				if arg_5_1.var_.alphaMatValueA03 then
					local var_8_45 = arg_5_1.var_.alphaMatValueA03.color

					var_8_45.a = var_8_44
					arg_5_1.var_.alphaMatValueA03.color = var_8_45
				end
			end

			if arg_5_1.time_ >= var_8_40 + var_8_42 and arg_5_1.time_ < var_8_40 + var_8_42 + arg_8_0 and arg_5_1.var_.alphaMatValueA03 then
				local var_8_46 = arg_5_1.var_.alphaMatValueA03
				local var_8_47 = var_8_46.color

				var_8_47.a = 1
				var_8_46.color = var_8_47
			end
		end

		arg_5_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A02a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "A03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_5_1:InitPlayNodeList()
	end,
	Play102 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102
		arg_9_1.duration_ = 0.97

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play103(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_1 = manager.ui.mainCamera.transform.localPosition
				local var_12_2 = Vector3.New(0, 0, 10) + Vector3.New(var_12_1.x, var_12_1.y, 0)
				local var_12_3 = arg_9_1.bgs_.A00

				var_12_3.transform.localPosition = var_12_2
				var_12_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_4 = var_12_3:GetComponent("SpriteRenderer")

				if var_12_4 and var_12_4.sprite then
					local var_12_5 = (var_12_3.transform.localPosition - var_12_1).z
					local var_12_6 = manager.ui.mainCameraCom_
					local var_12_7 = 2 * var_12_5 * Mathf.Tan(var_12_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_8 = var_12_7 * var_12_6.aspect
					local var_12_9 = var_12_4.sprite.bounds.size.x
					local var_12_10 = var_12_4.sprite.bounds.size.y
					local var_12_11 = var_12_8 / var_12_9
					local var_12_12 = var_12_7 / var_12_10
					local var_12_13 = var_12_12 < var_12_11 and var_12_11 or var_12_12

					var_12_3.transform.localScale = Vector3.New(var_12_13, var_12_13, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "A00" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play103 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103
		arg_13_1.duration_ = 0.1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play104(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			return
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play104 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 104
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play105(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "ST05"

			if arg_17_1.bgs_[var_20_0] == nil then
				local var_20_1 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_0)
				var_20_1.name = var_20_0
				var_20_1.transform.parent = arg_17_1.stage_.transform
				var_20_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_0] = var_20_1
			end

			local var_20_2 = 0

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				local var_20_3 = manager.ui.mainCamera.transform.localPosition
				local var_20_4 = Vector3.New(0, 0, 10) + Vector3.New(var_20_3.x, var_20_3.y, 0)
				local var_20_5 = arg_17_1.bgs_.ST05

				var_20_5.transform.localPosition = var_20_4
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = (var_20_5.transform.localPosition - var_20_3).z
					local var_20_8 = manager.ui.mainCameraCom_
					local var_20_9 = 2 * var_20_7 * Mathf.Tan(var_20_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_20_10 = var_20_9 * var_20_8.aspect
					local var_20_11 = var_20_6.sprite.bounds.size.x
					local var_20_12 = var_20_6.sprite.bounds.size.y
					local var_20_13 = var_20_10 / var_20_11
					local var_20_14 = var_20_9 / var_20_12
					local var_20_15 = var_20_14 < var_20_13 and var_20_13 or var_20_14

					var_20_5.transform.localScale = Vector3.New(var_20_15, var_20_15, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST05" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_16 = 0
			local var_20_17 = 0.1

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_18 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_18:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(100)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 4
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_17 or var_20_17 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_17 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23
					var_20_16 = var_20_16 + 0.3

					if var_20_23 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = var_20_16 + 0.3
			local var_20_25 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_24) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play105 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 105
		arg_23_1.duration_ = 1

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play106(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "ST05a"

			if arg_23_1.bgs_[var_26_0] == nil then
				local var_26_1 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_26_0)
				var_26_1.name = var_26_0
				var_26_1.transform.parent = arg_23_1.stage_.transform
				var_26_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_[var_26_0] = var_26_1
			end

			local var_26_2 = 0

			if var_26_2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				local var_26_3 = manager.ui.mainCamera.transform.localPosition
				local var_26_4 = Vector3.New(0, 0, 10) + Vector3.New(var_26_3.x, var_26_3.y, 0)
				local var_26_5 = arg_23_1.bgs_.ST05a

				var_26_5.transform.localPosition = var_26_4
				var_26_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_6 = var_26_5:GetComponent("SpriteRenderer")

				if var_26_6 and var_26_6.sprite then
					local var_26_7 = (var_26_5.transform.localPosition - var_26_3).z
					local var_26_8 = manager.ui.mainCameraCom_
					local var_26_9 = 2 * var_26_7 * Mathf.Tan(var_26_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_26_10 = var_26_9 * var_26_8.aspect
					local var_26_11 = var_26_6.sprite.bounds.size.x
					local var_26_12 = var_26_6.sprite.bounds.size.y
					local var_26_13 = var_26_10 / var_26_11
					local var_26_14 = var_26_9 / var_26_12
					local var_26_15 = var_26_14 < var_26_13 and var_26_13 or var_26_14

					var_26_5.transform.localScale = Vector3.New(var_26_15, var_26_15, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "ST05a" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_16 = arg_23_1.bgs_.ST05.transform
			local var_26_17 = 0

			if var_26_17 < arg_23_1.time_ and arg_23_1.time_ <= var_26_17 + arg_26_0 then
				arg_23_1.var_.moveOldPosST05 = var_26_16.localPosition
			end

			local var_26_18 = 0.001

			if var_26_17 <= arg_23_1.time_ and arg_23_1.time_ < var_26_17 + var_26_18 then
				local var_26_19 = (arg_23_1.time_ - var_26_17) / var_26_18
				local var_26_20 = Vector3.New(0, -100, 10)

				var_26_16.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosST05, var_26_20, var_26_19)
			end

			if arg_23_1.time_ >= var_26_17 + var_26_18 and arg_23_1.time_ < var_26_17 + var_26_18 + arg_26_0 then
				var_26_16.localPosition = Vector3.New(0, -100, 10)
			end

			local var_26_21 = 0
			local var_26_22 = 0.1

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_23 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_23:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_24 = arg_23_1:GetWordFromCfg(100)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_26 = 4
				local var_26_27 = utf8.len(var_26_25)
				local var_26_28 = var_26_26 <= 0 and var_26_22 or var_26_22 * (var_26_27 / var_26_26)

				if var_26_28 > 0 and var_26_22 < var_26_28 then
					arg_23_1.talkMaxDuration = var_26_28
					var_26_21 = var_26_21 + 0.3

					if var_26_28 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_21
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_29 = var_26_21 + 0.3
			local var_26_30 = math.max(var_26_22, arg_23_1.talkMaxDuration)

			if var_26_29 <= arg_23_1.time_ and arg_23_1.time_ < var_26_29 + var_26_30 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_29) / var_26_30

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_29 + var_26_30 and arg_23_1.time_ < var_26_29 + var_26_30 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST05",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play106 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 106
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play107(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "ST06"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 0

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.ST06

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST06" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = arg_29_1.bgs_.ST05a.transform
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.moveOldPosST05a = var_32_16.localPosition
			end

			local var_32_18 = 0.001

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18
				local var_32_20 = Vector3.New(0, -100, 10)

				var_32_16.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosST05a, var_32_20, var_32_19)
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 then
				var_32_16.localPosition = Vector3.New(0, -100, 10)
			end

			local var_32_21 = 0
			local var_32_22 = 0.1

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_23 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_23:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_24 = arg_29_1:GetWordFromCfg(100)
				local var_32_25 = arg_29_1:FormatText(var_32_24.content)

				arg_29_1.text_.text = var_32_25

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_26 = 4
				local var_32_27 = utf8.len(var_32_25)
				local var_32_28 = var_32_26 <= 0 and var_32_22 or var_32_22 * (var_32_27 / var_32_26)

				if var_32_28 > 0 and var_32_22 < var_32_28 then
					arg_29_1.talkMaxDuration = var_32_28
					var_32_21 = var_32_21 + 0.3

					if var_32_28 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_21
					end
				end

				arg_29_1.text_.text = var_32_25
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_29 = var_32_21 + 0.3
			local var_32_30 = math.max(var_32_22, arg_29_1.talkMaxDuration)

			if var_32_29 <= arg_29_1.time_ and arg_29_1.time_ < var_32_29 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_29) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_29 + var_32_30 and arg_29_1.time_ < var_32_29 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST05a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play107 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 107
		arg_35_1.duration_ = 1

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play108(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "1148ui_story"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_35_1.stage_.transform)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentInChildren(typeof(CharacterEffect))

					var_38_3.enabled = true

					local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_2, typeof(DynamicBoneHelper))

					if var_38_4 then
						var_38_4:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_3.transform, false)

					arg_35_1.var_[var_38_0 .. "Animator"] = var_38_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_0 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_0 .. "LipSync"] = var_38_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_5 = arg_35_1.actors_["1148ui_story"]
			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1148ui_story == nil then
				arg_35_1.var_.characterEffect1148ui_story = var_38_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_7 = 0.1

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_7 and not isNil(var_38_5) then
				local var_38_8 = (arg_35_1.time_ - var_38_6) / var_38_7

				if arg_35_1.var_.characterEffect1148ui_story and not isNil(var_38_5) then
					arg_35_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_6 + var_38_7 and arg_35_1.time_ < var_38_6 + var_38_7 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1148ui_story then
				arg_35_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_38_9 = "1084ui_story"

			if arg_35_1.actors_[var_38_9] == nil then
				local var_38_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_38_10) then
					local var_38_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_35_1.stage_.transform)

					var_38_11.name = var_38_9
					var_38_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_9] = var_38_11

					local var_38_12 = var_38_11:GetComponentInChildren(typeof(CharacterEffect))

					var_38_12.enabled = true

					local var_38_13 = GameObjectTools.GetOrAddComponent(var_38_11, typeof(DynamicBoneHelper))

					if var_38_13 then
						var_38_13:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_12.transform, false)

					arg_35_1.var_[var_38_9 .. "Animator"] = var_38_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_9 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_9 .. "LipSync"] = var_38_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_14 = arg_35_1.actors_["1084ui_story"]
			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_16 = 0.1

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_16 and not isNil(var_38_14) then
				local var_38_17 = (arg_35_1.time_ - var_38_15) / var_38_16

				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_14) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_15 + var_38_16 and arg_35_1.time_ < var_38_15 + var_38_16 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_38_18 = "ST06a"

			if arg_35_1.bgs_[var_38_18] == nil then
				local var_38_19 = Object.Instantiate(arg_35_1.paintGo_)

				var_38_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_38_18)
				var_38_19.name = var_38_18
				var_38_19.transform.parent = arg_35_1.stage_.transform
				var_38_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.bgs_[var_38_18] = var_38_19
			end

			local var_38_20 = 0

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				local var_38_21 = manager.ui.mainCamera.transform.localPosition
				local var_38_22 = Vector3.New(0, 0, 10) + Vector3.New(var_38_21.x, var_38_21.y, 0)
				local var_38_23 = arg_35_1.bgs_.ST06a

				var_38_23.transform.localPosition = var_38_22
				var_38_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_38_24 = var_38_23:GetComponent("SpriteRenderer")

				if var_38_24 and var_38_24.sprite then
					local var_38_25 = (var_38_23.transform.localPosition - var_38_21).z
					local var_38_26 = manager.ui.mainCameraCom_
					local var_38_27 = 2 * var_38_25 * Mathf.Tan(var_38_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_38_28 = var_38_27 * var_38_26.aspect
					local var_38_29 = var_38_24.sprite.bounds.size.x
					local var_38_30 = var_38_24.sprite.bounds.size.y
					local var_38_31 = var_38_28 / var_38_29
					local var_38_32 = var_38_27 / var_38_30
					local var_38_33 = var_38_32 < var_38_31 and var_38_31 or var_38_32

					var_38_23.transform.localScale = Vector3.New(var_38_33, var_38_33, 0)
				end

				for iter_38_0, iter_38_1 in pairs(arg_35_1.bgs_) do
					if iter_38_0 ~= "ST06a" then
						iter_38_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_38_34 = arg_35_1.bgs_.ST06.transform
			local var_38_35 = 0

			if var_38_35 < arg_35_1.time_ and arg_35_1.time_ <= var_38_35 + arg_38_0 then
				arg_35_1.var_.moveOldPosST06 = var_38_34.localPosition
			end

			local var_38_36 = 0.001

			if var_38_35 <= arg_35_1.time_ and arg_35_1.time_ < var_38_35 + var_38_36 then
				local var_38_37 = (arg_35_1.time_ - var_38_35) / var_38_36
				local var_38_38 = Vector3.New(0, -100, 10)

				var_38_34.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosST06, var_38_38, var_38_37)
			end

			if arg_35_1.time_ >= var_38_35 + var_38_36 and arg_35_1.time_ < var_38_35 + var_38_36 + arg_38_0 then
				var_38_34.localPosition = Vector3.New(0, -100, 10)
			end

			local var_38_39 = 0
			local var_38_40 = 0.1

			if var_38_39 < arg_35_1.time_ and arg_35_1.time_ <= var_38_39 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_41 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_41:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_42 = arg_35_1:GetWordFromCfg(100)
				local var_38_43 = arg_35_1:FormatText(var_38_42.content)

				arg_35_1.text_.text = var_38_43

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_44 = 4
				local var_38_45 = utf8.len(var_38_43)
				local var_38_46 = var_38_44 <= 0 and var_38_40 or var_38_40 * (var_38_45 / var_38_44)

				if var_38_46 > 0 and var_38_40 < var_38_46 then
					arg_35_1.talkMaxDuration = var_38_46
					var_38_39 = var_38_39 + 0.3

					if var_38_46 + var_38_39 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_46 + var_38_39
					end
				end

				arg_35_1.text_.text = var_38_43
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_47 = var_38_39 + 0.3
			local var_38_48 = math.max(var_38_40, arg_35_1.talkMaxDuration)

			if var_38_47 <= arg_35_1.time_ and arg_35_1.time_ < var_38_47 + var_38_48 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_47) / var_38_48

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_47 + var_38_48 and arg_35_1.time_ < var_38_47 + var_38_48 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play108 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 108
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play109(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story == nil then
				arg_41_1.var_.characterEffect1148ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.1

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1148ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story then
				arg_41_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1084ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.1

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_44_8 = "ST06b"

			if arg_41_1.bgs_[var_44_8] == nil then
				local var_44_9 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_44_8)
				var_44_9.name = var_44_8
				var_44_9.transform.parent = arg_41_1.stage_.transform
				var_44_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_[var_44_8] = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				local var_44_11 = manager.ui.mainCamera.transform.localPosition
				local var_44_12 = Vector3.New(0, 0, 10) + Vector3.New(var_44_11.x, var_44_11.y, 0)
				local var_44_13 = arg_41_1.bgs_.ST06b

				var_44_13.transform.localPosition = var_44_12
				var_44_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_14 = var_44_13:GetComponent("SpriteRenderer")

				if var_44_14 and var_44_14.sprite then
					local var_44_15 = (var_44_13.transform.localPosition - var_44_11).z
					local var_44_16 = manager.ui.mainCameraCom_
					local var_44_17 = 2 * var_44_15 * Mathf.Tan(var_44_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_44_18 = var_44_17 * var_44_16.aspect
					local var_44_19 = var_44_14.sprite.bounds.size.x
					local var_44_20 = var_44_14.sprite.bounds.size.y
					local var_44_21 = var_44_18 / var_44_19
					local var_44_22 = var_44_17 / var_44_20
					local var_44_23 = var_44_22 < var_44_21 and var_44_21 or var_44_22

					var_44_13.transform.localScale = Vector3.New(var_44_23, var_44_23, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "ST06b" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_24 = arg_41_1.bgs_.ST06a.transform
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 then
				arg_41_1.var_.moveOldPosST06a = var_44_24.localPosition
			end

			local var_44_26 = 0.001

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26
				local var_44_28 = Vector3.New(0, -100, 10)

				var_44_24.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPosST06a, var_44_28, var_44_27)
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 then
				var_44_24.localPosition = Vector3.New(0, -100, 10)
			end

			local var_44_29 = 0
			local var_44_30 = 0.1

			if var_44_29 < arg_41_1.time_ and arg_41_1.time_ <= var_44_29 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_31 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_31:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_32 = arg_41_1:GetWordFromCfg(100)
				local var_44_33 = arg_41_1:FormatText(var_44_32.content)

				arg_41_1.text_.text = var_44_33

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_34 = 4
				local var_44_35 = utf8.len(var_44_33)
				local var_44_36 = var_44_34 <= 0 and var_44_30 or var_44_30 * (var_44_35 / var_44_34)

				if var_44_36 > 0 and var_44_30 < var_44_36 then
					arg_41_1.talkMaxDuration = var_44_36
					var_44_29 = var_44_29 + 0.3

					if var_44_36 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_29
					end
				end

				arg_41_1.text_.text = var_44_33
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_37 = var_44_29 + 0.3
			local var_44_38 = math.max(var_44_30, arg_41_1.talkMaxDuration)

			if var_44_37 <= arg_41_1.time_ and arg_41_1.time_ < var_44_37 + var_44_38 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_37) / var_44_38

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_37 + var_44_38 and arg_41_1.time_ < var_44_37 + var_44_38 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play109 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 109
		arg_47_1.duration_ = 1

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play110(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "ST07a"

			if arg_47_1.bgs_[var_50_0] == nil then
				local var_50_1 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_0)
				var_50_1.name = var_50_0
				var_50_1.transform.parent = arg_47_1.stage_.transform
				var_50_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_0] = var_50_1
			end

			local var_50_2 = 0

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				local var_50_3 = manager.ui.mainCamera.transform.localPosition
				local var_50_4 = Vector3.New(0, 0, 10) + Vector3.New(var_50_3.x, var_50_3.y, 0)
				local var_50_5 = arg_47_1.bgs_.ST07a

				var_50_5.transform.localPosition = var_50_4
				var_50_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_6 = var_50_5:GetComponent("SpriteRenderer")

				if var_50_6 and var_50_6.sprite then
					local var_50_7 = (var_50_5.transform.localPosition - var_50_3).z
					local var_50_8 = manager.ui.mainCameraCom_
					local var_50_9 = 2 * var_50_7 * Mathf.Tan(var_50_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_10 = var_50_9 * var_50_8.aspect
					local var_50_11 = var_50_6.sprite.bounds.size.x
					local var_50_12 = var_50_6.sprite.bounds.size.y
					local var_50_13 = var_50_10 / var_50_11
					local var_50_14 = var_50_9 / var_50_12
					local var_50_15 = var_50_14 < var_50_13 and var_50_13 or var_50_14

					var_50_5.transform.localScale = Vector3.New(var_50_15, var_50_15, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST07a" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_16 = 0
			local var_50_17 = 0.1

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_18 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_18:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_19 = arg_47_1:GetWordFromCfg(100)
				local var_50_20 = arg_47_1:FormatText(var_50_19.content)

				arg_47_1.text_.text = var_50_20

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_21 = 4
				local var_50_22 = utf8.len(var_50_20)
				local var_50_23 = var_50_21 <= 0 and var_50_17 or var_50_17 * (var_50_22 / var_50_21)

				if var_50_23 > 0 and var_50_17 < var_50_23 then
					arg_47_1.talkMaxDuration = var_50_23
					var_50_16 = var_50_16 + 0.3

					if var_50_23 + var_50_16 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_23 + var_50_16
					end
				end

				arg_47_1.text_.text = var_50_20
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_24 = var_50_16 + 0.3
			local var_50_25 = math.max(var_50_17, arg_47_1.talkMaxDuration)

			if var_50_24 <= arg_47_1.time_ and arg_47_1.time_ < var_50_24 + var_50_25 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_24) / var_50_25

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_24 + var_50_25 and arg_47_1.time_ < var_50_24 + var_50_25 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play110 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 110
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play111(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "ST07b"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 0

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.ST07b

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "ST07b" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 0
			local var_56_17 = 0.1

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_18 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_18:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(100)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 4
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23
					var_56_16 = var_56_16 + 0.3

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_24 = var_56_16 + 0.3
			local var_56_25 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_24 <= arg_53_1.time_ and arg_53_1.time_ < var_56_24 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_24) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_24 + var_56_25 and arg_53_1.time_ < var_56_24 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play111 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 111
		arg_59_1.duration_ = 1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "ST08"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 0

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.ST08

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "ST08" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 0
			local var_62_17 = 0.1

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_18 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_18:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_19 = arg_59_1:GetWordFromCfg(100)
				local var_62_20 = arg_59_1:FormatText(var_62_19.content)

				arg_59_1.text_.text = var_62_20

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_21 = 4
				local var_62_22 = utf8.len(var_62_20)
				local var_62_23 = var_62_21 <= 0 and var_62_17 or var_62_17 * (var_62_22 / var_62_21)

				if var_62_23 > 0 and var_62_17 < var_62_23 then
					arg_59_1.talkMaxDuration = var_62_23
					var_62_16 = var_62_16 + 0.3

					if var_62_23 + var_62_16 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_16
					end
				end

				arg_59_1.text_.text = var_62_20
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_24 = var_62_16 + 0.3
			local var_62_25 = math.max(var_62_17, arg_59_1.talkMaxDuration)

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_24) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_24 + var_62_25 and arg_59_1.time_ < var_62_24 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 112
		arg_65_1.duration_ = 6.93

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
			arg_65_1.auto_ = false
		end

		function arg_65_1.playNext_(arg_67_0)
			arg_65_1.onStoryFinished_()
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1148ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1148ui_story == nil then
				arg_65_1.var_.characterEffect1148ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.1

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1148ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1148ui_story then
				arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1084ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.1

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_8 = arg_65_1.bgs_.ST08.transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPosST08 = var_68_8.localPosition
			end

			local var_68_10 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10
				local var_68_12 = Vector3.New(0, -100, 10)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosST08, var_68_12, var_68_11)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(0, -100, 10)
			end

			local var_68_13 = "ST12"

			if arg_65_1.bgs_[var_68_13] == nil then
				local var_68_14 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_13)
				var_68_14.name = var_68_13
				var_68_14.transform.parent = arg_65_1.stage_.transform
				var_68_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_13] = var_68_14
			end

			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				local var_68_16 = manager.ui.mainCamera.transform.localPosition
				local var_68_17 = Vector3.New(0, 0, 10) + Vector3.New(var_68_16.x, var_68_16.y, 0)
				local var_68_18 = arg_65_1.bgs_.ST12

				var_68_18.transform.localPosition = var_68_17
				var_68_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_19 = var_68_18:GetComponent("SpriteRenderer")

				if var_68_19 and var_68_19.sprite then
					local var_68_20 = (var_68_18.transform.localPosition - var_68_16).z
					local var_68_21 = manager.ui.mainCameraCom_
					local var_68_22 = 2 * var_68_20 * Mathf.Tan(var_68_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_23 = var_68_22 * var_68_21.aspect
					local var_68_24 = var_68_19.sprite.bounds.size.x
					local var_68_25 = var_68_19.sprite.bounds.size.y
					local var_68_26 = var_68_23 / var_68_24
					local var_68_27 = var_68_22 / var_68_25
					local var_68_28 = var_68_27 < var_68_26 and var_68_26 or var_68_27

					var_68_18.transform.localScale = Vector3.New(var_68_28, var_68_28, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "ST12" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_29 = 0

			if var_68_29 < arg_65_1.time_ and arg_65_1.time_ <= var_68_29 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action456")
			end

			local var_68_30 = 0
			local var_68_31 = 0.1

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_32 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_32:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(100)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 4
				local var_68_36 = utf8.len(var_68_34)
				local var_68_37 = var_68_35 <= 0 and var_68_31 or var_68_31 * (var_68_36 / var_68_35)

				if var_68_37 > 0 and var_68_31 < var_68_37 then
					arg_65_1.talkMaxDuration = var_68_37
					var_68_30 = var_68_30 + 0.3

					if var_68_37 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_37 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_34
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_38 = var_68_30 + 0.3
			local var_68_39 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_38 <= arg_65_1.time_ and arg_65_1.time_ < var_68_38 + var_68_39 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_38) / var_68_39

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_38 + var_68_39 and arg_65_1.time_ < var_68_38 + var_68_39 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST08",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A03",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/A07a",
		"TextureConfig/Background/A04",
		"TextureConfig/Background/A06",
		"TextureConfig/Background/SA0102",
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/ST05",
		"TextureConfig/Background/ST05a",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/ST06a",
		"TextureConfig/Background/ST06b",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST08",
		"TextureConfig/Background/ST12"
	},
	voices = {}
}
