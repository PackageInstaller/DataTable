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
			local var_4_9008
			local var_4_9007
			local var_4_9006
			local var_4_9005
			local var_4_9004
			local var_4_9003
			local var_4_9002
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.A03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A03")
				var_4_0.name = "A03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A03

				arg_1_1.bgs_.A03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = "A00"

			if arg_1_1.bgs_.A00 == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_7 = var_4_6:GetComponent("SpriteRenderer")

				if var_4_7 and var_4_7.sprite then
					local var_4_8 = 2 * (var_4_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_6.transform.localScale = Vector3.New(var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, 0)
				end

				for iter_4_2, iter_4_3 in pairs(arg_1_1.bgs_) do
					if iter_4_2 ~= "A00" then
						iter_4_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_9 = "A07a"

			if arg_1_1.bgs_.A07a == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 3.9 < arg_1_1.time_ and arg_1_1.time_ <= 3.9 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.A07a

				arg_1_1.bgs_.A07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_4, iter_4_5 in pairs(arg_1_1.bgs_) do
					if iter_4_4 ~= "A07a" then
						iter_4_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = "A04"

			if arg_1_1.bgs_.A04 == nil then
				local var_4_15 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_14)
				var_4_15.name = var_4_14
				var_4_15.transform.parent = arg_1_1.stage_.transform
				var_4_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_14] = var_4_15
			end

			if 6.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 6.83333333333333 + arg_4_0 then
				local var_4_16 = arg_1_1.bgs_.A04

				arg_1_1.bgs_.A04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_17 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_17 and var_4_17.sprite then
					local var_4_18 = 2 * (var_4_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_16.transform.localScale = Vector3.New(var_4_18 / var_4_17.sprite.bounds.size.y < var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x and var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x or var_4_18 / var_4_17.sprite.bounds.size.y, var_4_18 / var_4_17.sprite.bounds.size.y < var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x and var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x or var_4_18 / var_4_17.sprite.bounds.size.y, 0)
				end

				for iter_4_6, iter_4_7 in pairs(arg_1_1.bgs_) do
					if iter_4_6 ~= "A04" then
						iter_4_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_19 = "A06"

			if arg_1_1.bgs_.A06 == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			if 9.7 < arg_1_1.time_ and arg_1_1.time_ <= 9.7 + arg_4_0 then
				local var_4_21 = arg_1_1.bgs_.A06

				arg_1_1.bgs_.A06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_22 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_22 and var_4_22.sprite then
					local var_4_23 = 2 * (var_4_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_21.transform.localScale = Vector3.New(var_4_23 / var_4_22.sprite.bounds.size.y < var_4_23 * manager.ui.mainCameraCom_.aspect / var_4_22.sprite.bounds.size.x and var_4_23 * manager.ui.mainCameraCom_.aspect / var_4_22.sprite.bounds.size.x or var_4_23 / var_4_22.sprite.bounds.size.y, var_4_23 / var_4_22.sprite.bounds.size.y < var_4_23 * manager.ui.mainCameraCom_.aspect / var_4_22.sprite.bounds.size.x and var_4_23 * manager.ui.mainCameraCom_.aspect / var_4_22.sprite.bounds.size.x or var_4_23 / var_4_22.sprite.bounds.size.y, 0)
				end

				for iter_4_8, iter_4_9 in pairs(arg_1_1.bgs_) do
					if iter_4_8 ~= "A06" then
						iter_4_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_24 = "SA0102"

			if arg_1_1.bgs_.SA0102 == nil then
				local var_4_25 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_24)
				var_4_25.name = var_4_24
				var_4_25.transform.parent = arg_1_1.stage_.transform
				var_4_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_24] = var_4_25
			end

			if 13.0217532408734 < arg_1_1.time_ and arg_1_1.time_ <= 13.0217532408734 + arg_4_0 then
				local var_4_26 = arg_1_1.bgs_.SA0102

				arg_1_1.bgs_.SA0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_27 = var_4_26:GetComponent("SpriteRenderer")

				if var_4_27 and var_4_27.sprite then
					local var_4_28 = 2 * (var_4_26.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_26.transform.localScale = Vector3.New(var_4_28 / var_4_27.sprite.bounds.size.y < var_4_28 * manager.ui.mainCameraCom_.aspect / var_4_27.sprite.bounds.size.x and var_4_28 * manager.ui.mainCameraCom_.aspect / var_4_27.sprite.bounds.size.x or var_4_28 / var_4_27.sprite.bounds.size.y, var_4_28 / var_4_27.sprite.bounds.size.y < var_4_28 * manager.ui.mainCameraCom_.aspect / var_4_27.sprite.bounds.size.x and var_4_28 * manager.ui.mainCameraCom_.aspect / var_4_27.sprite.bounds.size.x or var_4_28 / var_4_27.sprite.bounds.size.y, 0)
				end

				for iter_4_10, iter_4_11 in pairs(arg_1_1.bgs_) do
					if iter_4_10 ~= "SA0102" then
						iter_4_11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_29 = "L01h"

			if arg_1_1.bgs_.L01h == nil then
				local var_4_30 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_30:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_29)
				var_4_30.name = var_4_29
				var_4_30.transform.parent = arg_1_1.stage_.transform
				var_4_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_29] = var_4_30
			end

			if 15.9666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 15.9666666666667 + arg_4_0 then
				local var_4_31 = arg_1_1.bgs_.L01h

				arg_1_1.bgs_.L01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_32 = var_4_31:GetComponent("SpriteRenderer")

				if var_4_32 and var_4_32.sprite then
					local var_4_33 = 2 * (var_4_31.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_31.transform.localScale = Vector3.New(var_4_33 / var_4_32.sprite.bounds.size.y < var_4_33 * manager.ui.mainCameraCom_.aspect / var_4_32.sprite.bounds.size.x and var_4_33 * manager.ui.mainCameraCom_.aspect / var_4_32.sprite.bounds.size.x or var_4_33 / var_4_32.sprite.bounds.size.y, var_4_33 / var_4_32.sprite.bounds.size.y < var_4_33 * manager.ui.mainCameraCom_.aspect / var_4_32.sprite.bounds.size.x and var_4_33 * manager.ui.mainCameraCom_.aspect / var_4_32.sprite.bounds.size.x or var_4_33 / var_4_32.sprite.bounds.size.y, 0)
				end

				for iter_4_12, iter_4_13 in pairs(arg_1_1.bgs_) do
					if iter_4_12 ~= "L01h" then
						iter_4_13.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_34 = "1066ui_tpose"

			if arg_1_1.actors_["1066ui_tpose"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_tpose"))) then
				local var_4_35 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_tpose"), arg_1_1.stage_.transform)

				var_4_35.name = var_4_34
				var_4_35.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_34] = var_4_35

				local var_4_36 = var_4_35:GetComponentInChildren(typeof(CharacterEffect))

				var_4_36.enabled = true

				local var_4_37 = GameObjectTools.GetOrAddComponent(var_4_35, typeof(DynamicBoneHelper))

				if var_4_37 then
					var_4_37:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_36.transform, false)

				arg_1_1.var_[var_4_34 .. "Animator"] = var_4_36.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_34 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_34 .. "LipSync"] = var_4_36.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_38 = arg_1_1.actors_["1066ui_tpose"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_tpose = var_4_38.localPosition
			end

			local var_4_39 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_39 then
				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_tpose, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_39)
				var_4_38.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_38.position).x, (manager.ui.mainCamera.transform.position - var_4_38.position).y, (manager.ui.mainCamera.transform.position - var_4_38.position).z)
				var_4_38.localEulerAngles.z = 0
				var_4_38.localEulerAngles.x = 0
				var_4_38.localEulerAngles = var_4_38.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_39 and arg_1_1.time_ < 0 + var_4_39 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(0, 100, 0)
				var_4_38.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_38.position).x, (manager.ui.mainCamera.transform.position - var_4_38.position).y, (manager.ui.mainCamera.transform.position - var_4_38.position).z)
				var_4_38.localEulerAngles.z = 0
				var_4_38.localEulerAngles.x = 0
				var_4_38.localEulerAngles = var_4_38.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_40 = arg_1_1.var_.effectzhuanchangyewan1

				if not arg_1_1.var_.effectzhuanchangyewan1 then
					var_4_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), manager.ui.mainCamera.transform)
					var_4_40.name = "zhuanchangyewan1"
					arg_1_1.var_.effectzhuanchangyewan1 = var_4_40
				else
					var_4_40.transform:SetParent(var_4_9008)
				end

				var_4_40.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_40.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				local var_4_42 = arg_1_1.var_.effectzhuanchangyewan2

				if not arg_1_1.var_.effectzhuanchangyewan2 then
					var_4_42 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), manager.ui.mainCamera.transform)
					var_4_42.name = "zhuanchangyewan2"
					arg_1_1.var_.effectzhuanchangyewan2 = var_4_42
				else
					var_4_42.transform:SetParent(var_4_9007)
				end

				var_4_42.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_42.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				if arg_1_1.var_.effectzhuanchangyewan1 then
					Object.Destroy(arg_1_1.var_.effectzhuanchangyewan1)

					arg_1_1.var_.effectzhuanchangyewan1 = nil
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				if arg_1_1.var_.effectzhuanchangyewan2 then
					Object.Destroy(arg_1_1.var_.effectzhuanchangyewan2)

					arg_1_1.var_.effectzhuanchangyewan2 = nil
				end
			end

			if 2.7 < arg_1_1.time_ and arg_1_1.time_ <= 2.7 + arg_4_0 then
				local var_4_46 = arg_1_1.var_.effectzhuanchangyewan3

				if not arg_1_1.var_.effectzhuanchangyewan3 then
					var_4_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_in_keep"), manager.ui.mainCamera.transform)
					var_4_46.name = "zhuanchangyewan3"
					arg_1_1.var_.effectzhuanchangyewan3 = var_4_46
				else
					var_4_46.transform:SetParent(var_4_9005)
				end

				var_4_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_46.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.9 < arg_1_1.time_ and arg_1_1.time_ <= 3.9 + arg_4_0 then
				local var_4_48 = arg_1_1.var_.effectzhuanchangyewan4

				if not arg_1_1.var_.effectzhuanchangyewan4 then
					var_4_48 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_out"), manager.ui.mainCamera.transform)
					var_4_48.name = "zhuanchangyewan4"
					arg_1_1.var_.effectzhuanchangyewan4 = var_4_48
				else
					var_4_48.transform:SetParent(var_4_9006)
				end

				var_4_48.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_48.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.83333333333333 + arg_4_0 then
				local var_4_50 = arg_1_1.var_.effectkejizhuanchang1

				if not arg_1_1.var_.effectkejizhuanchang1 then
					var_4_50 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_slow"), manager.ui.mainCamera.transform)
					var_4_50.name = "kejizhuanchang1"
					arg_1_1.var_.effectkejizhuanchang1 = var_4_50
				else
					var_4_50.transform:SetParent(var_4_9004)
				end

				var_4_50.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_50.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 8.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 8.83333333333333 + arg_4_0 then
				local var_4_52 = arg_1_1.var_.effectkejizhuanchang2

				if not arg_1_1.var_.effectkejizhuanchang2 then
					var_4_52 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_fast_in_keep"), manager.ui.mainCamera.transform)
					var_4_52.name = "kejizhuanchang2"
					arg_1_1.var_.effectkejizhuanchang2 = var_4_52
				else
					var_4_52.transform:SetParent(var_4_9003)
				end

				var_4_52.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_52.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 9.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 9.83333333333333 + arg_4_0 then
				local var_4_54 = arg_1_1.var_.effectkejizhuanchang3

				if not arg_1_1.var_.effectkejizhuanchang3 then
					var_4_54 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblock_fast_out"), manager.ui.mainCamera.transform)
					var_4_54.name = "kejizhuanchang3"
					arg_1_1.var_.effectkejizhuanchang3 = var_4_54
				else
					var_4_54.transform:SetParent(var_4_9002)
				end

				var_4_54.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_54.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 12.0666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 12.0666666666667 + arg_4_0 then
				local var_4_56 = arg_1_1.var_.effectheisezhezhaozhuanchang1

				if not arg_1_1.var_.effectheisezhezhaozhuanchang1 then
					var_4_56 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_4_56.name = "heisezhezhaozhuanchang1"
					arg_1_1.var_.effectheisezhezhaozhuanchang1 = var_4_56
				else
					var_4_56.transform:SetParent(var_4_9001)
				end

				var_4_56.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_56.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 13.7666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 13.7666666666667 + arg_4_0 then
				if arg_1_1.var_.effectheisezhezhaozhuanchang1 then
					Object.Destroy(arg_1_1.var_.effectheisezhezhaozhuanchang1)

					arg_1_1.var_.effectheisezhezhaozhuanchang1 = nil
				end
			end

			if 15 < arg_1_1.time_ and arg_1_1.time_ <= 15 + arg_4_0 then
				local var_4_59 = arg_1_1.var_.effectxiandaizhuanchang1

				if not arg_1_1.var_.effectxiandaizhuanchang1 then
					var_4_59 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), manager.ui.mainCamera.transform)
					var_4_59.name = "xiandaizhuanchang1"
					arg_1_1.var_.effectxiandaizhuanchang1 = var_4_59
				else
					var_4_59.transform:SetParent(var_4_9000)
				end

				var_4_59.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_59.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 18 < arg_1_1.time_ and arg_1_1.time_ <= 18 + arg_4_0 then
				if arg_1_1.var_.effectxiandaizhuanchang1 then
					Object.Destroy(arg_1_1.var_.effectxiandaizhuanchang1)

					arg_1_1.var_.effectxiandaizhuanchang1 = nil
				end
			end

			if 3.9 < arg_1_1.time_ and arg_1_1.time_ <= 3.9 + arg_4_0 then
				if arg_1_1.var_.effectzhuanchangyewan3 then
					Object.Destroy(arg_1_1.var_.effectzhuanchangyewan3)

					arg_1_1.var_.effectzhuanchangyewan3 = nil
				end
			end

			if 4.7 < arg_1_1.time_ and arg_1_1.time_ <= 4.7 + arg_4_0 then
				if arg_1_1.var_.effectzhuanchangyewan4 then
					Object.Destroy(arg_1_1.var_.effectzhuanchangyewan4)

					arg_1_1.var_.effectzhuanchangyewan4 = nil
				end
			end

			if 9.93333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 9.93333333333333 + arg_4_0 then
				if arg_1_1.var_.effectkejizhuanchang2 then
					Object.Destroy(arg_1_1.var_.effectkejizhuanchang2)

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
			if arg_5_1.bgs_.A02a == nil then
				local var_8_0 = Object.Instantiate(arg_5_1.paintGo_)

				var_8_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A02a")
				var_8_0.name = "A02a"
				var_8_0.transform.parent = arg_5_1.stage_.transform
				var_8_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_5_1.bgs_.A02a = var_8_0
			end

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_1 = arg_5_1.bgs_.A02a:GetComponent("SpriteRenderer")

				if var_8_1 then
					arg_5_1.var_.alphaOldValueA02a = var_8_1.color.a
					arg_5_1.var_.alphaMatValueA02a = var_8_1
				end

				arg_5_1.var_.alphaOldValueA02a = 0
			end

			local var_8_2 = 0.034

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_2 then
				if arg_5_1.var_.alphaMatValueA02a then
					arg_5_1.var_.alphaMatValueA02a.color.a = Mathf.Lerp(arg_5_1.var_.alphaOldValueA02a, 1, (arg_5_1.time_ - 0) / var_8_2)
					arg_5_1.var_.alphaMatValueA02a.color = arg_5_1.var_.alphaMatValueA02a.color
				end
			end

			if arg_5_1.time_ >= 0 + var_8_2 and arg_5_1.time_ < 0 + var_8_2 + arg_8_0 and arg_5_1.var_.alphaMatValueA02a then
				arg_5_1.var_.alphaMatValueA02a.color.a = 1
				arg_5_1.var_.alphaMatValueA02a.color = arg_5_1.var_.alphaMatValueA02a.color
			end

			local var_8_3 = arg_5_1.bgs_.A02a.transform

			if 0.0333333333333333 < arg_5_1.time_ and arg_5_1.time_ <= 0.0333333333333333 + arg_8_0 then
				arg_5_1.var_.moveOldPosA02a = var_8_3.localPosition
			end

			local var_8_4 = 0.001

			if 0.0333333333333333 <= arg_5_1.time_ and arg_5_1.time_ < 0.0333333333333333 + var_8_4 then
				var_8_3.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPosA02a, Vector3.New(0, 0, 0), (arg_5_1.time_ - 0.0333333333333333) / var_8_4)
			end

			if arg_5_1.time_ >= 0.0333333333333333 + var_8_4 and arg_5_1.time_ < 0.0333333333333333 + var_8_4 + arg_8_0 then
				var_8_3.localPosition = Vector3.New(0, 0, 0)
			end

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_5 = arg_5_1.bgs_.A03:GetComponent("SpriteRenderer")

				if var_8_5 then
					arg_5_1.var_.alphaOldValueA03 = var_8_5.color.a
					arg_5_1.var_.alphaMatValueA03 = var_8_5
				end

				arg_5_1.var_.alphaOldValueA03 = 1
			end

			local var_8_6 = 0.034

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_6 then
				if arg_5_1.var_.alphaMatValueA03 then
					arg_5_1.var_.alphaMatValueA03.color.a = Mathf.Lerp(arg_5_1.var_.alphaOldValueA03, 0, (arg_5_1.time_ - 0) / var_8_6)
					arg_5_1.var_.alphaMatValueA03.color = arg_5_1.var_.alphaMatValueA03.color
				end
			end

			if arg_5_1.time_ >= 0 + var_8_6 and arg_5_1.time_ < 0 + var_8_6 + arg_8_0 and arg_5_1.var_.alphaMatValueA03 then
				arg_5_1.var_.alphaMatValueA03.color.a = 0
				arg_5_1.var_.alphaMatValueA03.color = arg_5_1.var_.alphaMatValueA03.color
			end

			local var_8_7 = arg_5_1.bgs_.A03.transform

			if 0.0333333333333333 < arg_5_1.time_ and arg_5_1.time_ <= 0.0333333333333333 + arg_8_0 then
				arg_5_1.var_.moveOldPosA03 = var_8_7.localPosition
			end

			local var_8_8 = 0.001

			if 0.0333333333333333 <= arg_5_1.time_ and arg_5_1.time_ < 0.0333333333333333 + var_8_8 then
				var_8_7.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPosA03, Vector3.New(0, 0, 0), (arg_5_1.time_ - 0.0333333333333333) / var_8_8)
			end

			if arg_5_1.time_ >= 0.0333333333333333 + var_8_8 and arg_5_1.time_ < 0.0333333333333333 + var_8_8 + arg_8_0 then
				var_8_7.localPosition = Vector3.New(0, 0, 0)
			end

			if 0.133333333333333 < arg_5_1.time_ and arg_5_1.time_ <= 0.133333333333333 + arg_8_0 then
				local var_8_9 = arg_5_1.bgs_.A02a:GetComponent("SpriteRenderer")

				if var_8_9 then
					arg_5_1.var_.alphaOldValueA02a = var_8_9.color.a
					arg_5_1.var_.alphaMatValueA02a = var_8_9
				end

				arg_5_1.var_.alphaOldValueA02a = 1
			end

			local var_8_10 = 1.86666666666667

			if 0.133333333333333 <= arg_5_1.time_ and arg_5_1.time_ < 0.133333333333333 + var_8_10 then
				if arg_5_1.var_.alphaMatValueA02a then
					arg_5_1.var_.alphaMatValueA02a.color.a = Mathf.Lerp(arg_5_1.var_.alphaOldValueA02a, 0, (arg_5_1.time_ - 0.133333333333333) / var_8_10)
					arg_5_1.var_.alphaMatValueA02a.color = arg_5_1.var_.alphaMatValueA02a.color
				end
			end

			if arg_5_1.time_ >= 0.133333333333333 + var_8_10 and arg_5_1.time_ < 0.133333333333333 + var_8_10 + arg_8_0 and arg_5_1.var_.alphaMatValueA02a then
				arg_5_1.var_.alphaMatValueA02a.color.a = 0
				arg_5_1.var_.alphaMatValueA02a.color = arg_5_1.var_.alphaMatValueA02a.color
			end

			if 0.133333333333333 < arg_5_1.time_ and arg_5_1.time_ <= 0.133333333333333 + arg_8_0 then
				local var_8_11 = arg_5_1.bgs_.A03:GetComponent("SpriteRenderer")

				if var_8_11 then
					arg_5_1.var_.alphaOldValueA03 = var_8_11.color.a
					arg_5_1.var_.alphaMatValueA03 = var_8_11
				end

				arg_5_1.var_.alphaOldValueA03 = 0
			end

			local var_8_12 = 1.86666666666667

			if 0.133333333333333 <= arg_5_1.time_ and arg_5_1.time_ < 0.133333333333333 + var_8_12 then
				if arg_5_1.var_.alphaMatValueA03 then
					arg_5_1.var_.alphaMatValueA03.color.a = Mathf.Lerp(arg_5_1.var_.alphaOldValueA03, 1, (arg_5_1.time_ - 0.133333333333333) / var_8_12)
					arg_5_1.var_.alphaMatValueA03.color = arg_5_1.var_.alphaMatValueA03.color
				end
			end

			if arg_5_1.time_ >= 0.133333333333333 + var_8_12 and arg_5_1.time_ < 0.133333333333333 + var_8_12 + arg_8_0 and arg_5_1.var_.alphaMatValueA03 then
				arg_5_1.var_.alphaMatValueA03.color.a = 1
				arg_5_1.var_.alphaMatValueA03.color = arg_5_1.var_.alphaMatValueA03.color
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
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = arg_9_1.bgs_.A00

				arg_9_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_1 = var_12_0:GetComponent("SpriteRenderer")

				if var_12_1 and var_12_1.sprite then
					local var_12_2 = 2 * (var_12_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_0.transform.localScale = Vector3.New(var_12_2 / var_12_1.sprite.bounds.size.y < var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x and var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x or var_12_2 / var_12_1.sprite.bounds.size.y, var_12_2 / var_12_1.sprite.bounds.size.y < var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x and var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x or var_12_2 / var_12_1.sprite.bounds.size.y, 0)
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
			if arg_17_1.bgs_.ST05 == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05")
				var_20_0.name = "ST05"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.ST05 = var_20_0
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.ST05

				arg_17_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST05" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 0
			local var_20_5 = 0.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_6 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_6:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(100).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 4 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 4)

				if (4 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 4)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9
					var_20_4 = var_20_4 + 0.3

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = var_20_4 + 0.3
			local var_20_11 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
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
			if arg_23_1.bgs_.ST05a == nil then
				local var_26_0 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05a")
				var_26_0.name = "ST05a"
				var_26_0.transform.parent = arg_23_1.stage_.transform
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_.ST05a = var_26_0
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_1 = arg_23_1.bgs_.ST05a

				arg_23_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_2 = var_26_1:GetComponent("SpriteRenderer")

				if var_26_2 and var_26_2.sprite then
					local var_26_3 = 2 * (var_26_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_1.transform.localScale = Vector3.New(var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "ST05a" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_4 = arg_23_1.bgs_.ST05.transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPosST05 = var_26_4.localPosition
			end

			local var_26_5 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_5 then
				var_26_4.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosST05, Vector3.New(0, -100, 10), (arg_23_1.time_ - 0) / var_26_5)
			end

			if arg_23_1.time_ >= 0 + var_26_5 and arg_23_1.time_ < 0 + var_26_5 + arg_26_0 then
				var_26_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_26_6 = 0
			local var_26_7 = 0.1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_8 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_8:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_9 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(100).content)

				arg_23_1.text_.text = var_26_9

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 4 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_9) / 4)

				if (4 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_9) / 4)) > 0 and var_26_7 < var_26_11 then
					arg_23_1.talkMaxDuration = var_26_11
					var_26_6 = var_26_6 + 0.3

					if var_26_11 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_11 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_9
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = var_26_6 + 0.3
			local var_26_13 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_13 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_12) / var_26_13

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_12 + var_26_13 and arg_23_1.time_ < var_26_12 + var_26_13 + arg_26_0 then
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
			if arg_29_1.bgs_.ST06 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_32_0.name = "ST06"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.ST06 = var_32_0
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.ST06

				arg_29_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST06" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = arg_29_1.bgs_.ST05a.transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPosST05a = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosST05a, Vector3.New(0, -100, 10), (arg_29_1.time_ - 0) / var_32_5)
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_32_6 = 0
			local var_32_7 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_8 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_8:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(100).content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 4 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 4)

				if (4 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 4)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11
					var_32_6 = var_32_6 + 0.3

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = var_32_6 + 0.3
			local var_32_13 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 then
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
			if arg_35_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_38_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_35_1.stage_.transform)

				var_38_0.name = "1148ui_story"
				var_38_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1148ui_story"] = var_38_0

				local var_38_1 = var_38_0:GetComponentInChildren(typeof(CharacterEffect))

				var_38_1.enabled = true

				local var_38_2 = GameObjectTools.GetOrAddComponent(var_38_0, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_1.transform, false)

				arg_35_1.var_["1148ui_story" .. "Animator"] = var_38_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_35_1.var_["1148ui_story" .. "LipSync"] = var_38_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_3 = arg_35_1.actors_["1148ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1148ui_story == nil then
				arg_35_1.var_.characterEffect1148ui_story = var_38_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_4 = 0.1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 and not isNil(var_38_3) then
				if arg_35_1.var_.characterEffect1148ui_story and not isNil(var_38_3) then
					arg_35_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1148ui_story then
				arg_35_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_38_6 = "1084ui_story"

			if arg_35_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_38_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_35_1.stage_.transform)

				var_38_7.name = var_38_6
				var_38_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_[var_38_6] = var_38_7

				local var_38_8 = var_38_7:GetComponentInChildren(typeof(CharacterEffect))

				var_38_8.enabled = true

				local var_38_9 = GameObjectTools.GetOrAddComponent(var_38_7, typeof(DynamicBoneHelper))

				if var_38_9 then
					var_38_9:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_8.transform, false)

				arg_35_1.var_[var_38_6 .. "Animator"] = var_38_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_[var_38_6 .. "Animator"].applyRootMotion = true
				arg_35_1.var_[var_38_6 .. "LipSync"] = var_38_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_10 = arg_35_1.actors_["1084ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_10) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_11 and not isNil(var_38_10) then
				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_10) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_11 and arg_35_1.time_ < 0 + var_38_11 + arg_38_0 and not isNil(var_38_10) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_38_13 = "ST06a"

			if arg_35_1.bgs_.ST06a == nil then
				local var_38_14 = Object.Instantiate(arg_35_1.paintGo_)

				var_38_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_38_13)
				var_38_14.name = var_38_13
				var_38_14.transform.parent = arg_35_1.stage_.transform
				var_38_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.bgs_[var_38_13] = var_38_14
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_15 = arg_35_1.bgs_.ST06a

				arg_35_1.bgs_.ST06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_38_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_38_16 = var_38_15:GetComponent("SpriteRenderer")

				if var_38_16 and var_38_16.sprite then
					local var_38_17 = 2 * (var_38_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_38_15.transform.localScale = Vector3.New(var_38_17 / var_38_16.sprite.bounds.size.y < var_38_17 * manager.ui.mainCameraCom_.aspect / var_38_16.sprite.bounds.size.x and var_38_17 * manager.ui.mainCameraCom_.aspect / var_38_16.sprite.bounds.size.x or var_38_17 / var_38_16.sprite.bounds.size.y, var_38_17 / var_38_16.sprite.bounds.size.y < var_38_17 * manager.ui.mainCameraCom_.aspect / var_38_16.sprite.bounds.size.x and var_38_17 * manager.ui.mainCameraCom_.aspect / var_38_16.sprite.bounds.size.x or var_38_17 / var_38_16.sprite.bounds.size.y, 0)
				end

				for iter_38_0, iter_38_1 in pairs(arg_35_1.bgs_) do
					if iter_38_0 ~= "ST06a" then
						iter_38_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_38_18 = arg_35_1.bgs_.ST06.transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPosST06 = var_38_18.localPosition
			end

			local var_38_19 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_19 then
				var_38_18.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosST06, Vector3.New(0, -100, 10), (arg_35_1.time_ - 0) / var_38_19)
			end

			if arg_35_1.time_ >= 0 + var_38_19 and arg_35_1.time_ < 0 + var_38_19 + arg_38_0 then
				var_38_18.localPosition = Vector3.New(0, -100, 10)
			end

			local var_38_20 = 0
			local var_38_21 = 0.1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_22 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_22:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_23 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(100).content)

				arg_35_1.text_.text = var_38_23

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_25 = 4 <= 0 and var_38_21 or var_38_21 * (utf8.len(var_38_23) / 4)

				if (4 <= 0 and var_38_21 or var_38_21 * (utf8.len(var_38_23) / 4)) > 0 and var_38_21 < var_38_25 then
					arg_35_1.talkMaxDuration = var_38_25
					var_38_20 = var_38_20 + 0.3

					if var_38_25 + var_38_20 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_25 + var_38_20
					end
				end

				arg_35_1.text_.text = var_38_23
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_26 = var_38_20 + 0.3
			local var_38_27 = math.max(var_38_21, arg_35_1.talkMaxDuration)

			if var_38_20 + 0.3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_26 + var_38_27 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_26) / var_38_27

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_26 + var_38_27 and arg_35_1.time_ < var_38_26 + var_38_27 + arg_38_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1148ui_story"]) and arg_41_1.var_.characterEffect1148ui_story == nil then
				arg_41_1.var_.characterEffect1148ui_story = arg_41_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1148ui_story"]) then
				if arg_41_1.var_.characterEffect1148ui_story and not isNil(arg_41_1.actors_["1148ui_story"]) then
					arg_41_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1148ui_story"]) and arg_41_1.var_.characterEffect1148ui_story then
				arg_41_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1084ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_44_5 = "ST06b"

			if arg_41_1.bgs_.ST06b == nil then
				local var_44_6 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_44_5)
				var_44_6.name = var_44_5
				var_44_6.transform.parent = arg_41_1.stage_.transform
				var_44_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_[var_44_5] = var_44_6
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_7 = arg_41_1.bgs_.ST06b

				arg_41_1.bgs_.ST06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_8 = var_44_7:GetComponent("SpriteRenderer")

				if var_44_8 and var_44_8.sprite then
					local var_44_9 = 2 * (var_44_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_7.transform.localScale = Vector3.New(var_44_9 / var_44_8.sprite.bounds.size.y < var_44_9 * manager.ui.mainCameraCom_.aspect / var_44_8.sprite.bounds.size.x and var_44_9 * manager.ui.mainCameraCom_.aspect / var_44_8.sprite.bounds.size.x or var_44_9 / var_44_8.sprite.bounds.size.y, var_44_9 / var_44_8.sprite.bounds.size.y < var_44_9 * manager.ui.mainCameraCom_.aspect / var_44_8.sprite.bounds.size.x and var_44_9 * manager.ui.mainCameraCom_.aspect / var_44_8.sprite.bounds.size.x or var_44_9 / var_44_8.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "ST06b" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_10 = arg_41_1.bgs_.ST06a.transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPosST06a = var_44_10.localPosition
			end

			local var_44_11 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_11 then
				var_44_10.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPosST06a, Vector3.New(0, -100, 10), (arg_41_1.time_ - 0) / var_44_11)
			end

			if arg_41_1.time_ >= 0 + var_44_11 and arg_41_1.time_ < 0 + var_44_11 + arg_44_0 then
				var_44_10.localPosition = Vector3.New(0, -100, 10)
			end

			local var_44_12 = 0
			local var_44_13 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_14 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_14:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(100).content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 4 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 4)

				if (4 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 4)) > 0 and var_44_13 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17
					var_44_12 = var_44_12 + 0.3

					if var_44_17 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = var_44_12 + 0.3
			local var_44_19 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_18 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_18) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_18 + var_44_19 and arg_41_1.time_ < var_44_18 + var_44_19 + arg_44_0 then
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
			if arg_47_1.bgs_.ST07a == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07a")
				var_50_0.name = "ST07a"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.ST07a = var_50_0
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.ST07a

				arg_47_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST07a" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0
			local var_50_5 = 0.1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_6 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_6:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(100).content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 4 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 4)

				if (4 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 4)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9
					var_50_4 = var_50_4 + 0.3

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = var_50_4 + 0.3
			local var_50_11 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_10) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 then
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
			if arg_53_1.bgs_.ST07b == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_56_0.name = "ST07b"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.ST07b = var_56_0
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.ST07b

				arg_53_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "ST07b" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 0
			local var_56_5 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_6 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_6:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(100).content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 4 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 4)

				if (4 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 4)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9
					var_56_4 = var_56_4 + 0.3

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = var_56_4 + 0.3
			local var_56_11 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
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
			if arg_59_1.bgs_.ST08 == nil then
				local var_62_0 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST08")
				var_62_0.name = "ST08"
				var_62_0.transform.parent = arg_59_1.stage_.transform
				var_62_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_.ST08 = var_62_0
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_1 = arg_59_1.bgs_.ST08

				arg_59_1.bgs_.ST08.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_2 = var_62_1:GetComponent("SpriteRenderer")

				if var_62_2 and var_62_2.sprite then
					local var_62_3 = 2 * (var_62_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_1.transform.localScale = Vector3.New(var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, var_62_3 / var_62_2.sprite.bounds.size.y < var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x and var_62_3 * manager.ui.mainCameraCom_.aspect / var_62_2.sprite.bounds.size.x or var_62_3 / var_62_2.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "ST08" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_4 = 0
			local var_62_5 = 0.1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_6 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_6:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_7 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(100).content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 4 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 4)

				if (4 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 4)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9
					var_62_4 = var_62_4 + 0.3

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = var_62_4 + 0.3
			local var_62_11 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_10) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 then
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
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1148ui_story"]) and arg_65_1.var_.characterEffect1148ui_story == nil then
				arg_65_1.var_.characterEffect1148ui_story = arg_65_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1148ui_story"]) then
				if arg_65_1.var_.characterEffect1148ui_story and not isNil(arg_65_1.actors_["1148ui_story"]) then
					arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1148ui_story"]) and arg_65_1.var_.characterEffect1148ui_story then
				arg_65_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1084ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_5 = arg_65_1.bgs_.ST08.transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPosST08 = var_68_5.localPosition
			end

			local var_68_6 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPosST08, Vector3.New(0, -100, 10), (arg_65_1.time_ - 0) / var_68_6)
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_68_7 = "ST12"

			if arg_65_1.bgs_.ST12 == nil then
				local var_68_8 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_7)
				var_68_8.name = var_68_7
				var_68_8.transform.parent = arg_65_1.stage_.transform
				var_68_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_7] = var_68_8
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_9 = arg_65_1.bgs_.ST12

				arg_65_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_10 = var_68_9:GetComponent("SpriteRenderer")

				if var_68_10 and var_68_10.sprite then
					local var_68_11 = 2 * (var_68_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_9.transform.localScale = Vector3.New(var_68_11 / var_68_10.sprite.bounds.size.y < var_68_11 * manager.ui.mainCameraCom_.aspect / var_68_10.sprite.bounds.size.x and var_68_11 * manager.ui.mainCameraCom_.aspect / var_68_10.sprite.bounds.size.x or var_68_11 / var_68_10.sprite.bounds.size.y, var_68_11 / var_68_10.sprite.bounds.size.y < var_68_11 * manager.ui.mainCameraCom_.aspect / var_68_10.sprite.bounds.size.x and var_68_11 * manager.ui.mainCameraCom_.aspect / var_68_10.sprite.bounds.size.x or var_68_11 / var_68_10.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "ST12" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action456")
			end

			local var_68_12 = 0
			local var_68_13 = 0.1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_14 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_14:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(100).content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 4 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 4)

				if (4 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 4)) > 0 and var_68_13 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17
					var_68_12 = var_68_12 + 0.3

					if var_68_17 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = var_68_12 + 0.3
			local var_68_19 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_18) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_18 + var_68_19 and arg_65_1.time_ < var_68_18 + var_68_19 + arg_68_0 then
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
