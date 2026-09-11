return {
	Play321291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321291001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.L09h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09h")
				var_4_0.name = "L09h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L09h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L09h

				arg_1_1.bgs_.L09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = manager.ui.mainCamera.transform

			if 1.61666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.61666666666667 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_9.localPosition
			end

			local var_4_10 = 1

			if 1.61666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.61666666666667 + var_4_10 then
				local var_4_11, var_4_12 = math.modf((arg_1_1.time_ - 1.61666666666667) / 0.066)

				var_4_9.localPosition = Vector3.New(var_4_12 * 0.13, var_4_12 * 0.13, var_4_12 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.61666666666667 + var_4_10 and arg_1_1.time_ < 1.61666666666667 + var_4_10 + arg_4_0 then
				var_4_9.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_13 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 0.616666666666667 and arg_1_1.time_ < var_4_13 + 0.616666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 1.61666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.61666666666667 + arg_4_0 then
				local var_4_14 = arg_1_1.var_.effectqiqiang1

				if not arg_1_1.var_.effectqiqiang1 then
					var_4_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_4_14.name = "qiqiang1"
					arg_1_1.var_.effectqiqiang1 = var_4_14
				else
					var_4_14.transform:SetParent(var_4_9000)
				end

				var_4_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.61666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 3.61666666666667 + arg_4_0 then
				if arg_1_1.var_.effectqiqiang1 then
					Object.Destroy(arg_1_1.var_.effectqiqiang1)

					arg_1_1.var_.effectqiqiang1 = nil
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.65 < arg_1_1.time_ and arg_1_1.time_ <= 1.65 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_hit", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 1.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(321291001).content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 58 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 58)

				if (58 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 58)) > 0 and var_4_25 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_24 = var_4_24 + 0.3

					if var_4_29 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_24 + 0.3
			local var_4_31 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321291002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.05 < arg_9_1.time_ and arg_9_1.time_ <= 0.05 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_141", "se_story_141_break", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321291002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 58 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 58)

				if (58 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 58)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321291003
		arg_13_1.duration_ = 2.27

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10130ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10130ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10130ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10130ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10130ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10130ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10130ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10130ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10130ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10130ui_story, Vector3.New(-0.03, -1.02, -5.81), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.03, -1.02, -5.81)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10130ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10130ui_story == nil then
				arg_13_1.var_.characterEffect10130ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10130ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10130ui_story then
				arg_13_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			local var_16_8 = 0
			local var_16_9 = 0.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(321291003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 2 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 2)

				if (2 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 2)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291003", "story_v_out_321291.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291003", "story_v_out_321291.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_321291", "321291003", "story_v_out_321291.awb")

						arg_13_1:RecordAudio("321291003", var_16_15)
						arg_13_1:RecordAudio("321291003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321291", "321291003", "story_v_out_321291.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321291", "321291003", "story_v_out_321291.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play321291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321291004
		arg_17_1.duration_ = 5.6

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10130ui_story = arg_17_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).z)
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles = arg_17_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10130ui_story"].transform.position).z)
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10130ui_story"].transform.localEulerAngles = arg_17_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10130ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10130ui_story == nil then
				arg_17_1.var_.characterEffect10130ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10130ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10130ui_story then
				arg_17_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			local var_20_3 = manager.ui.mainCamera.transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.shakeOldPos = var_20_3.localPosition
			end

			local var_20_4 = 0.6

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				local var_20_5, var_20_6 = math.modf((arg_17_1.time_ - 0) / 0.066)

				var_20_3.localPosition = Vector3.New(var_20_6 * 0.13, var_20_6 * 0.13, var_20_6 * 0.13) + arg_17_1.var_.shakeOldPos
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = arg_17_1.var_.shakeOldPos
			end

			local var_20_7 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_7 + 0.6 and arg_17_1.time_ < var_20_7 + 0.6 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_141", "se_story_141_arrow02", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_9 = 0.6
			local var_20_10 = 0.975

			if 0.6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_11 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_11:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(321291004).content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_14 = 39 <= 0 and var_20_10 or var_20_10 * (utf8.len(var_20_12) / 39)

				if (39 <= 0 and var_20_10 or var_20_10 * (utf8.len(var_20_12) / 39)) > 0 and var_20_10 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14
					var_20_9 = var_20_9 + 0.3

					if var_20_14 + var_20_9 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_9
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = var_20_9 + 0.3
			local var_20_16 = math.max(var_20_10, arg_17_1.talkMaxDuration)

			if var_20_9 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321291005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 321291005
		arg_23_1.duration_ = 2

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play321291006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1111ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1111ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1111ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1111ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1111ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1111ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1111ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1111ui_story == nil then
				arg_23_1.var_.characterEffect1111ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1111ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1111ui_story then
				arg_23_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(321291005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 4 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 4)

				if (4 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 4)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291005", "story_v_out_321291.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291005", "story_v_out_321291.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_321291", "321291005", "story_v_out_321291.awb")

						arg_23_1:RecordAudio("321291005", var_26_15)
						arg_23_1:RecordAudio("321291005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_321291", "321291005", "story_v_out_321291.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_321291", "321291005", "story_v_out_321291.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play321291006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 321291006
		arg_27_1.duration_ = 2.2

		local var_27_0 = {
			zh = 2.2,
			ja = 1.999999999999
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play321291007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1111ui_story = arg_27_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).z)
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles = arg_27_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_27_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1111ui_story"].transform.position).z)
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1111ui_story"].transform.localEulerAngles = arg_27_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_30_1 = "10131ui_story"

			if arg_27_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_27_1.stage_.transform)

				var_30_2.name = var_30_1
				var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_[var_30_1] = var_30_2

				local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

				var_30_3.enabled = true

				local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

				if var_30_4 then
					var_30_4:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_3.transform, false)

				arg_27_1.var_[var_30_1 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_[var_30_1 .. "Animator"].applyRootMotion = true
				arg_27_1.var_[var_30_1 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_5 = arg_27_1.actors_["10131ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10131ui_story = var_30_5.localPosition
			end

			local var_30_6 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 then
				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_27_1.time_ - 0) / var_30_6)
				var_30_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_5.position).x, (manager.ui.mainCamera.transform.position - var_30_5.position).y, (manager.ui.mainCamera.transform.position - var_30_5.position).z)
				var_30_5.localEulerAngles.z = 0
				var_30_5.localEulerAngles.x = 0
				var_30_5.localEulerAngles = var_30_5.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_30_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_5.position).x, (manager.ui.mainCamera.transform.position - var_30_5.position).y, (manager.ui.mainCamera.transform.position - var_30_5.position).z)
				var_30_5.localEulerAngles.z = 0
				var_30_5.localEulerAngles.x = 0
				var_30_5.localEulerAngles = var_30_5.localEulerAngles
			end

			local var_30_7 = arg_27_1.actors_["10131ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.characterEffect10131ui_story == nil then
				arg_27_1.var_.characterEffect10131ui_story = var_30_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_8 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_8 and not isNil(var_30_7) then
				if arg_27_1.var_.characterEffect10131ui_story and not isNil(var_30_7) then
					arg_27_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_8 and arg_27_1.time_ < 0 + var_30_8 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.characterEffect10131ui_story then
				arg_27_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_30_10 = arg_27_1.actors_["1111ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1111ui_story == nil then
				arg_27_1.var_.characterEffect1111ui_story = var_30_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_11 and not isNil(var_30_10) then
				if arg_27_1.var_.characterEffect1111ui_story and not isNil(var_30_10) then
					arg_27_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_11)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_11 and arg_27_1.time_ < 0 + var_30_11 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect1111ui_story then
				arg_27_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_30_12 = 0
			local var_30_13 = 0.3

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_14 = arg_27_1:GetWordFromCfg(321291006)
				local var_30_15 = arg_27_1:FormatText(var_30_14.content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 12 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 12)

				if (12 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 12)) > 0 and var_30_13 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17

					if var_30_17 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291006", "story_v_out_321291.awb") ~= 0 then
					local var_30_18 = manager.audio:GetVoiceLength("story_v_out_321291", "321291006", "story_v_out_321291.awb") / 1000

					if var_30_18 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_12
					end

					if var_30_14.prefab_name ~= "" and arg_27_1.actors_[var_30_14.prefab_name] ~= nil then
						local var_30_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_14.prefab_name].transform, "story_v_out_321291", "321291006", "story_v_out_321291.awb")

						arg_27_1:RecordAudio("321291006", var_30_19)
						arg_27_1:RecordAudio("321291006", var_30_19)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_321291", "321291006", "story_v_out_321291.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_321291", "321291006", "story_v_out_321291.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_20 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_20 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_12) / var_30_20

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_12 + var_30_20 and arg_27_1.time_ < var_30_12 + var_30_20 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play321291007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 321291007
		arg_31_1.duration_ = 2

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play321291008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10131ui_story = arg_31_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).z)
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles = arg_31_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10131ui_story"].transform.position).z)
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["10131ui_story"].transform.localEulerAngles = arg_31_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1111ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1111ui_story = var_34_1.localPosition
			end

			local var_34_2 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_31_1.time_ - 0) / var_34_2)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			local var_34_3 = "1043ui_story"

			if arg_31_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_34_4 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_31_1.stage_.transform)

				var_34_4.name = var_34_3
				var_34_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_[var_34_3] = var_34_4

				local var_34_5 = var_34_4:GetComponentInChildren(typeof(CharacterEffect))

				var_34_5.enabled = true

				local var_34_6 = GameObjectTools.GetOrAddComponent(var_34_4, typeof(DynamicBoneHelper))

				if var_34_6 then
					var_34_6:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_5.transform, false)

				arg_31_1.var_[var_34_3 .. "Animator"] = var_34_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_[var_34_3 .. "Animator"].applyRootMotion = true
				arg_31_1.var_[var_34_3 .. "LipSync"] = var_34_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_7 = arg_31_1.actors_["1043ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1043ui_story = var_34_7.localPosition
			end

			local var_34_8 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_8 then
				var_34_7.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_31_1.time_ - 0) / var_34_8)
				var_34_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_7.position).x, (manager.ui.mainCamera.transform.position - var_34_7.position).y, (manager.ui.mainCamera.transform.position - var_34_7.position).z)
				var_34_7.localEulerAngles.z = 0
				var_34_7.localEulerAngles.x = 0
				var_34_7.localEulerAngles = var_34_7.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_8 and arg_31_1.time_ < 0 + var_34_8 + arg_34_0 then
				var_34_7.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_34_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_7.position).x, (manager.ui.mainCamera.transform.position - var_34_7.position).y, (manager.ui.mainCamera.transform.position - var_34_7.position).z)
				var_34_7.localEulerAngles.z = 0
				var_34_7.localEulerAngles.x = 0
				var_34_7.localEulerAngles = var_34_7.localEulerAngles
			end

			local var_34_9 = arg_31_1.actors_["1043ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1043ui_story == nil then
				arg_31_1.var_.characterEffect1043ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_10 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_10 and not isNil(var_34_9) then
				if arg_31_1.var_.characterEffect1043ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_10 and arg_31_1.time_ < 0 + var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1043ui_story then
				arg_31_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_34_12 = arg_31_1.actors_["10131ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_12) and arg_31_1.var_.characterEffect10131ui_story == nil then
				arg_31_1.var_.characterEffect10131ui_story = var_34_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_13 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_13 and not isNil(var_34_12) then
				if arg_31_1.var_.characterEffect10131ui_story and not isNil(var_34_12) then
					arg_31_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_31_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_13)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_13 and arg_31_1.time_ < 0 + var_34_13 + arg_34_0 and not isNil(var_34_12) and arg_31_1.var_.characterEffect10131ui_story then
				arg_31_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_31_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_34_14 = 0
			local var_34_15 = 0.1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_16 = arg_31_1:GetWordFromCfg(321291007)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_19 = 4 <= 0 and var_34_15 or var_34_15 * (utf8.len(var_34_17) / 4)

				if (4 <= 0 and var_34_15 or var_34_15 * (utf8.len(var_34_17) / 4)) > 0 and var_34_15 < var_34_19 then
					arg_31_1.talkMaxDuration = var_34_19

					if var_34_19 + var_34_14 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_14
					end
				end

				arg_31_1.text_.text = var_34_17
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291007", "story_v_out_321291.awb") ~= 0 then
					local var_34_20 = manager.audio:GetVoiceLength("story_v_out_321291", "321291007", "story_v_out_321291.awb") / 1000

					if var_34_20 + var_34_14 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_14
					end

					if var_34_16.prefab_name ~= "" and arg_31_1.actors_[var_34_16.prefab_name] ~= nil then
						local var_34_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_16.prefab_name].transform, "story_v_out_321291", "321291007", "story_v_out_321291.awb")

						arg_31_1:RecordAudio("321291007", var_34_21)
						arg_31_1:RecordAudio("321291007", var_34_21)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_321291", "321291007", "story_v_out_321291.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_321291", "321291007", "story_v_out_321291.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = math.max(var_34_15, arg_31_1.talkMaxDuration)

			if var_34_14 <= arg_31_1.time_ and arg_31_1.time_ < var_34_14 + var_34_22 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_14) / var_34_22

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_14 + var_34_22 and arg_31_1.time_ < var_34_14 + var_34_22 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play321291008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 321291008
		arg_35_1.duration_ = 4.97

		local var_35_0 = {
			zh = 4.966,
			ja = 4.266
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play321291009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1111ui_story = arg_35_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).z)
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles = arg_35_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_35_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1111ui_story"].transform.position).z)
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1111ui_story"].transform.localEulerAngles = arg_35_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1043ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1043ui_story = var_38_1.localPosition
			end

			local var_38_2 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 then
				var_38_1.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_35_1.time_ - 0) / var_38_2)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 then
				var_38_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			local var_38_3 = arg_35_1.actors_["1111ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1111ui_story == nil then
				arg_35_1.var_.characterEffect1111ui_story = var_38_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_4 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 and not isNil(var_38_3) then
				if arg_35_1.var_.characterEffect1111ui_story and not isNil(var_38_3) then
					arg_35_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1111ui_story then
				arg_35_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_38_6 = arg_35_1.actors_["1043ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1043ui_story == nil then
				arg_35_1.var_.characterEffect1043ui_story = var_38_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_7 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 and not isNil(var_38_6) then
				if arg_35_1.var_.characterEffect1043ui_story and not isNil(var_38_6) then
					arg_35_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_7)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1043ui_story then
				arg_35_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_38_8 = 0
			local var_38_9 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(321291008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 16 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 16)

				if (16 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 16)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291008", "story_v_out_321291.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291008", "story_v_out_321291.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_321291", "321291008", "story_v_out_321291.awb")

						arg_35_1:RecordAudio("321291008", var_38_15)
						arg_35_1:RecordAudio("321291008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_321291", "321291008", "story_v_out_321291.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_321291", "321291008", "story_v_out_321291.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play321291009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321291009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321291010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1111ui_story = arg_39_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).z)
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles = arg_39_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1111ui_story"].transform.position).z)
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1111ui_story"].transform.localEulerAngles = arg_39_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1043ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1043ui_story = var_42_1.localPosition
			end

			local var_42_2 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 then
				var_42_1.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_2)
				var_42_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_1.position).x, (manager.ui.mainCamera.transform.position - var_42_1.position).y, (manager.ui.mainCamera.transform.position - var_42_1.position).z)
				var_42_1.localEulerAngles.z = 0
				var_42_1.localEulerAngles.x = 0
				var_42_1.localEulerAngles = var_42_1.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 then
				var_42_1.localPosition = Vector3.New(0, 100, 0)
				var_42_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_1.position).x, (manager.ui.mainCamera.transform.position - var_42_1.position).y, (manager.ui.mainCamera.transform.position - var_42_1.position).z)
				var_42_1.localEulerAngles.z = 0
				var_42_1.localEulerAngles.x = 0
				var_42_1.localEulerAngles = var_42_1.localEulerAngles
			end

			local var_42_3 = arg_39_1.actors_["1111ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect1111ui_story == nil then
				arg_39_1.var_.characterEffect1111ui_story = var_42_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_4 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 and not isNil(var_42_3) then
				if arg_39_1.var_.characterEffect1111ui_story and not isNil(var_42_3) then
					arg_39_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_4)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect1111ui_story then
				arg_39_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_42_5 = 0
			local var_42_6 = 1.525

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(321291009).content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 61 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 61)

				if (61 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 61)) > 0 and var_42_6 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_10 and arg_39_1.time_ < var_42_5 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play321291010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321291010
		arg_43_1.duration_ = 6.8

		local var_43_0 = {
			zh = 2.6,
			ja = 6.8
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321291011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10130ui_story = arg_43_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10130ui_story, Vector3.New(-0.03, -1.02, -5.81), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).z)
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles = arg_43_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.81)
				arg_43_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10130ui_story"].transform.position).z)
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10130ui_story"].transform.localEulerAngles = arg_43_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["10130ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10130ui_story == nil then
				arg_43_1.var_.characterEffect10130ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect10130ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10130ui_story then
				arg_43_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action9_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_46_4 = 0
			local var_46_5 = 0.2

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(321291010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 8 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 8)

				if (8 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 8)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291010", "story_v_out_321291.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291010", "story_v_out_321291.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_321291", "321291010", "story_v_out_321291.awb")

						arg_43_1:RecordAudio("321291010", var_46_11)
						arg_43_1:RecordAudio("321291010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_321291", "321291010", "story_v_out_321291.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_321291", "321291010", "story_v_out_321291.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play321291011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321291011
		arg_47_1.duration_ = 9.93

		local var_47_0 = {
			zh = 4.9,
			ja = 9.933
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321291012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(321291011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)

				if (16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291011", "story_v_out_321291.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291011", "story_v_out_321291.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_321291", "321291011", "story_v_out_321291.awb")

						arg_47_1:RecordAudio("321291011", var_50_6)
						arg_47_1:RecordAudio("321291011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321291", "321291011", "story_v_out_321291.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321291", "321291011", "story_v_out_321291.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play321291012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321291012
		arg_51_1.duration_ = 5.23

		local var_51_0 = {
			zh = 4.933,
			ja = 5.233
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321291013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1111ui_story = arg_51_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).z)
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles = arg_51_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_51_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1111ui_story"].transform.position).z)
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1111ui_story"].transform.localEulerAngles = arg_51_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["10130ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10130ui_story = var_54_1.localPosition
			end

			local var_54_2 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_51_1.time_ - 0) / var_54_2)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(0.77, -1.02, -5.81)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			local var_54_3 = arg_51_1.actors_["1111ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1111ui_story == nil then
				arg_51_1.var_.characterEffect1111ui_story = var_54_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_4 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 and not isNil(var_54_3) then
				if arg_51_1.var_.characterEffect1111ui_story and not isNil(var_54_3) then
					arg_51_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1111ui_story then
				arg_51_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_54_6 = arg_51_1.actors_["10130ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect10130ui_story == nil then
				arg_51_1.var_.characterEffect10130ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_7 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 and not isNil(var_54_6) then
				if arg_51_1.var_.characterEffect10130ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_7)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect10130ui_story then
				arg_51_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_54_8 = 0
			local var_54_9 = 0.475

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(321291012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 19 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 19)

				if (19 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 19)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291012", "story_v_out_321291.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291012", "story_v_out_321291.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_321291", "321291012", "story_v_out_321291.awb")

						arg_51_1:RecordAudio("321291012", var_54_15)
						arg_51_1:RecordAudio("321291012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321291", "321291012", "story_v_out_321291.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321291", "321291012", "story_v_out_321291.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play321291013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321291013
		arg_55_1.duration_ = 14.3

		local var_55_0 = {
			zh = 9.766,
			ja = 14.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321291014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.925

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(321291013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 37 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 37)

				if (37 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 37)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291013", "story_v_out_321291.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291013", "story_v_out_321291.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_321291", "321291013", "story_v_out_321291.awb")

						arg_55_1:RecordAudio("321291013", var_58_6)
						arg_55_1:RecordAudio("321291013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321291", "321291013", "story_v_out_321291.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321291", "321291013", "story_v_out_321291.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play321291014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321291014
		arg_59_1.duration_ = 21.53

		local var_59_0 = {
			zh = 9.566,
			ja = 21.533
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321291015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1111ui_story = arg_59_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).z)
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles = arg_59_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_59_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1111ui_story"].transform.position).z)
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1111ui_story"].transform.localEulerAngles = arg_59_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["10130ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10130ui_story = var_62_1.localPosition
			end

			local var_62_2 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 then
				var_62_1.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_59_1.time_ - 0) / var_62_2)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 then
				var_62_1.localPosition = Vector3.New(0.77, -1.02, -5.81)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			local var_62_3 = arg_59_1.actors_["10130ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_3) and arg_59_1.var_.characterEffect10130ui_story == nil then
				arg_59_1.var_.characterEffect10130ui_story = var_62_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_4 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 and not isNil(var_62_3) then
				if arg_59_1.var_.characterEffect10130ui_story and not isNil(var_62_3) then
					arg_59_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 and not isNil(var_62_3) and arg_59_1.var_.characterEffect10130ui_story then
				arg_59_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_62_6 = arg_59_1.actors_["1111ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1111ui_story == nil then
				arg_59_1.var_.characterEffect1111ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect1111ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1111ui_story then
				arg_59_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130actionlink/10130action496")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_62_8 = 0
			local var_62_9 = 0.775

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(321291014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 31 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 31)

				if (31 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 31)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291014", "story_v_out_321291.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291014", "story_v_out_321291.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_321291", "321291014", "story_v_out_321291.awb")

						arg_59_1:RecordAudio("321291014", var_62_15)
						arg_59_1:RecordAudio("321291014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321291", "321291014", "story_v_out_321291.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321291", "321291014", "story_v_out_321291.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play321291015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321291015
		arg_63_1.duration_ = 5.53

		local var_63_0 = {
			zh = 4.033,
			ja = 5.533
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321291016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1111ui_story"]) and arg_63_1.var_.characterEffect1111ui_story == nil then
				arg_63_1.var_.characterEffect1111ui_story = arg_63_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1111ui_story"]) then
				if arg_63_1.var_.characterEffect1111ui_story and not isNil(arg_63_1.actors_["1111ui_story"]) then
					arg_63_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1111ui_story"]) and arg_63_1.var_.characterEffect1111ui_story then
				arg_63_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["10130ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10130ui_story == nil then
				arg_63_1.var_.characterEffect10130ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect10130ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10130ui_story then
				arg_63_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action424")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_66_4 = 0
			local var_66_5 = 0.325

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(321291015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 13 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 13)

				if (13 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 13)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291015", "story_v_out_321291.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291015", "story_v_out_321291.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_321291", "321291015", "story_v_out_321291.awb")

						arg_63_1:RecordAudio("321291015", var_66_11)
						arg_63_1:RecordAudio("321291015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321291", "321291015", "story_v_out_321291.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321291", "321291015", "story_v_out_321291.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321291016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321291016
		arg_67_1.duration_ = 4.93

		local var_67_0 = {
			zh = 3.633,
			ja = 4.933
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321291017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10130ui_story"]) and arg_67_1.var_.characterEffect10130ui_story == nil then
				arg_67_1.var_.characterEffect10130ui_story = arg_67_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10130ui_story"]) then
				if arg_67_1.var_.characterEffect10130ui_story and not isNil(arg_67_1.actors_["10130ui_story"]) then
					arg_67_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10130ui_story"]) and arg_67_1.var_.characterEffect10130ui_story then
				arg_67_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_70_2 = arg_67_1.actors_["1111ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1111ui_story == nil then
				arg_67_1.var_.characterEffect1111ui_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_3 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.characterEffect1111ui_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_3)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1111ui_story then
				arg_67_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action6_2")
			end

			local var_70_4 = 0
			local var_70_5 = 0.2

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(321291016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 8 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 8)

				if (8 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 8)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291016", "story_v_out_321291.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291016", "story_v_out_321291.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_321291", "321291016", "story_v_out_321291.awb")

						arg_67_1:RecordAudio("321291016", var_70_11)
						arg_67_1:RecordAudio("321291016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321291", "321291016", "story_v_out_321291.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321291", "321291016", "story_v_out_321291.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321291017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321291017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321291018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1111ui_story = arg_71_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).z)
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles = arg_71_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1111ui_story"].transform.position).z)
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1111ui_story"].transform.localEulerAngles = arg_71_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10130ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10130ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0, 100, 0)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			local var_74_3 = arg_71_1.actors_["10130ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect10130ui_story == nil then
				arg_71_1.var_.characterEffect10130ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect10130ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_4)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect10130ui_story then
				arg_71_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_71_1.time_ and arg_71_1.time_ <= 0.200000002980232 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_141", "se_story_141_baqin_battle", "")
			end

			local var_74_6 = 0
			local var_74_7 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(321291017).content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 42 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 42)

				if (42 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 42)) > 0 and var_74_7 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_11 and arg_71_1.time_ < var_74_6 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play321291018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321291018
		arg_75_1.duration_ = 5.72

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321291019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_0 = arg_75_1.var_.effectzhengan1

				if not arg_75_1.var_.effectzhengan1 then
					var_78_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_78_0.name = "zhengan1"
					arg_75_1.var_.effectzhengan1 = var_78_0
				else
					var_78_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_78_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_78_2 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_2 + 1.999999999999 and arg_75_1.time_ < var_78_2 + 1.999999999999 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_3 = manager.ui.mainCamera.transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_3.localPosition
			end

			local var_78_4 = 0.7

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				local var_78_5, var_78_6 = math.modf((arg_75_1.time_ - 0) / 0.066)

				var_78_3.localPosition = Vector3.New(var_78_6 * 0.13, var_78_6 * 0.13, var_78_6 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = arg_75_1.var_.shakeOldPos
			end

			if 0.05 < arg_75_1.time_ and arg_75_1.time_ <= 0.05 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_141", "se_story_141_metalhit", "")
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_8 = 0.725
			local var_78_9 = 1.275

			if 0.725 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_10 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_10:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_11 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(321291018).content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 51 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 51)

				if (51 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 51)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13
					var_78_8 = var_78_8 + 0.3

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = var_78_8 + 0.3
			local var_78_15 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_14) / var_78_15

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321291019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321291019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play321291020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(321291019).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 46)

				if (46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 46)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play321291020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321291020
		arg_85_1.duration_ = 5.1

		local var_85_0 = {
			zh = 4.333,
			ja = 5.1
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play321291021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1111ui_story = arg_85_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).z)
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles = arg_85_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_85_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).z)
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles = arg_85_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10130ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10130ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0.77, -1.02, -5.81)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			local var_88_3 = arg_85_1.actors_["1111ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1111ui_story == nil then
				arg_85_1.var_.characterEffect1111ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect1111ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1111ui_story then
				arg_85_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_88_6 = arg_85_1.actors_["10130ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect10130ui_story == nil then
				arg_85_1.var_.characterEffect10130ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_7 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 and not isNil(var_88_6) then
				if arg_85_1.var_.characterEffect10130ui_story and not isNil(var_88_6) then
					arg_85_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_7)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect10130ui_story then
				arg_85_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			local var_88_8 = 0
			local var_88_9 = 0.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(321291020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 15 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 15)

				if (15 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 15)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291020", "story_v_out_321291.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291020", "story_v_out_321291.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_321291", "321291020", "story_v_out_321291.awb")

						arg_85_1:RecordAudio("321291020", var_88_15)
						arg_85_1:RecordAudio("321291020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321291", "321291020", "story_v_out_321291.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321291", "321291020", "story_v_out_321291.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play321291021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321291021
		arg_89_1.duration_ = 5.3

		local var_89_0 = {
			zh = 3.466,
			ja = 5.3
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play321291022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10130ui_story"]) and arg_89_1.var_.characterEffect10130ui_story == nil then
				arg_89_1.var_.characterEffect10130ui_story = arg_89_1.actors_["10130ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10130ui_story"]) then
				if arg_89_1.var_.characterEffect10130ui_story and not isNil(arg_89_1.actors_["10130ui_story"]) then
					arg_89_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10130ui_story"]) and arg_89_1.var_.characterEffect10130ui_story then
				arg_89_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["1111ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1111ui_story == nil then
				arg_89_1.var_.characterEffect1111ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1111ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1111ui_story then
				arg_89_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(321291021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 11 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 11)

				if (11 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 11)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291021", "story_v_out_321291.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291021", "story_v_out_321291.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_321291", "321291021", "story_v_out_321291.awb")

						arg_89_1:RecordAudio("321291021", var_92_11)
						arg_89_1:RecordAudio("321291021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321291", "321291021", "story_v_out_321291.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321291", "321291021", "story_v_out_321291.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321291022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321291022
		arg_93_1.duration_ = 8.5

		local var_93_0 = {
			zh = 3.866,
			ja = 8.5
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321291023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(321291022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 12 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 12)

				if (12 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 12)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291022", "story_v_out_321291.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291022", "story_v_out_321291.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_321291", "321291022", "story_v_out_321291.awb")

						arg_93_1:RecordAudio("321291022", var_96_6)
						arg_93_1:RecordAudio("321291022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321291", "321291022", "story_v_out_321291.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321291", "321291022", "story_v_out_321291.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play321291023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321291023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321291024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1111ui_story = arg_97_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).z)
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles = arg_97_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1111ui_story"].transform.position).z)
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1111ui_story"].transform.localEulerAngles = arg_97_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10130ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10130ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(0, 100, 0)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = arg_97_1.actors_["10130ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10130ui_story == nil then
				arg_97_1.var_.characterEffect10130ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect10130ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_4)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10130ui_story then
				arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			local var_100_5 = 0
			local var_100_6 = 1.425

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(321291023).content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 57 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 57)

				if (57 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_7) / 57)) > 0 and var_100_6 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_10 and arg_97_1.time_ < var_100_5 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play321291024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321291024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play321291025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.75

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(321291024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 30 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 30)

				if (30 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 30)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321291025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321291025
		arg_105_1.duration_ = 6.5

		local var_105_0 = {
			zh = 6.5,
			ja = 6.033
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321291026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1111ui_story = arg_105_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).z)
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles = arg_105_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_105_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1111ui_story"].transform.position).z)
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1111ui_story"].transform.localEulerAngles = arg_105_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1111ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1111ui_story == nil then
				arg_105_1.var_.characterEffect1111ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1111ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1111ui_story then
				arg_105_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.6

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(321291025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 24 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 24)

				if (24 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 24)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291025", "story_v_out_321291.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291025", "story_v_out_321291.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_321291", "321291025", "story_v_out_321291.awb")

						arg_105_1:RecordAudio("321291025", var_108_11)
						arg_105_1:RecordAudio("321291025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321291", "321291025", "story_v_out_321291.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321291", "321291025", "story_v_out_321291.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play321291026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321291026
		arg_109_1.duration_ = 5.93

		local var_109_0 = {
			zh = 4.7,
			ja = 5.933
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321291027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.475

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(321291026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 19 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 19)

				if (19 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 19)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291026", "story_v_out_321291.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291026", "story_v_out_321291.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_321291", "321291026", "story_v_out_321291.awb")

						arg_109_1:RecordAudio("321291026", var_112_6)
						arg_109_1:RecordAudio("321291026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321291", "321291026", "story_v_out_321291.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321291", "321291026", "story_v_out_321291.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321291027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321291027
		arg_113_1.duration_ = 2

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321291028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1111ui_story = arg_113_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10131ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10131ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = arg_113_1.actors_["10131ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect10131ui_story == nil then
				arg_113_1.var_.characterEffect10131ui_story = var_116_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 and not isNil(var_116_3) then
				if arg_113_1.var_.characterEffect10131ui_story and not isNil(var_116_3) then
					arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect10131ui_story then
				arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_116_6 = arg_113_1.actors_["1111ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_116_8 = 0
			local var_116_9 = 0.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(321291027)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 5 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 5)

				if (5 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 5)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291027", "story_v_out_321291.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291027", "story_v_out_321291.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_321291", "321291027", "story_v_out_321291.awb")

						arg_113_1:RecordAudio("321291027", var_116_15)
						arg_113_1:RecordAudio("321291027", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321291", "321291027", "story_v_out_321291.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321291", "321291027", "story_v_out_321291.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play321291028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321291028
		arg_117_1.duration_ = 4.13

		local var_117_0 = {
			zh = 4.133,
			ja = 4
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321291029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) and arg_117_1.var_.characterEffect1111ui_story == nil then
				arg_117_1.var_.characterEffect1111ui_story = arg_117_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) then
				if arg_117_1.var_.characterEffect1111ui_story and not isNil(arg_117_1.actors_["1111ui_story"]) then
					arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) and arg_117_1.var_.characterEffect1111ui_story then
				arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["10131ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10131ui_story == nil then
				arg_117_1.var_.characterEffect10131ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect10131ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10131ui_story then
				arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_120_4 = 0
			local var_120_5 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(321291028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 23 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 23)

				if (23 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 23)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291028", "story_v_out_321291.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291028", "story_v_out_321291.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_321291", "321291028", "story_v_out_321291.awb")

						arg_117_1:RecordAudio("321291028", var_120_11)
						arg_117_1:RecordAudio("321291028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321291", "321291028", "story_v_out_321291.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321291", "321291028", "story_v_out_321291.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321291029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321291029
		arg_121_1.duration_ = 1.07

		local var_121_0 = {
			zh = 1.066,
			ja = 0.999999999999
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play321291030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10131ui_story"]) and arg_121_1.var_.characterEffect10131ui_story == nil then
				arg_121_1.var_.characterEffect10131ui_story = arg_121_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10131ui_story"]) then
				if arg_121_1.var_.characterEffect10131ui_story and not isNil(arg_121_1.actors_["10131ui_story"]) then
					arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10131ui_story"]) and arg_121_1.var_.characterEffect10131ui_story then
				arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1111ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1111ui_story then
				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(321291029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 4 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 4)

				if (4 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 4)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291029", "story_v_out_321291.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291029", "story_v_out_321291.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_321291", "321291029", "story_v_out_321291.awb")

						arg_121_1:RecordAudio("321291029", var_124_11)
						arg_121_1:RecordAudio("321291029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321291", "321291029", "story_v_out_321291.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321291", "321291029", "story_v_out_321291.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play321291030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321291030
		arg_125_1.duration_ = 2

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play321291031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) and arg_125_1.var_.characterEffect1111ui_story == nil then
				arg_125_1.var_.characterEffect1111ui_story = arg_125_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) then
				if arg_125_1.var_.characterEffect1111ui_story and not isNil(arg_125_1.actors_["1111ui_story"]) then
					arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) and arg_125_1.var_.characterEffect1111ui_story then
				arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["10131ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10131ui_story == nil then
				arg_125_1.var_.characterEffect10131ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect10131ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10131ui_story then
				arg_125_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(321291030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 6 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 6)

				if (6 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 6)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291030", "story_v_out_321291.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291030", "story_v_out_321291.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_321291", "321291030", "story_v_out_321291.awb")

						arg_125_1:RecordAudio("321291030", var_128_11)
						arg_125_1:RecordAudio("321291030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321291", "321291030", "story_v_out_321291.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321291", "321291030", "story_v_out_321291.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321291031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321291031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321291032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1111ui_story = arg_129_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).z)
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles = arg_129_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1111ui_story"].transform.position).z)
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1111ui_story"].transform.localEulerAngles = arg_129_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10131ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10131ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, 100, 0)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			local var_132_3 = arg_129_1.actors_["1111ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1111ui_story == nil then
				arg_129_1.var_.characterEffect1111ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect1111ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_4)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1111ui_story then
				arg_129_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_132_5 = 0
			local var_132_6 = 0.925

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(321291031).content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 37 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_7) / 37)

				if (37 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_7) / 37)) > 0 and var_132_6 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_10 and arg_129_1.time_ < var_132_5 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play321291032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321291032
		arg_133_1.duration_ = 5.27

		local var_133_0 = {
			zh = 3.733,
			ja = 5.266
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play321291033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10130ui_story = arg_133_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10130ui_story, Vector3.New(-0.03, -1.02, -5.81), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).z)
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles = arg_133_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.81)
				arg_133_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).z)
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles = arg_133_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10130ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10130ui_story == nil then
				arg_133_1.var_.characterEffect10130ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10130ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10130ui_story then
				arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action3_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_4 = 0
			local var_136_5 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(321291032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)

				if (10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291032", "story_v_out_321291.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_321291", "321291032", "story_v_out_321291.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_321291", "321291032", "story_v_out_321291.awb")

						arg_133_1:RecordAudio("321291032", var_136_11)
						arg_133_1:RecordAudio("321291032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321291", "321291032", "story_v_out_321291.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321291", "321291032", "story_v_out_321291.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play321291033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321291033
		arg_137_1.duration_ = 7.4

		local var_137_0 = {
			zh = 5.666,
			ja = 7.4
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321291034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1111ui_story = arg_137_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10130ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10130ui_story = var_140_1.localPosition
			end

			local var_140_2 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 then
				var_140_1.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_137_1.time_ - 0) / var_140_2)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 then
				var_140_1.localPosition = Vector3.New(0.77, -1.02, -5.81)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			local var_140_3 = arg_137_1.actors_["1111ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1111ui_story == nil then
				arg_137_1.var_.characterEffect1111ui_story = var_140_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_4 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 and not isNil(var_140_3) then
				if arg_137_1.var_.characterEffect1111ui_story and not isNil(var_140_3) then
					arg_137_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1111ui_story then
				arg_137_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_140_6 = arg_137_1.actors_["10130ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10130ui_story == nil then
				arg_137_1.var_.characterEffect10130ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 and not isNil(var_140_6) then
				if arg_137_1.var_.characterEffect10130ui_story and not isNil(var_140_6) then
					arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_7)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10130ui_story then
				arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_140_8 = 0
			local var_140_9 = 0.6

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(321291033)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 24 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 24)

				if (24 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 24)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291033", "story_v_out_321291.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_321291", "321291033", "story_v_out_321291.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_321291", "321291033", "story_v_out_321291.awb")

						arg_137_1:RecordAudio("321291033", var_140_15)
						arg_137_1:RecordAudio("321291033", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321291", "321291033", "story_v_out_321291.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321291", "321291033", "story_v_out_321291.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play321291034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321291034
		arg_141_1.duration_ = 2

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321291035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1111ui_story = arg_141_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).z)
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles = arg_141_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_141_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).z)
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles = arg_141_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10130ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10130ui_story = var_144_1.localPosition
			end

			local var_144_2 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 then
				var_144_1.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_2)
				var_144_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_1.position).x, (manager.ui.mainCamera.transform.position - var_144_1.position).y, (manager.ui.mainCamera.transform.position - var_144_1.position).z)
				var_144_1.localEulerAngles.z = 0
				var_144_1.localEulerAngles.x = 0
				var_144_1.localEulerAngles = var_144_1.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 then
				var_144_1.localPosition = Vector3.New(0, 100, 0)
				var_144_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_1.position).x, (manager.ui.mainCamera.transform.position - var_144_1.position).y, (manager.ui.mainCamera.transform.position - var_144_1.position).z)
				var_144_1.localEulerAngles.z = 0
				var_144_1.localEulerAngles.x = 0
				var_144_1.localEulerAngles = var_144_1.localEulerAngles
			end

			local var_144_3 = arg_141_1.actors_["1043ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1043ui_story = var_144_3.localPosition
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_3.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_141_1.time_ - 0) / var_144_4)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			local var_144_5 = arg_141_1.actors_["1043ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1043ui_story == nil then
				arg_141_1.var_.characterEffect1043ui_story = var_144_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.characterEffect1043ui_story and not isNil(var_144_5) then
					arg_141_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1043ui_story then
				arg_141_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_144_8 = arg_141_1.actors_["1111ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_9 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 and not isNil(var_144_8) then
				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_8) then
					arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_9)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect1111ui_story then
				arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_144_10 = 0
			local var_144_11 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_12 = arg_141_1:GetWordFromCfg(321291034)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 3 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 3)

				if (3 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 3)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291034", "story_v_out_321291.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_321291", "321291034", "story_v_out_321291.awb") / 1000

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end

					if var_144_12.prefab_name ~= "" and arg_141_1.actors_[var_144_12.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_12.prefab_name].transform, "story_v_out_321291", "321291034", "story_v_out_321291.awb")

						arg_141_1:RecordAudio("321291034", var_144_17)
						arg_141_1:RecordAudio("321291034", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321291", "321291034", "story_v_out_321291.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321291", "321291034", "story_v_out_321291.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_18 and arg_141_1.time_ < var_144_10 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play321291035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321291035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play321291036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1111ui_story = arg_145_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).z)
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles = arg_145_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).z)
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles = arg_145_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1043ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1043ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = arg_145_1.actors_["1043ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1043ui_story == nil then
				arg_145_1.var_.characterEffect1043ui_story = var_148_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 and not isNil(var_148_3) then
				if arg_145_1.var_.characterEffect1043ui_story and not isNil(var_148_3) then
					arg_145_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_4)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1043ui_story then
				arg_145_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_148_5 = 0
			local var_148_6 = 1.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(321291035).content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 52 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 52)

				if (52 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 52)) > 0 and var_148_6 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_10 and arg_145_1.time_ < var_148_5 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play321291036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321291036
		arg_149_1.duration_ = 3.63

		local var_149_0 = {
			zh = 3.5,
			ja = 3.633
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321291037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.MS2109 == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2109")
				var_152_0.name = "MS2109"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.MS2109 = var_152_0
			end

			if 0.433333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 0.433333333333333 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.MS2109

				arg_149_1.bgs_.MS2109.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "MS2109" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 2.499999999999

			if 2.499999999999 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_4 + 0.0333333333343333 and arg_149_1.time_ < var_152_4 + 0.0333333333343333 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_5 = 0.5

			if 0.5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_6 = 2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 then
				local var_152_7 = Color.New(1, 1, 1)

				var_152_7.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_5) / var_152_6)
				arg_149_1.mask_.color = var_152_7
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				local var_152_8 = Color.New(1, 1, 1)

				arg_149_1.mask_.enabled = false
				var_152_8.a = 0
				arg_149_1.mask_.color = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1111ui_story"].transform

			if 0.5 < arg_149_1.time_ and arg_149_1.time_ <= 0.5 + arg_152_0 then
				arg_149_1.var_.moveOldPos1111ui_story = var_152_9.localPosition
			end

			local var_152_10 = 0.001

			if 0.5 <= arg_149_1.time_ and arg_149_1.time_ < 0.5 + var_152_10 then
				var_152_9.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0.5) / var_152_10)
				var_152_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_9.position).x, (manager.ui.mainCamera.transform.position - var_152_9.position).y, (manager.ui.mainCamera.transform.position - var_152_9.position).z)
				var_152_9.localEulerAngles.z = 0
				var_152_9.localEulerAngles.x = 0
				var_152_9.localEulerAngles = var_152_9.localEulerAngles
			end

			if arg_149_1.time_ >= 0.5 + var_152_10 and arg_149_1.time_ < 0.5 + var_152_10 + arg_152_0 then
				var_152_9.localPosition = Vector3.New(0, 100, 0)
				var_152_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_9.position).x, (manager.ui.mainCamera.transform.position - var_152_9.position).y, (manager.ui.mainCamera.transform.position - var_152_9.position).z)
				var_152_9.localEulerAngles.z = 0
				var_152_9.localEulerAngles.x = 0
				var_152_9.localEulerAngles = var_152_9.localEulerAngles
			end

			local var_152_11 = arg_149_1.actors_["1111ui_story"]

			if 0.5 < arg_149_1.time_ and arg_149_1.time_ <= 0.5 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_12 = 0.034000001847744

			if 0.5 <= arg_149_1.time_ and arg_149_1.time_ < 0.5 + var_152_12 and not isNil(var_152_11) then
				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_11) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0.5 + var_152_12 and arg_149_1.time_ < 0.5 + var_152_12 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_14 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_14 + 0.5 and arg_149_1.time_ < var_152_14 + 0.5 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_15 = arg_149_1.bgs_.MS2109.transform

			if 0.5 < arg_149_1.time_ and arg_149_1.time_ <= 0.5 + arg_152_0 then
				arg_149_1.var_.moveOldPosMS2109 = var_152_15.localPosition
			end

			local var_152_16 = 0.1

			if 0.5 <= arg_149_1.time_ and arg_149_1.time_ < 0.5 + var_152_16 then
				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPosMS2109, Vector3.New(1, -1.5, -3), (arg_149_1.time_ - 0.5) / var_152_16)
			end

			if arg_149_1.time_ >= 0.5 + var_152_16 and arg_149_1.time_ < 0.5 + var_152_16 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(1, -1.5, -3)
			end

			local var_152_17 = arg_149_1.bgs_.MS2109.transform

			if 0.6 < arg_149_1.time_ and arg_149_1.time_ <= 0.6 + arg_152_0 then
				arg_149_1.var_.moveOldPosMS2109 = var_152_17.localPosition
			end

			local var_152_18 = 1.899999999999

			if 0.6 <= arg_149_1.time_ and arg_149_1.time_ < 0.6 + var_152_18 then
				var_152_17.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPosMS2109, Vector3.New(1, -1.7, -3), (arg_149_1.time_ - 0.6) / var_152_18)
			end

			if arg_149_1.time_ >= 0.6 + var_152_18 and arg_149_1.time_ < 0.6 + var_152_18 + arg_152_0 then
				var_152_17.localPosition = Vector3.New(1, -1.7, -3)
			end

			local var_152_19

			if 0.5 < arg_149_1.time_ and arg_149_1.time_ <= 0.5 + arg_152_0 then
				local var_152_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_152_20 then
					var_152_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_152_20.radialBlurScale = 0
					var_152_20.radialBlurGradient = 1
					var_152_20.radialBlurIntensity = 1

					if var_152_19 then
						var_152_20.radialBlurTarget = var_152_19.transform
					end
				end
			end

			local var_152_21 = 1

			if 0.5 <= arg_149_1.time_ and arg_149_1.time_ < 0.5 + var_152_21 then
				local var_152_22 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_152_22 then
					var_152_22.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_152_22.radialBlurScale = Mathf.Lerp(0, 0.56, (arg_149_1.time_ - 0.5) / var_152_21)
					var_152_22.radialBlurGradient = Mathf.Lerp(1, 1, (arg_149_1.time_ - 0.5) / var_152_21)
					var_152_22.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_149_1.time_ - 0.5) / var_152_21)
				end
			end

			if arg_149_1.time_ >= 0.5 + var_152_21 and arg_149_1.time_ < 0.5 + var_152_21 + arg_152_0 then
				local var_152_23 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_152_23 then
					var_152_23.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_152_23.radialBlurScale = 0.56
					var_152_23.radialBlurGradient = 1
					var_152_23.radialBlurIntensity = 1
				end
			end

			if 0.333333333333333 < arg_149_1.time_ and arg_149_1.time_ <= 0.333333333333333 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake01", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_25 = 2.5
			local var_152_26 = 0.05

			if 2.5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_27 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_27:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_28 = arg_149_1:GetWordFromCfg(321291036)
				local var_152_29 = arg_149_1:FormatText(var_152_28.content)

				arg_149_1.text_.text = var_152_29

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_31 = 2 <= 0 and var_152_26 or var_152_26 * (utf8.len(var_152_29) / 2)

				if (2 <= 0 and var_152_26 or var_152_26 * (utf8.len(var_152_29) / 2)) > 0 and var_152_26 < var_152_31 then
					arg_149_1.talkMaxDuration = var_152_31
					var_152_25 = var_152_25 + 0.3

					if var_152_31 + var_152_25 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_25
					end
				end

				arg_149_1.text_.text = var_152_29
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291036", "story_v_out_321291.awb") ~= 0 then
					local var_152_32 = manager.audio:GetVoiceLength("story_v_out_321291", "321291036", "story_v_out_321291.awb") / 1000

					if var_152_32 + var_152_25 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_32 + var_152_25
					end

					if var_152_28.prefab_name ~= "" and arg_149_1.actors_[var_152_28.prefab_name] ~= nil then
						local var_152_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_28.prefab_name].transform, "story_v_out_321291", "321291036", "story_v_out_321291.awb")

						arg_149_1:RecordAudio("321291036", var_152_33)
						arg_149_1:RecordAudio("321291036", var_152_33)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321291", "321291036", "story_v_out_321291.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321291", "321291036", "story_v_out_321291.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_34 = var_152_25 + 0.3
			local var_152_35 = math.max(var_152_26, arg_149_1.talkMaxDuration)

			if var_152_25 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_34 + var_152_35 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_34) / var_152_35

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_34 + var_152_35 and arg_149_1.time_ < var_152_34 + var_152_35 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.899999999999,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play321291037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321291037
		arg_155_1.duration_ = 3.13

		local var_155_0 = {
			zh = 2.766,
			ja = 3.133
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321291038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1111ui_story = arg_155_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).z)
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles = arg_155_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1111ui_story"].transform.position).z)
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1111ui_story"].transform.localEulerAngles = arg_155_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1111ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1111ui_story == nil then
				arg_155_1.var_.characterEffect1111ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1111ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_2)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1111ui_story then
				arg_155_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_158_3 = 0
			local var_158_4 = 0.25

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_5 = arg_155_1:GetWordFromCfg(321291037)
				local var_158_6 = arg_155_1:FormatText(var_158_5.content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 10 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 10)

				if (10 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_6) / 10)) > 0 and var_158_4 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291037", "story_v_out_321291.awb") ~= 0 then
					local var_158_9 = manager.audio:GetVoiceLength("story_v_out_321291", "321291037", "story_v_out_321291.awb") / 1000

					if var_158_9 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_3
					end

					if var_158_5.prefab_name ~= "" and arg_155_1.actors_[var_158_5.prefab_name] ~= nil then
						local var_158_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_5.prefab_name].transform, "story_v_out_321291", "321291037", "story_v_out_321291.awb")

						arg_155_1:RecordAudio("321291037", var_158_10)
						arg_155_1:RecordAudio("321291037", var_158_10)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321291", "321291037", "story_v_out_321291.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321291", "321291037", "story_v_out_321291.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_11 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_11 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_11

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_11 and arg_155_1.time_ < var_158_3 + var_158_11 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play321291038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321291038
		arg_159_1.duration_ = 2.07

		local var_159_0 = {
			zh = 1.6,
			ja = 2.066
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321291039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(321291038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 6 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 6)

				if (6 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 6)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291038", "story_v_out_321291.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291038", "story_v_out_321291.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_321291", "321291038", "story_v_out_321291.awb")

						arg_159_1:RecordAudio("321291038", var_162_6)
						arg_159_1:RecordAudio("321291038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321291", "321291038", "story_v_out_321291.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321291", "321291038", "story_v_out_321291.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321291039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321291039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play321291040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1043ui_story = arg_163_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).z)
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles = arg_163_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1043ui_story"].transform.position).z)
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1043ui_story"].transform.localEulerAngles = arg_163_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1043ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1043ui_story == nil then
				arg_163_1.var_.characterEffect1043ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1043ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1043ui_story then
				arg_163_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_166_3 = 0
			local var_166_4 = 1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(321291039).content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 40 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 40)

				if (40 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 40)) > 0 and var_166_4 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_8 and arg_163_1.time_ < var_166_3 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play321291040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321291040
		arg_167_1.duration_ = 14.2

		local var_167_0 = {
			zh = 6.1,
			ja = 14.2
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play321291041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(321291040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)

				if (17 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 17)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291040", "story_v_out_321291.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291040", "story_v_out_321291.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_321291", "321291040", "story_v_out_321291.awb")

						arg_167_1:RecordAudio("321291040", var_170_6)
						arg_167_1:RecordAudio("321291040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321291", "321291040", "story_v_out_321291.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321291", "321291040", "story_v_out_321291.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play321291041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321291041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321291042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10130ui_story = arg_171_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).z)
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles = arg_171_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10130ui_story"].transform.position).z)
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10130ui_story"].transform.localEulerAngles = arg_171_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10130ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10130ui_story == nil then
				arg_171_1.var_.characterEffect10130ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10130ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_2)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10130ui_story then
				arg_171_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0.633333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 0.633333333333333 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_141", "se_story_141_portal", "")
			end

			local var_174_4 = 0
			local var_174_5 = 1.25

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(321291041).content)

				arg_171_1.text_.text = var_174_6

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 50 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_6) / 50)

				if (50 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_6) / 50)) > 0 and var_174_5 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_6
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_9 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_9 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_9

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_9 and arg_171_1.time_ < var_174_4 + var_174_9 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play321291042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321291042
		arg_175_1.duration_ = 2.77

		local var_175_0 = {
			zh = 2.766,
			ja = 2.4
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321291043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(321291042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 10 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 10)

				if (10 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 10)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291042", "story_v_out_321291.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291042", "story_v_out_321291.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_321291", "321291042", "story_v_out_321291.awb")

						arg_175_1:RecordAudio("321291042", var_178_6)
						arg_175_1:RecordAudio("321291042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321291", "321291042", "story_v_out_321291.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321291", "321291042", "story_v_out_321291.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321291043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321291043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321291044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(321291043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 44 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 44)

				if (44 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 44)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321291044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321291044
		arg_183_1.duration_ = 6.8

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321291045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_0 = 1

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				local var_186_1 = Color.New(1, 1, 1)

				var_186_1.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.mask_.color = var_186_1
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				local var_186_2 = Color.New(1, 1, 1)

				var_186_2.a = 1
				arg_183_1.mask_.color = var_186_2
			end

			local var_186_3 = 1

			if 1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_4 = 1

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_4 then
				local var_186_5 = Color.New(1, 1, 1)

				var_186_5.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_3) / var_186_4)
				arg_183_1.mask_.color = var_186_5
			end

			if arg_183_1.time_ >= var_186_3 + var_186_4 and arg_183_1.time_ < var_186_3 + var_186_4 + arg_186_0 then
				local var_186_6 = Color.New(1, 1, 1)

				arg_183_1.mask_.enabled = false
				var_186_6.a = 0
				arg_183_1.mask_.color = var_186_6
			end

			if 0.266666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.266666666666667 + arg_186_0 then
				arg_183_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_lightmagic", "")
			end

			local var_186_8 = 1.8
			local var_186_9 = 0.95

			if 1.8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(321291044).content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_12 = 38 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_10) / 38)

				if (38 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_10) / 38)) > 0 and var_186_9 < var_186_12 then
					arg_183_1.talkMaxDuration = var_186_12

					if var_186_12 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_13 and arg_183_1.time_ < var_186_8 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play321291045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 321291045
		arg_187_1.duration_ = 2.8

		local var_187_0 = {
			zh = 2.8,
			ja = 1.5
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play321291046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(321291045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 6 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 6)

				if (6 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 6)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291045", "story_v_out_321291.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291045", "story_v_out_321291.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_321291", "321291045", "story_v_out_321291.awb")

						arg_187_1:RecordAudio("321291045", var_190_6)
						arg_187_1:RecordAudio("321291045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_321291", "321291045", "story_v_out_321291.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_321291", "321291045", "story_v_out_321291.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play321291046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 321291046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play321291047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0.05 < arg_191_1.time_ and arg_191_1.time_ <= 0.05 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe5", "")
			end

			local var_194_1 = 0
			local var_194_2 = 1.575

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(321291046).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 63 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 63)

				if (63 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 63)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play321291047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 321291047
		arg_195_1.duration_ = 6.2

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play321291048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_9000

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				local var_198_0 = arg_195_1.bgs_.MS2109

				arg_195_1.bgs_.MS2109.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_198_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_1 = var_198_0:GetComponent("SpriteRenderer")

				if var_198_1 and var_198_1.sprite then
					local var_198_2 = 2 * (var_198_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_198_0.transform.localScale = Vector3.New(var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "MS2109" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_3 = arg_195_1.bgs_.MS2109.transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPosMS2109 = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPosMS2109, Vector3.New(0, 1, 9.5), (arg_195_1.time_ - 0) / var_198_4)
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_198_5 = arg_195_1.bgs_.MS2109.transform

			if 0.0333333333333333 < arg_195_1.time_ and arg_195_1.time_ <= 0.0333333333333333 + arg_198_0 then
				arg_195_1.var_.moveOldPosMS2109 = var_198_5.localPosition
			end

			local var_198_6 = 3

			if 0.0333333333333333 <= arg_195_1.time_ and arg_195_1.time_ < 0.0333333333333333 + var_198_6 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPosMS2109, Vector3.New(0, 1, 10), (arg_195_1.time_ - 0.0333333333333333) / var_198_6)
			end

			if arg_195_1.time_ >= 0.0333333333333333 + var_198_6 and arg_195_1.time_ < 0.0333333333333333 + var_198_6 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_198_7 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_7 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_7 + 3.03333333333333 and arg_195_1.time_ < var_198_7 + 3.03333333333333 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				local var_198_8 = arg_195_1.var_.effectjingtouuyan1

				if not arg_195_1.var_.effectjingtouuyan1 then
					var_198_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_198_8.name = "jingtouuyan1"
					arg_195_1.var_.effectjingtouuyan1 = var_198_8
				else
					var_198_8.transform:SetParent(var_198_9000)
				end

				var_198_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_198_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				if arg_195_1.var_.effectjingtouuyan1 then
					Object.Destroy(arg_195_1.var_.effectjingtouuyan1)

					arg_195_1.var_.effectjingtouuyan1 = nil
				end
			end

			if 1.43333333333333 < arg_195_1.time_ and arg_195_1.time_ <= 1.43333333333333 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_aim", "")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_12 = 1.2
			local var_198_13 = 0.8

			if 1.2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_14 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_14:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_15 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(321291047).content)

				arg_195_1.text_.text = var_198_15

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_17 = 32 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 32)

				if (32 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 32)) > 0 and var_198_13 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17
					var_198_12 = var_198_12 + 0.3

					if var_198_17 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_12
					end
				end

				arg_195_1.text_.text = var_198_15
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_18 = var_198_12 + 0.3
			local var_198_19 = math.max(var_198_13, arg_195_1.talkMaxDuration)

			if var_198_12 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_18 + var_198_19 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_18) / var_198_19

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_18 + var_198_19 and arg_195_1.time_ < var_198_18 + var_198_19 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play321291048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321291048
		arg_201_1.duration_ = 3.37

		local var_201_0 = {
			zh = 3.366,
			ja = 1.166
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321291049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(321291048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 4 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 4)

				if (4 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 4)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321291", "321291048", "story_v_out_321291.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_321291", "321291048", "story_v_out_321291.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_321291", "321291048", "story_v_out_321291.awb")

						arg_201_1:RecordAudio("321291048", var_204_6)
						arg_201_1:RecordAudio("321291048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321291", "321291048", "story_v_out_321291.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321291", "321291048", "story_v_out_321291.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321291049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321291049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.275

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(321291049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 51 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 51)

				if (51 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 51)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09h",
		"TextureConfig/Background/MS2109"
	},
	voices = {
		"story_v_out_321291.awb"
	}
}
