return {
	Play412061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST86 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST86")
				var_4_0.name = "ST86"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST86 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST86

				arg_1_1.bgs_.ST86.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST86" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(412061001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)

				if (52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412061002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play412061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(412061002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 42 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 42)

				if (42 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 42)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play412061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412061003
		arg_13_1.duration_ = 1.17

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play412061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_16_0 = 0.6

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				local var_16_1, var_16_2 = math.modf((arg_13_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_16_2 * 0.13, var_16_2 * 0.13, var_16_2 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				manager.ui.mainCamera.transform.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_3 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_3 + 0.6 and arg_13_1.time_ < var_16_3 + 0.6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_4 = 0
			local var_16_5 = 0.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(412061003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 3 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 3)

				if (3 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 3)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061003", "story_v_out_412061.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061003", "story_v_out_412061.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_412061", "412061003", "story_v_out_412061.awb")

						arg_13_1:RecordAudio("412061003", var_16_11)
						arg_13_1:RecordAudio("412061003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412061", "412061003", "story_v_out_412061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412061", "412061003", "story_v_out_412061.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play412061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412061004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1097ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1097ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1097ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1097ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1097ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_20_5 = arg_17_1.actors_["1097ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(412061004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 2 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 2)

				if (2 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 2)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061004", "story_v_out_412061.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061004", "story_v_out_412061.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_412061", "412061004", "story_v_out_412061.awb")

						arg_17_1:RecordAudio("412061004", var_20_15)
						arg_17_1:RecordAudio("412061004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412061", "412061004", "story_v_out_412061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412061", "412061004", "story_v_out_412061.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play412061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412061005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play412061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1097ui_story = arg_21_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).z)
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles = arg_21_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1097ui_story"].transform.position).z)
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1097ui_story"].transform.localEulerAngles = arg_21_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_24_1 = 0
			local var_24_2 = 1.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(412061005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 52 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 52)

				if (52 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 52)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play412061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412061006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play412061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(412061006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 63 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 63)

				if (63 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 63)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play412061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412061007
		arg_29_1.duration_ = 3.47

		local var_29_0 = {
			zh = 3.133,
			ja = 3.466
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = arg_29_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).z)
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles = arg_29_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_29_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).z)
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles = arg_29_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1097ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = 0
			local var_32_5 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(412061007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 7 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 7)

				if (7 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 7)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061007", "story_v_out_412061.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061007", "story_v_out_412061.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_412061", "412061007", "story_v_out_412061.awb")

						arg_29_1:RecordAudio("412061007", var_32_11)
						arg_29_1:RecordAudio("412061007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_412061", "412061007", "story_v_out_412061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_412061", "412061007", "story_v_out_412061.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412061008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play412061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1097ui_story = arg_33_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).z)
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles = arg_33_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1097ui_story"].transform.position).z)
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1097ui_story"].transform.localEulerAngles = arg_33_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1097ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1097ui_story == nil then
				arg_33_1.var_.characterEffect1097ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1097ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1097ui_story then
				arg_33_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 0.925

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(412061008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 37 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 37)

				if (37 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 37)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play412061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412061009
		arg_37_1.duration_ = 3.2

		local var_37_0 = {
			zh = 2.366,
			ja = 3.2
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play412061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "10076ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10076ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["10076ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["10076ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["10076ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10076ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, -0.35, -4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10076ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10076ui_story == nil then
				arg_37_1.var_.characterEffect10076ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10076ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10076ui_story then
				arg_37_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action5_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_8 = 0
			local var_40_9 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(412061009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 10 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 10)

				if (10 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 10)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061009", "story_v_out_412061.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061009", "story_v_out_412061.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_412061", "412061009", "story_v_out_412061.awb")

						arg_37_1:RecordAudio("412061009", var_40_15)
						arg_37_1:RecordAudio("412061009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_412061", "412061009", "story_v_out_412061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_412061", "412061009", "story_v_out_412061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play412061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412061010
		arg_41_1.duration_ = 2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play412061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["10077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10077ui_story"))) then
				local var_44_0 = Object.Instantiate(Asset.Load("Char/" .. "10077ui_story"), arg_41_1.stage_.transform)

				var_44_0.name = "10077ui_story"
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10077ui_story"] = var_44_0

				local var_44_1 = var_44_0:GetComponentInChildren(typeof(CharacterEffect))

				var_44_1.enabled = true

				local var_44_2 = GameObjectTools.GetOrAddComponent(var_44_0, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_1.transform, false)

				arg_41_1.var_["10077ui_story" .. "Animator"] = var_44_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_["10077ui_story" .. "Animator"].applyRootMotion = true
				arg_41_1.var_["10077ui_story" .. "LipSync"] = var_44_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_3 = arg_41_1.actors_["10077ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10077ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10077ui_story, Vector3.New(-0.9, 0, -5), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(-0.9, 0, -5)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["10077ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10077ui_story == nil then
				arg_41_1.var_.characterEffect10077ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect10077ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10077ui_story then
				arg_41_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_8 = arg_41_1.actors_["10076ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10076ui_story = var_44_8.localPosition
			end

			local var_44_9 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_9)
				var_44_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_8.position).x, (manager.ui.mainCamera.transform.position - var_44_8.position).y, (manager.ui.mainCamera.transform.position - var_44_8.position).z)
				var_44_8.localEulerAngles.z = 0
				var_44_8.localEulerAngles.x = 0
				var_44_8.localEulerAngles = var_44_8.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, 100, 0)
				var_44_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_8.position).x, (manager.ui.mainCamera.transform.position - var_44_8.position).y, (manager.ui.mainCamera.transform.position - var_44_8.position).z)
				var_44_8.localEulerAngles.z = 0
				var_44_8.localEulerAngles.x = 0
				var_44_8.localEulerAngles = var_44_8.localEulerAngles
			end

			local var_44_10 = arg_41_1.actors_["10076ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect10076ui_story == nil then
				arg_41_1.var_.characterEffect10076ui_story = var_44_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_11 and not isNil(var_44_10) then
				if arg_41_1.var_.characterEffect10076ui_story and not isNil(var_44_10) then
					arg_41_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_11)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_11 and arg_41_1.time_ < 0 + var_44_11 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect10076ui_story then
				arg_41_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_44_12 = 0
			local var_44_13 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(412061010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 3 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 3)

				if (3 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 3)) > 0 and var_44_13 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061010", "story_v_out_412061.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_412061", "412061010", "story_v_out_412061.awb") / 1000

					if var_44_18 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_12
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_412061", "412061010", "story_v_out_412061.awb")

						arg_41_1:RecordAudio("412061010", var_44_19)
						arg_41_1:RecordAudio("412061010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412061", "412061010", "story_v_out_412061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412061", "412061010", "story_v_out_412061.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_20 and arg_41_1.time_ < var_44_12 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play412061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412061011
		arg_45_1.duration_ = 4.77

		local var_45_0 = {
			zh = 2.8,
			ja = 4.766
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play412061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1097ui_story = arg_45_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).z)
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles = arg_45_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_45_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1097ui_story"].transform.position).z)
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1097ui_story"].transform.localEulerAngles = arg_45_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1097ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1097ui_story == nil then
				arg_45_1.var_.characterEffect1097ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1097ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1097ui_story then
				arg_45_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["10077ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10077ui_story == nil then
				arg_45_1.var_.characterEffect10077ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect10077ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10077ui_story then
				arg_45_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(412061011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 11 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 11)

				if (11 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 11)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061011", "story_v_out_412061.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061011", "story_v_out_412061.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_412061", "412061011", "story_v_out_412061.awb")

						arg_45_1:RecordAudio("412061011", var_48_13)
						arg_45_1:RecordAudio("412061011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412061", "412061011", "story_v_out_412061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412061", "412061011", "story_v_out_412061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play412061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412061012
		arg_49_1.duration_ = 3.7

		local var_49_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play412061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10077ui_story = arg_49_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10077ui_story, Vector3.New(-0.9, 0, -5), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).z)
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles = arg_49_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(-0.9, 0, -5)
				arg_49_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10077ui_story"].transform.position).z)
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10077ui_story"].transform.localEulerAngles = arg_49_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10077ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10077ui_story == nil then
				arg_49_1.var_.characterEffect10077ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10077ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10077ui_story then
				arg_49_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1097ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1097ui_story then
				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(412061012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 7 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 7)

				if (7 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 7)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061012", "story_v_out_412061.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061012", "story_v_out_412061.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_412061", "412061012", "story_v_out_412061.awb")

						arg_49_1:RecordAudio("412061012", var_52_13)
						arg_49_1:RecordAudio("412061012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412061", "412061012", "story_v_out_412061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412061", "412061012", "story_v_out_412061.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play412061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412061013
		arg_53_1.duration_ = 9.9

		local var_53_0 = {
			zh = 5.566,
			ja = 9.9
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play412061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(412061013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)

				if (24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061013", "story_v_out_412061.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061013", "story_v_out_412061.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_412061", "412061013", "story_v_out_412061.awb")

						arg_53_1:RecordAudio("412061013", var_56_6)
						arg_53_1:RecordAudio("412061013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412061", "412061013", "story_v_out_412061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412061", "412061013", "story_v_out_412061.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412061014
		arg_57_1.duration_ = 3.97

		local var_57_0 = {
			zh = 3.966,
			ja = 3.833
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play412061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = arg_57_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1097ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = arg_57_1.actors_["10077ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10077ui_story == nil then
				arg_57_1.var_.characterEffect10077ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect10077ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10077ui_story then
				arg_57_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_60_6 = 0
			local var_60_7 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(412061014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)

				if (16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061014", "story_v_out_412061.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061014", "story_v_out_412061.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_412061", "412061014", "story_v_out_412061.awb")

						arg_57_1:RecordAudio("412061014", var_60_13)
						arg_57_1:RecordAudio("412061014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412061", "412061014", "story_v_out_412061.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412061", "412061014", "story_v_out_412061.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play412061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412061015
		arg_61_1.duration_ = 7.33

		local var_61_0 = {
			zh = 6.833,
			ja = 7.333
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play412061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10076ui_story = arg_61_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).z)
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles = arg_61_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_61_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10076ui_story"].transform.position).z)
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10076ui_story"].transform.localEulerAngles = arg_61_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10076ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10076ui_story == nil then
				arg_61_1.var_.characterEffect10076ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10076ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10076ui_story then
				arg_61_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["10077ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10077ui_story = var_64_4.localPosition
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_4.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_5)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_4.localPosition = Vector3.New(0, 100, 0)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			local var_64_6 = arg_61_1.actors_["10077ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect10077ui_story == nil then
				arg_61_1.var_.characterEffect10077ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect10077ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect10077ui_story then
				arg_61_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_64_8 = arg_61_1.actors_["1097ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1097ui_story = var_64_8.localPosition
			end

			local var_64_9 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_9)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(0, 100, 0)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			local var_64_10 = arg_61_1.actors_["1097ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_11 and not isNil(var_64_10) then
				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_10) then
					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_11)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_11 and arg_61_1.time_ < 0 + var_64_11 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect1097ui_story then
				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_64_12 = 0
			local var_64_13 = 0.625

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(412061015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 25 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 25)

				if (25 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 25)) > 0 and var_64_13 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061015", "story_v_out_412061.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_412061", "412061015", "story_v_out_412061.awb") / 1000

					if var_64_18 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_12
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_412061", "412061015", "story_v_out_412061.awb")

						arg_61_1:RecordAudio("412061015", var_64_19)
						arg_61_1:RecordAudio("412061015", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412061", "412061015", "story_v_out_412061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412061", "412061015", "story_v_out_412061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_20 and arg_61_1.time_ < var_64_12 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play412061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412061016
		arg_65_1.duration_ = 13.97

		local var_65_0 = {
			zh = 13.966,
			ja = 11.2
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play412061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10077ui_story = arg_65_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10077ui_story, Vector3.New(0.9, 0, -5), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).z)
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles = arg_65_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0.9, 0, -5)
				arg_65_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10077ui_story"].transform.position).z)
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10077ui_story"].transform.localEulerAngles = arg_65_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10077ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10077ui_story == nil then
				arg_65_1.var_.characterEffect10077ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10077ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10077ui_story then
				arg_65_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = arg_65_1.actors_["10076ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10076ui_story = var_68_4.localPosition
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_65_1.time_ - 0) / var_68_5)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(-1, -0.35, -4)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			local var_68_6 = arg_65_1.actors_["10076ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10076ui_story == nil then
				arg_65_1.var_.characterEffect10076ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect10076ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10076ui_story then
				arg_65_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_68_8 = 0
			local var_68_9 = 1.625

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(412061016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 65 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 65)

				if (65 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 65)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061016", "story_v_out_412061.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061016", "story_v_out_412061.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_412061", "412061016", "story_v_out_412061.awb")

						arg_65_1:RecordAudio("412061016", var_68_15)
						arg_65_1:RecordAudio("412061016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412061", "412061016", "story_v_out_412061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412061", "412061016", "story_v_out_412061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play412061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412061017
		arg_69_1.duration_ = 13.93

		local var_69_0 = {
			zh = 13.933,
			ja = 8.866
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play412061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.6

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(412061017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 64 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 64)

				if (64 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 64)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061017", "story_v_out_412061.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061017", "story_v_out_412061.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_412061", "412061017", "story_v_out_412061.awb")

						arg_69_1:RecordAudio("412061017", var_72_6)
						arg_69_1:RecordAudio("412061017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_412061", "412061017", "story_v_out_412061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_412061", "412061017", "story_v_out_412061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play412061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412061018
		arg_73_1.duration_ = 4.17

		local var_73_0 = {
			zh = 3.633,
			ja = 4.166
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10076ui_story"]) and arg_73_1.var_.characterEffect10076ui_story == nil then
				arg_73_1.var_.characterEffect10076ui_story = arg_73_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10076ui_story"]) then
				if arg_73_1.var_.characterEffect10076ui_story and not isNil(arg_73_1.actors_["10076ui_story"]) then
					arg_73_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10076ui_story"]) and arg_73_1.var_.characterEffect10076ui_story then
				arg_73_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_2 = arg_73_1.actors_["10077ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10077ui_story == nil then
				arg_73_1.var_.characterEffect10077ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect10077ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10077ui_story then
				arg_73_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(412061018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)

				if (14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061018", "story_v_out_412061.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061018", "story_v_out_412061.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_412061", "412061018", "story_v_out_412061.awb")

						arg_73_1:RecordAudio("412061018", var_76_11)
						arg_73_1:RecordAudio("412061018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412061", "412061018", "story_v_out_412061.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412061", "412061018", "story_v_out_412061.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play412061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412061019
		arg_77_1.duration_ = 10.6

		local var_77_0 = {
			zh = 9,
			ja = 10.6
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play412061020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10077ui_story"]) and arg_77_1.var_.characterEffect10077ui_story == nil then
				arg_77_1.var_.characterEffect10077ui_story = arg_77_1.actors_["10077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10077ui_story"]) then
				if arg_77_1.var_.characterEffect10077ui_story and not isNil(arg_77_1.actors_["10077ui_story"]) then
					arg_77_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10077ui_story"]) and arg_77_1.var_.characterEffect10077ui_story then
				arg_77_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_2 = arg_77_1.actors_["10076ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect10076ui_story == nil then
				arg_77_1.var_.characterEffect10076ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect10076ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect10076ui_story then
				arg_77_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_80_4 = 0
			local var_80_5 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(412061019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 41 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 41)

				if (41 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 41)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061019", "story_v_out_412061.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061019", "story_v_out_412061.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_412061", "412061019", "story_v_out_412061.awb")

						arg_77_1:RecordAudio("412061019", var_80_11)
						arg_77_1:RecordAudio("412061019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412061", "412061019", "story_v_out_412061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412061", "412061019", "story_v_out_412061.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play412061020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412061020
		arg_81_1.duration_ = 3

		local var_81_0 = {
			zh = 3,
			ja = 1.999999999999
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play412061021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1097ui_story = arg_81_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).z)
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles = arg_81_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_81_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).z)
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles = arg_81_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1097ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1097ui_story == nil then
				arg_81_1.var_.characterEffect1097ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1097ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1097ui_story then
				arg_81_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["10077ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10077ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(0, 100, 0)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			local var_84_6 = arg_81_1.actors_["10077ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect10077ui_story == nil then
				arg_81_1.var_.characterEffect10077ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_7 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 and not isNil(var_84_6) then
				if arg_81_1.var_.characterEffect10077ui_story and not isNil(var_84_6) then
					arg_81_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_7)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect10077ui_story then
				arg_81_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_84_8 = 0
			local var_84_9 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(412061020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 10 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 10)

				if (10 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 10)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061020", "story_v_out_412061.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061020", "story_v_out_412061.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_412061", "412061020", "story_v_out_412061.awb")

						arg_81_1:RecordAudio("412061020", var_84_15)
						arg_81_1:RecordAudio("412061020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412061", "412061020", "story_v_out_412061.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412061", "412061020", "story_v_out_412061.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play412061021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412061021
		arg_85_1.duration_ = 11.1

		local var_85_0 = {
			zh = 11.1,
			ja = 7.633
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
				arg_85_0:Play412061022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10077ui_story = arg_85_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10077ui_story, Vector3.New(0.9, 0, -5), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).z)
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles = arg_85_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0.9, 0, -5)
				arg_85_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10077ui_story"].transform.position).z)
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10077ui_story"].transform.localEulerAngles = arg_85_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10077ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10077ui_story == nil then
				arg_85_1.var_.characterEffect10077ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10077ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10077ui_story then
				arg_85_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["1097ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_88_6 = arg_85_1.actors_["1097ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_6.localPosition
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_7)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(0, 100, 0)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			local var_88_8 = 0
			local var_88_9 = 1.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(412061021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 59 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 59)

				if (59 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 59)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061021", "story_v_out_412061.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061021", "story_v_out_412061.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_412061", "412061021", "story_v_out_412061.awb")

						arg_85_1:RecordAudio("412061021", var_88_15)
						arg_85_1:RecordAudio("412061021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412061", "412061021", "story_v_out_412061.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412061", "412061021", "story_v_out_412061.awb")
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
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412061022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412061022
		arg_89_1.duration_ = 11.2

		local var_89_0 = {
			zh = 11.2,
			ja = 9.733
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
				arg_89_0:Play412061023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(412061022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 56 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 56)

				if (56 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 56)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061022", "story_v_out_412061.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061022", "story_v_out_412061.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_412061", "412061022", "story_v_out_412061.awb")

						arg_89_1:RecordAudio("412061022", var_92_6)
						arg_89_1:RecordAudio("412061022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_412061", "412061022", "story_v_out_412061.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_412061", "412061022", "story_v_out_412061.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play412061023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412061023
		arg_93_1.duration_ = 7.07

		local var_93_0 = {
			zh = 7.066,
			ja = 5.333
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
				arg_93_0:Play412061024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10076ui_story = arg_93_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).z)
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles = arg_93_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_93_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10076ui_story"].transform.position).z)
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10076ui_story"].transform.localEulerAngles = arg_93_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10076ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10076ui_story == nil then
				arg_93_1.var_.characterEffect10076ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10076ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10076ui_story then
				arg_93_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["10077ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10077ui_story = var_96_4.localPosition
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_4.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10077ui_story, Vector3.New(0.9, 0, -5), (arg_93_1.time_ - 0) / var_96_5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_4.localPosition = Vector3.New(0.9, 0, -5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			local var_96_6 = arg_93_1.actors_["10077ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10077ui_story == nil then
				arg_93_1.var_.characterEffect10077ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect10077ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect10077ui_story then
				arg_93_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_96_8 = 0
			local var_96_9 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(412061023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 37 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 37)

				if (37 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 37)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061023", "story_v_out_412061.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061023", "story_v_out_412061.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_412061", "412061023", "story_v_out_412061.awb")

						arg_93_1:RecordAudio("412061023", var_96_15)
						arg_93_1:RecordAudio("412061023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_412061", "412061023", "story_v_out_412061.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_412061", "412061023", "story_v_out_412061.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play412061024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 412061024
		arg_97_1.duration_ = 2.37

		local var_97_0 = {
			zh = 2.366,
			ja = 2.166
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play412061025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10077ui_story"]) and arg_97_1.var_.characterEffect10077ui_story == nil then
				arg_97_1.var_.characterEffect10077ui_story = arg_97_1.actors_["10077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10077ui_story"]) then
				if arg_97_1.var_.characterEffect10077ui_story and not isNil(arg_97_1.actors_["10077ui_story"]) then
					arg_97_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10077ui_story"]) and arg_97_1.var_.characterEffect10077ui_story then
				arg_97_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_2 = arg_97_1.actors_["10076ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect10076ui_story == nil then
				arg_97_1.var_.characterEffect10076ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect10076ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect10076ui_story then
				arg_97_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_100_4 = 0
			local var_100_5 = 0.2

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(412061024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 8 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 8)

				if (8 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 8)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061024", "story_v_out_412061.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061024", "story_v_out_412061.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_412061", "412061024", "story_v_out_412061.awb")

						arg_97_1:RecordAudio("412061024", var_100_11)
						arg_97_1:RecordAudio("412061024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_412061", "412061024", "story_v_out_412061.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_412061", "412061024", "story_v_out_412061.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play412061025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 412061025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play412061026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10077ui_story = arg_101_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).z)
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles = arg_101_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10077ui_story"].transform.position).z)
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10077ui_story"].transform.localEulerAngles = arg_101_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10077ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10077ui_story == nil then
				arg_101_1.var_.characterEffect10077ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10077ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10077ui_story then
				arg_101_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_104_3 = arg_101_1.actors_["10076ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10076ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0, 100, 0)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = 0
			local var_104_6 = 1.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(412061025).content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 60 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 60)

				if (60 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_7) / 60)) > 0 and var_104_6 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_5) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_5 + var_104_10 and arg_101_1.time_ < var_104_5 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play412061026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 412061026
		arg_105_1.duration_ = 6.2

		local var_105_0 = {
			zh = 6.2,
			ja = 3.6
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
				arg_105_0:Play412061027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10076ui_story = arg_105_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10076ui_story, Vector3.New(-1, -0.35, -4), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).z)
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles = arg_105_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(-1, -0.35, -4)
				arg_105_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10076ui_story"].transform.position).z)
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10076ui_story"].transform.localEulerAngles = arg_105_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10076ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10076ui_story == nil then
				arg_105_1.var_.characterEffect10076ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10076ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10076ui_story then
				arg_105_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = arg_105_1.actors_["10077ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10077ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10077ui_story, Vector3.New(0.9, 0, -5), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0.9, 0, -5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["10077ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect10077ui_story == nil then
				arg_105_1.var_.characterEffect10077ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect10077ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect10077ui_story then
				arg_105_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_108_8 = 0
			local var_108_9 = 0.825

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(412061026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 33 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 33)

				if (33 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 33)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061026", "story_v_out_412061.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061026", "story_v_out_412061.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_412061", "412061026", "story_v_out_412061.awb")

						arg_105_1:RecordAudio("412061026", var_108_15)
						arg_105_1:RecordAudio("412061026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_412061", "412061026", "story_v_out_412061.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_412061", "412061026", "story_v_out_412061.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
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
	Play412061027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 412061027
		arg_109_1.duration_ = 6.93

		local var_109_0 = {
			zh = 6.933,
			ja = 4.033
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
				arg_109_0:Play412061028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.7

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(412061027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 28 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 28)

				if (28 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 28)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061027", "story_v_out_412061.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061027", "story_v_out_412061.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_412061", "412061027", "story_v_out_412061.awb")

						arg_109_1:RecordAudio("412061027", var_112_6)
						arg_109_1:RecordAudio("412061027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_412061", "412061027", "story_v_out_412061.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_412061", "412061027", "story_v_out_412061.awb")
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
	Play412061028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 412061028
		arg_113_1.duration_ = 5.43

		local var_113_0 = {
			zh = 4.5,
			ja = 5.433
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play412061029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10077ui_story = arg_113_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10077ui_story, Vector3.New(0.9, 0, -5), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).z)
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles = arg_113_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0.9, 0, -5)
				arg_113_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10077ui_story"].transform.position).z)
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10077ui_story"].transform.localEulerAngles = arg_113_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10077ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10077ui_story == nil then
				arg_113_1.var_.characterEffect10077ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10077ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10077ui_story then
				arg_113_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = arg_113_1.actors_["10076ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10076ui_story == nil then
				arg_113_1.var_.characterEffect10076ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect10076ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10076ui_story then
				arg_113_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_116_6 = 0
			local var_116_7 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(412061028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 22 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 22)

				if (22 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 22)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061028", "story_v_out_412061.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061028", "story_v_out_412061.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_412061", "412061028", "story_v_out_412061.awb")

						arg_113_1:RecordAudio("412061028", var_116_13)
						arg_113_1:RecordAudio("412061028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_412061", "412061028", "story_v_out_412061.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_412061", "412061028", "story_v_out_412061.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
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
	Play412061029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 412061029
		arg_117_1.duration_ = 3.77

		local var_117_0 = {
			zh = 3.133,
			ja = 3.766
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
				arg_117_0:Play412061030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10077ui_story"]) and arg_117_1.var_.characterEffect10077ui_story == nil then
				arg_117_1.var_.characterEffect10077ui_story = arg_117_1.actors_["10077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10077ui_story"]) then
				if arg_117_1.var_.characterEffect10077ui_story and not isNil(arg_117_1.actors_["10077ui_story"]) then
					arg_117_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10077ui_story"]) and arg_117_1.var_.characterEffect10077ui_story then
				arg_117_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_120_1 = arg_117_1.actors_["10076ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10076ui_story == nil then
				arg_117_1.var_.characterEffect10076ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10076ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10076ui_story then
				arg_117_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_120_4 = 0
			local var_120_5 = 0.375

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(412061029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 15 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 15)

				if (15 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 15)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061029", "story_v_out_412061.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061029", "story_v_out_412061.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_412061", "412061029", "story_v_out_412061.awb")

						arg_117_1:RecordAudio("412061029", var_120_11)
						arg_117_1:RecordAudio("412061029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_412061", "412061029", "story_v_out_412061.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_412061", "412061029", "story_v_out_412061.awb")
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
	Play412061030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 412061030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play412061031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10076ui_story = arg_121_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).z)
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles = arg_121_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10076ui_story"].transform.position).z)
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10076ui_story"].transform.localEulerAngles = arg_121_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10076ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10076ui_story == nil then
				arg_121_1.var_.characterEffect10076ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10076ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10076ui_story then
				arg_121_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["10077ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10077ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["10077ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect10077ui_story == nil then
				arg_121_1.var_.characterEffect10077ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect10077ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_6)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect10077ui_story then
				arg_121_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_124_7 = 0
			local var_124_8 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(412061030).content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 25 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 25)

				if (25 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 25)) > 0 and var_124_8 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_12 and arg_121_1.time_ < var_124_7 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play412061031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 412061031
		arg_125_1.duration_ = 4.6

		local var_125_0 = {
			zh = 4.6,
			ja = 4.3
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play412061032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1097ui_story = arg_125_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).z)
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles = arg_125_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_125_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1097ui_story"].transform.position).z)
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1097ui_story"].transform.localEulerAngles = arg_125_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1097ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1097ui_story then
				arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_128_4 = arg_125_1.actors_["10076ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10076ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(1, -0.35, -4)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["10076ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10076ui_story == nil then
				arg_125_1.var_.characterEffect10076ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect10076ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10076ui_story then
				arg_125_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_128_8 = 0
			local var_128_9 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(412061031)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 18 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 18)

				if (18 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 18)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061031", "story_v_out_412061.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061031", "story_v_out_412061.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_412061", "412061031", "story_v_out_412061.awb")

						arg_125_1:RecordAudio("412061031", var_128_15)
						arg_125_1:RecordAudio("412061031", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_412061", "412061031", "story_v_out_412061.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_412061", "412061031", "story_v_out_412061.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play412061032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 412061032
		arg_129_1.duration_ = 10.37

		local var_129_0 = {
			zh = 7.966,
			ja = 10.366
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play412061033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(412061032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 28)

				if (28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 28)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061032", "story_v_out_412061.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061032", "story_v_out_412061.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_412061", "412061032", "story_v_out_412061.awb")

						arg_129_1:RecordAudio("412061032", var_132_6)
						arg_129_1:RecordAudio("412061032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_412061", "412061032", "story_v_out_412061.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_412061", "412061032", "story_v_out_412061.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play412061033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 412061033
		arg_133_1.duration_ = 4.9

		local var_133_0 = {
			zh = 3.966,
			ja = 4.9
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
				arg_133_0:Play412061034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_136_0 = 0
			local var_136_1 = 0.325

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(412061033)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 13 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 13)

				if (13 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 13)) > 0 and var_136_1 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061033", "story_v_out_412061.awb") ~= 0 then
					local var_136_6 = manager.audio:GetVoiceLength("story_v_out_412061", "412061033", "story_v_out_412061.awb") / 1000

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end

					if var_136_2.prefab_name ~= "" and arg_133_1.actors_[var_136_2.prefab_name] ~= nil then
						local var_136_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_2.prefab_name].transform, "story_v_out_412061", "412061033", "story_v_out_412061.awb")

						arg_133_1:RecordAudio("412061033", var_136_7)
						arg_133_1:RecordAudio("412061033", var_136_7)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_412061", "412061033", "story_v_out_412061.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_412061", "412061033", "story_v_out_412061.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play412061034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 412061034
		arg_137_1.duration_ = 8.73

		local var_137_0 = {
			zh = 8.733,
			ja = 5.466
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
				arg_137_0:Play412061035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10076ui_story = arg_137_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).z)
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles = arg_137_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(1, -0.35, -4)
				arg_137_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10076ui_story"].transform.position).z)
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10076ui_story"].transform.localEulerAngles = arg_137_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10076ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10076ui_story == nil then
				arg_137_1.var_.characterEffect10076ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10076ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10076ui_story then
				arg_137_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = arg_137_1.actors_["1097ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1097ui_story == nil then
				arg_137_1.var_.characterEffect1097ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect1097ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1097ui_story then
				arg_137_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_140_6 = 0
			local var_140_7 = 0.95

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(412061034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 38 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 38)

				if (38 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 38)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061034", "story_v_out_412061.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061034", "story_v_out_412061.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_412061", "412061034", "story_v_out_412061.awb")

						arg_137_1:RecordAudio("412061034", var_140_13)
						arg_137_1:RecordAudio("412061034", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_412061", "412061034", "story_v_out_412061.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_412061", "412061034", "story_v_out_412061.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412061035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 412061035
		arg_141_1.duration_ = 10.87

		local var_141_0 = {
			zh = 10.866,
			ja = 9.433
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play412061036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1097ui_story"]) and arg_141_1.var_.characterEffect1097ui_story == nil then
				arg_141_1.var_.characterEffect1097ui_story = arg_141_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1097ui_story"]) then
				if arg_141_1.var_.characterEffect1097ui_story and not isNil(arg_141_1.actors_["1097ui_story"]) then
					arg_141_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1097ui_story"]) and arg_141_1.var_.characterEffect1097ui_story then
				arg_141_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = arg_141_1.actors_["10076ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10076ui_story == nil then
				arg_141_1.var_.characterEffect10076ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect10076ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10076ui_story then
				arg_141_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(412061035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 34 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 34)

				if (34 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 34)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061035", "story_v_out_412061.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061035", "story_v_out_412061.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_412061", "412061035", "story_v_out_412061.awb")

						arg_141_1:RecordAudio("412061035", var_144_11)
						arg_141_1:RecordAudio("412061035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_412061", "412061035", "story_v_out_412061.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_412061", "412061035", "story_v_out_412061.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play412061036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 412061036
		arg_145_1.duration_ = 10.67

		local var_145_0 = {
			zh = 8.833,
			ja = 10.666
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play412061037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10076ui_story = arg_145_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).z)
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles = arg_145_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(1, -0.35, -4)
				arg_145_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).z)
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles = arg_145_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10076ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10076ui_story == nil then
				arg_145_1.var_.characterEffect10076ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10076ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10076ui_story then
				arg_145_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_4 = arg_145_1.actors_["1097ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1097ui_story == nil then
				arg_145_1.var_.characterEffect1097ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect1097ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1097ui_story then
				arg_145_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_148_6 = 0
			local var_148_7 = 0.9

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(412061036)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 36 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 36)

				if (36 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 36)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061036", "story_v_out_412061.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061036", "story_v_out_412061.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_412061", "412061036", "story_v_out_412061.awb")

						arg_145_1:RecordAudio("412061036", var_148_13)
						arg_145_1:RecordAudio("412061036", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_412061", "412061036", "story_v_out_412061.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_412061", "412061036", "story_v_out_412061.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412061037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 412061037
		arg_149_1.duration_ = 4.07

		local var_149_0 = {
			zh = 3.233,
			ja = 4.066
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
				arg_149_0:Play412061038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = arg_149_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) then
				if arg_149_1.var_.characterEffect1097ui_story and not isNil(arg_149_1.actors_["1097ui_story"]) then
					arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) and arg_149_1.var_.characterEffect1097ui_story then
				arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_2 = arg_149_1.actors_["10076ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10076ui_story == nil then
				arg_149_1.var_.characterEffect10076ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect10076ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10076ui_story then
				arg_149_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(412061037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)

				if (12 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 12)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061037", "story_v_out_412061.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061037", "story_v_out_412061.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_412061", "412061037", "story_v_out_412061.awb")

						arg_149_1:RecordAudio("412061037", var_152_11)
						arg_149_1:RecordAudio("412061037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_412061", "412061037", "story_v_out_412061.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_412061", "412061037", "story_v_out_412061.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play412061038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412061038
		arg_153_1.duration_ = 6

		local var_153_0 = {
			zh = 2.6,
			ja = 6
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play412061039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = arg_153_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) then
				if arg_153_1.var_.characterEffect1097ui_story and not isNil(arg_153_1.actors_["1097ui_story"]) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_156_1 = arg_153_1.actors_["10076ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10076ui_story == nil then
				arg_153_1.var_.characterEffect10076ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10076ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10076ui_story then
				arg_153_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_156_4 = 0
			local var_156_5 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(412061038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 6 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 6)

				if (6 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 6)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061038", "story_v_out_412061.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061038", "story_v_out_412061.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_412061", "412061038", "story_v_out_412061.awb")

						arg_153_1:RecordAudio("412061038", var_156_11)
						arg_153_1:RecordAudio("412061038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412061", "412061038", "story_v_out_412061.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412061", "412061038", "story_v_out_412061.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play412061039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412061039
		arg_157_1.duration_ = 7.37

		local var_157_0 = {
			zh = 4,
			ja = 7.366
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play412061040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) and arg_157_1.var_.characterEffect1097ui_story == nil then
				arg_157_1.var_.characterEffect1097ui_story = arg_157_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) then
				if arg_157_1.var_.characterEffect1097ui_story and not isNil(arg_157_1.actors_["1097ui_story"]) then
					arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1097ui_story"]) and arg_157_1.var_.characterEffect1097ui_story then
				arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_2 = arg_157_1.actors_["10076ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10076ui_story == nil then
				arg_157_1.var_.characterEffect10076ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect10076ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10076ui_story then
				arg_157_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_160_4 = 0
			local var_160_5 = 0.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(412061039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 17 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 17)

				if (17 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 17)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061039", "story_v_out_412061.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061039", "story_v_out_412061.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_412061", "412061039", "story_v_out_412061.awb")

						arg_157_1:RecordAudio("412061039", var_160_11)
						arg_157_1:RecordAudio("412061039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_412061", "412061039", "story_v_out_412061.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_412061", "412061039", "story_v_out_412061.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play412061040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 412061040
		arg_161_1.duration_ = 4.6

		local var_161_0 = {
			zh = 2.666,
			ja = 4.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play412061041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10077ui_story = arg_161_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).z)
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles = arg_161_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_161_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10077ui_story"].transform.position).z)
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10077ui_story"].transform.localEulerAngles = arg_161_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["10077ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect10077ui_story == nil then
				arg_161_1.var_.characterEffect10077ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect10077ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect10077ui_story then
				arg_161_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action4_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["10076ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10076ui_story = var_164_4.localPosition
			end

			local var_164_5 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 then
				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_5)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0, 100, 0)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			local var_164_6 = arg_161_1.actors_["10076ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10076ui_story == nil then
				arg_161_1.var_.characterEffect10076ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect10076ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10076ui_story then
				arg_161_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_164_8 = arg_161_1.actors_["1097ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1097ui_story = var_164_8.localPosition
			end

			local var_164_9 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 then
				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_9)
				var_164_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_8.position).x, (manager.ui.mainCamera.transform.position - var_164_8.position).y, (manager.ui.mainCamera.transform.position - var_164_8.position).z)
				var_164_8.localEulerAngles.z = 0
				var_164_8.localEulerAngles.x = 0
				var_164_8.localEulerAngles = var_164_8.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(0, 100, 0)
				var_164_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_8.position).x, (manager.ui.mainCamera.transform.position - var_164_8.position).y, (manager.ui.mainCamera.transform.position - var_164_8.position).z)
				var_164_8.localEulerAngles.z = 0
				var_164_8.localEulerAngles.x = 0
				var_164_8.localEulerAngles = var_164_8.localEulerAngles
			end

			local var_164_10 = arg_161_1.actors_["1097ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_10) and arg_161_1.var_.characterEffect1097ui_story == nil then
				arg_161_1.var_.characterEffect1097ui_story = var_164_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_11 and not isNil(var_164_10) then
				if arg_161_1.var_.characterEffect1097ui_story and not isNil(var_164_10) then
					arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_11)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_11 and arg_161_1.time_ < 0 + var_164_11 + arg_164_0 and not isNil(var_164_10) and arg_161_1.var_.characterEffect1097ui_story then
				arg_161_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_164_12 = 0
			local var_164_13 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_14 = arg_161_1:GetWordFromCfg(412061040)
				local var_164_15 = arg_161_1:FormatText(var_164_14.content)

				arg_161_1.text_.text = var_164_15

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_17 = 13 <= 0 and var_164_13 or var_164_13 * (utf8.len(var_164_15) / 13)

				if (13 <= 0 and var_164_13 or var_164_13 * (utf8.len(var_164_15) / 13)) > 0 and var_164_13 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_12
					end
				end

				arg_161_1.text_.text = var_164_15
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061040", "story_v_out_412061.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_412061", "412061040", "story_v_out_412061.awb") / 1000

					if var_164_18 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_12
					end

					if var_164_14.prefab_name ~= "" and arg_161_1.actors_[var_164_14.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_14.prefab_name].transform, "story_v_out_412061", "412061040", "story_v_out_412061.awb")

						arg_161_1:RecordAudio("412061040", var_164_19)
						arg_161_1:RecordAudio("412061040", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_412061", "412061040", "story_v_out_412061.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_412061", "412061040", "story_v_out_412061.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_13, arg_161_1.talkMaxDuration)

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_12) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_12 + var_164_20 and arg_161_1.time_ < var_164_12 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play412061041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 412061041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play412061042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10077ui_story"]) and arg_165_1.var_.characterEffect10077ui_story == nil then
				arg_165_1.var_.characterEffect10077ui_story = arg_165_1.actors_["10077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10077ui_story"]) then
				if arg_165_1.var_.characterEffect10077ui_story and not isNil(arg_165_1.actors_["10077ui_story"]) then
					arg_165_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10077ui_story"]) and arg_165_1.var_.characterEffect10077ui_story then
				arg_165_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["10077ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10077ui_story = var_168_1.localPosition
			end

			local var_168_2 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_2)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 100, 0)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			local var_168_3 = 0
			local var_168_4 = 0.7

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_5 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(412061041).content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 28 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 28)

				if (28 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 28)) > 0 and var_168_4 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_3
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_4, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_3) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_8 and arg_165_1.time_ < var_168_3 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play412061042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 412061042
		arg_169_1.duration_ = 5

		local var_169_0 = {
			zh = 3.6,
			ja = 5
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play412061043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10077ui_story = arg_169_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).z)
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles = arg_169_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_169_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10077ui_story"].transform.position).z)
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10077ui_story"].transform.localEulerAngles = arg_169_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["10077ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10077ui_story == nil then
				arg_169_1.var_.characterEffect10077ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect10077ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10077ui_story then
				arg_169_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action4_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.475

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(412061042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 19 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 19)

				if (19 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 19)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061042", "story_v_out_412061.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061042", "story_v_out_412061.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_412061", "412061042", "story_v_out_412061.awb")

						arg_169_1:RecordAudio("412061042", var_172_11)
						arg_169_1:RecordAudio("412061042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_412061", "412061042", "story_v_out_412061.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_412061", "412061042", "story_v_out_412061.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play412061043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 412061043
		arg_173_1.duration_ = 3.53

		local var_173_0 = {
			zh = 2.933,
			ja = 3.533
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play412061044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1097ui_story = arg_173_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).z)
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles = arg_173_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_173_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1097ui_story"].transform.position).z)
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1097ui_story"].transform.localEulerAngles = arg_173_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1097ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1097ui_story == nil then
				arg_173_1.var_.characterEffect1097ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1097ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1097ui_story then
				arg_173_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_176_4 = arg_173_1.actors_["10077ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10077ui_story = var_176_4.localPosition
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_4.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_4.localPosition = Vector3.New(0, 100, 0)
				var_176_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_4.position).x, (manager.ui.mainCamera.transform.position - var_176_4.position).y, (manager.ui.mainCamera.transform.position - var_176_4.position).z)
				var_176_4.localEulerAngles.z = 0
				var_176_4.localEulerAngles.x = 0
				var_176_4.localEulerAngles = var_176_4.localEulerAngles
			end

			local var_176_6 = arg_173_1.actors_["10077ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10077ui_story == nil then
				arg_173_1.var_.characterEffect10077ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect10077ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10077ui_story then
				arg_173_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_176_8 = 0
			local var_176_9 = 0.2

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(412061043)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 8 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 8)

				if (8 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 8)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061043", "story_v_out_412061.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061043", "story_v_out_412061.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_412061", "412061043", "story_v_out_412061.awb")

						arg_173_1:RecordAudio("412061043", var_176_15)
						arg_173_1:RecordAudio("412061043", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_412061", "412061043", "story_v_out_412061.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_412061", "412061043", "story_v_out_412061.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play412061044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412061044
		arg_177_1.duration_ = 12.47

		local var_177_0 = {
			zh = 9.033,
			ja = 12.466
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play412061045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.925

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(412061044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 37 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 37)

				if (37 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 37)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061044", "story_v_out_412061.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061044", "story_v_out_412061.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_412061", "412061044", "story_v_out_412061.awb")

						arg_177_1:RecordAudio("412061044", var_180_6)
						arg_177_1:RecordAudio("412061044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_412061", "412061044", "story_v_out_412061.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_412061", "412061044", "story_v_out_412061.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play412061045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412061045
		arg_181_1.duration_ = 5.73

		local var_181_0 = {
			zh = 4.7,
			ja = 5.733
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play412061046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1097ui_story = arg_181_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).z)
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles = arg_181_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_181_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1097ui_story"].transform.position).z)
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1097ui_story"].transform.localEulerAngles = arg_181_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1097ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1097ui_story == nil then
				arg_181_1.var_.characterEffect1097ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1097ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1097ui_story then
				arg_181_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_4 = 0
			local var_184_5 = 0.475

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(412061045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 19 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 19)

				if (19 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 19)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061045", "story_v_out_412061.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061045", "story_v_out_412061.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_412061", "412061045", "story_v_out_412061.awb")

						arg_181_1:RecordAudio("412061045", var_184_11)
						arg_181_1:RecordAudio("412061045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_412061", "412061045", "story_v_out_412061.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_412061", "412061045", "story_v_out_412061.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play412061046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412061046
		arg_185_1.duration_ = 8.1

		local var_185_0 = {
			zh = 6.566,
			ja = 8.1
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play412061047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.bgs_.EN0111 == nil then
				local var_188_0 = Object.Instantiate(arg_185_1.paintGo_)

				var_188_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0111")
				var_188_0.name = "EN0111"
				var_188_0.transform.parent = arg_185_1.stage_.transform
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.bgs_.EN0111 = var_188_0
			end

			if 1.999999999999 < arg_185_1.time_ and arg_185_1.time_ <= 1.999999999999 + arg_188_0 then
				local var_188_1 = arg_185_1.bgs_.EN0111

				arg_185_1.bgs_.EN0111.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_2 = var_188_1:GetComponent("SpriteRenderer")

				if var_188_2 and var_188_2.sprite then
					local var_188_3 = 2 * (var_188_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_1.transform.localScale = Vector3.New(var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, var_188_3 / var_188_2.sprite.bounds.size.y < var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x and var_188_3 * manager.ui.mainCameraCom_.aspect / var_188_2.sprite.bounds.size.x or var_188_3 / var_188_2.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "EN0111" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_4 = 3.999999999999

			if 3.999999999999 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_4 + 0.3 and arg_185_1.time_ < var_188_4 + 0.3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_5 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_6 = 2

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_6 then
				local var_188_7 = Color.New(0, 0, 0)

				var_188_7.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_5) / var_188_6)
				arg_185_1.mask_.color = var_188_7
			end

			if arg_185_1.time_ >= var_188_5 + var_188_6 and arg_185_1.time_ < var_188_5 + var_188_6 + arg_188_0 then
				local var_188_8 = Color.New(0, 0, 0)

				var_188_8.a = 1
				arg_185_1.mask_.color = var_188_8
			end

			local var_188_9 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_10 = 2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 then
				local var_188_11 = Color.New(0, 0, 0)

				var_188_11.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_9) / var_188_10)
				arg_185_1.mask_.color = var_188_11
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 then
				local var_188_12 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_12.a = 0
				arg_185_1.mask_.color = var_188_12
			end

			local var_188_13 = arg_185_1.bgs_.EN0111.transform

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1.var_.moveOldPosEN0111 = var_188_13.localPosition
			end

			local var_188_14 = 2

			if 2 <= arg_185_1.time_ and arg_185_1.time_ < 2 + var_188_14 then
				var_188_13.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosEN0111, Vector3.New(0, 1, 9.5), (arg_185_1.time_ - 2) / var_188_14)
			end

			if arg_185_1.time_ >= 2 + var_188_14 and arg_185_1.time_ < 2 + var_188_14 + arg_188_0 then
				var_188_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_188_15 = arg_185_1.actors_["1097ui_story"].transform

			if 1.966 < arg_185_1.time_ and arg_185_1.time_ <= 1.966 + arg_188_0 then
				arg_185_1.var_.moveOldPos1097ui_story = var_188_15.localPosition
			end

			local var_188_16 = 0.001

			if 1.966 <= arg_185_1.time_ and arg_185_1.time_ < 1.966 + var_188_16 then
				var_188_15.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 1.966) / var_188_16)
				var_188_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_15.position).x, (manager.ui.mainCamera.transform.position - var_188_15.position).y, (manager.ui.mainCamera.transform.position - var_188_15.position).z)
				var_188_15.localEulerAngles.z = 0
				var_188_15.localEulerAngles.x = 0
				var_188_15.localEulerAngles = var_188_15.localEulerAngles
			end

			if arg_185_1.time_ >= 1.966 + var_188_16 and arg_185_1.time_ < 1.966 + var_188_16 + arg_188_0 then
				var_188_15.localPosition = Vector3.New(0, 100, 0)
				var_188_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_15.position).x, (manager.ui.mainCamera.transform.position - var_188_15.position).y, (manager.ui.mainCamera.transform.position - var_188_15.position).z)
				var_188_15.localEulerAngles.z = 0
				var_188_15.localEulerAngles.x = 0
				var_188_15.localEulerAngles = var_188_15.localEulerAngles
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_17 = 4
			local var_188_18 = 0.225

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_17 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_19 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_19:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_20 = arg_185_1:GetWordFromCfg(412061046)
				local var_188_21 = arg_185_1:FormatText(var_188_20.content)

				arg_185_1.text_.text = var_188_21

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_23 = 9 <= 0 and var_188_18 or var_188_18 * (utf8.len(var_188_21) / 9)

				if (9 <= 0 and var_188_18 or var_188_18 * (utf8.len(var_188_21) / 9)) > 0 and var_188_18 < var_188_23 then
					arg_185_1.talkMaxDuration = var_188_23
					var_188_17 = var_188_17 + 0.3

					if var_188_23 + var_188_17 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_17
					end
				end

				arg_185_1.text_.text = var_188_21
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061046", "story_v_out_412061.awb") ~= 0 then
					local var_188_24 = manager.audio:GetVoiceLength("story_v_out_412061", "412061046", "story_v_out_412061.awb") / 1000

					if var_188_24 + var_188_17 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_24 + var_188_17
					end

					if var_188_20.prefab_name ~= "" and arg_185_1.actors_[var_188_20.prefab_name] ~= nil then
						local var_188_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_20.prefab_name].transform, "story_v_out_412061", "412061046", "story_v_out_412061.awb")

						arg_185_1:RecordAudio("412061046", var_188_25)
						arg_185_1:RecordAudio("412061046", var_188_25)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_412061", "412061046", "story_v_out_412061.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_412061", "412061046", "story_v_out_412061.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_26 = var_188_17 + 0.3
			local var_188_27 = math.max(var_188_18, arg_185_1.talkMaxDuration)

			if var_188_17 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_26 + var_188_27 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_26) / var_188_27

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_26 + var_188_27 and arg_185_1.time_ < var_188_26 + var_188_27 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play412061047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 412061047
		arg_191_1.duration_ = 1.97

		local var_191_0 = {
			zh = 1.7,
			ja = 1.966
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play412061048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1097ui_story"]) and arg_191_1.var_.characterEffect1097ui_story == nil then
				arg_191_1.var_.characterEffect1097ui_story = arg_191_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1097ui_story"]) then
				if arg_191_1.var_.characterEffect1097ui_story and not isNil(arg_191_1.actors_["1097ui_story"]) then
					arg_191_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1097ui_story"]) and arg_191_1.var_.characterEffect1097ui_story then
				arg_191_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.175

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(412061047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 7 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 7)

				if (7 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 7)) > 0 and var_194_2 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061047", "story_v_out_412061.awb") ~= 0 then
					local var_194_7 = manager.audio:GetVoiceLength("story_v_out_412061", "412061047", "story_v_out_412061.awb") / 1000

					if var_194_7 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_1
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_412061", "412061047", "story_v_out_412061.awb")

						arg_191_1:RecordAudio("412061047", var_194_8)
						arg_191_1:RecordAudio("412061047", var_194_8)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_412061", "412061047", "story_v_out_412061.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_412061", "412061047", "story_v_out_412061.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_9 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_9 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_9

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_9 and arg_191_1.time_ < var_194_1 + var_194_9 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play412061048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 412061048
		arg_195_1.duration_ = 4.53

		local var_195_0 = {
			zh = 4.533,
			ja = 3.866
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play412061049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(412061048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 18 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 18)

				if (18 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 18)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061048", "story_v_out_412061.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061048", "story_v_out_412061.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_412061", "412061048", "story_v_out_412061.awb")

						arg_195_1:RecordAudio("412061048", var_198_6)
						arg_195_1:RecordAudio("412061048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_412061", "412061048", "story_v_out_412061.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_412061", "412061048", "story_v_out_412061.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play412061049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 412061049
		arg_199_1.duration_ = 5.83

		local var_199_0 = {
			zh = 3.166,
			ja = 5.833
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play412061050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.4

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(412061049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 16 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 16)

				if (16 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 16)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061049", "story_v_out_412061.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061049", "story_v_out_412061.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_412061", "412061049", "story_v_out_412061.awb")

						arg_199_1:RecordAudio("412061049", var_202_6)
						arg_199_1:RecordAudio("412061049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_412061", "412061049", "story_v_out_412061.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_412061", "412061049", "story_v_out_412061.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play412061050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 412061050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play412061051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(412061050).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 44 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 44)

				if (44 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 44)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play412061051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 412061051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play412061052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.8

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(412061051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 32 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 32)

				if (32 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 32)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play412061052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412061052
		arg_211_1.duration_ = 7.77

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play412061053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0.6 < arg_211_1.time_ and arg_211_1.time_ <= 0.6 + arg_214_0 then
				local var_214_0 = arg_211_1.bgs_.ST86

				arg_211_1.bgs_.ST86.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_214_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_1 = var_214_0:GetComponent("SpriteRenderer")

				if var_214_1 and var_214_1.sprite then
					local var_214_2 = 2 * (var_214_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_214_0.transform.localScale = Vector3.New(var_214_2 / var_214_1.sprite.bounds.size.y < var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x and var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x or var_214_2 / var_214_1.sprite.bounds.size.y, var_214_2 / var_214_1.sprite.bounds.size.y < var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x and var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x or var_214_2 / var_214_1.sprite.bounds.size.y, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "ST86" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_3 = 2.599999999999

			if 2.599999999999 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_3 + 0.3 and arg_211_1.time_ < var_214_3 + 0.3 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_4 = 0.6

			if 0.6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_5 = 2

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_5 then
				local var_214_6 = Color.New(1, 1, 1)

				var_214_6.a = Mathf.Lerp(1, 0, (arg_211_1.time_ - var_214_4) / var_214_5)
				arg_211_1.mask_.color = var_214_6
			end

			if arg_211_1.time_ >= var_214_4 + var_214_5 and arg_211_1.time_ < var_214_4 + var_214_5 + arg_214_0 then
				local var_214_7 = Color.New(1, 1, 1)

				arg_211_1.mask_.enabled = false
				var_214_7.a = 0
				arg_211_1.mask_.color = var_214_7
			end

			local var_214_8 = manager.ui.mainCamera.transform

			if 2.26666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 2.26666666666667 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_8.localPosition
			end

			local var_214_9 = 0.6

			if 2.26666666666667 <= arg_211_1.time_ and arg_211_1.time_ < 2.26666666666667 + var_214_9 then
				local var_214_10, var_214_11 = math.modf((arg_211_1.time_ - 2.26666666666667) / 0.066)

				var_214_8.localPosition = Vector3.New(var_214_11 * 0.13, var_214_11 * 0.13, var_214_11 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= 2.26666666666667 + var_214_9 and arg_211_1.time_ < 2.26666666666667 + var_214_9 + arg_214_0 then
				var_214_8.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_12 = 2.26666666666667

			if 2.26666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_12 + 0.6 and arg_211_1.time_ < var_214_12 + 0.6 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_13 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_13 + 0.6 and arg_211_1.time_ < var_214_13 + 0.6 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_14 = 2.76666666666667
			local var_214_15 = 1.25

			if 2.76666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_16 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_16:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_17 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(412061052).content)

				arg_211_1.text_.text = var_214_17

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_19 = 50 <= 0 and var_214_15 or var_214_15 * (utf8.len(var_214_17) / 50)

				if (50 <= 0 and var_214_15 or var_214_15 * (utf8.len(var_214_17) / 50)) > 0 and var_214_15 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19
					var_214_14 = var_214_14 + 0.3

					if var_214_19 + var_214_14 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_14
					end
				end

				arg_211_1.text_.text = var_214_17
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = var_214_14 + 0.3
			local var_214_21 = math.max(var_214_15, arg_211_1.talkMaxDuration)

			if var_214_14 + 0.3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_20 + var_214_21 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_20) / var_214_21

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_20 + var_214_21 and arg_211_1.time_ < var_214_20 + var_214_21 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play412061053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 412061053
		arg_217_1.duration_ = 3.37

		local var_217_0 = {
			zh = 1.999999999999,
			ja = 3.366
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play412061054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1097ui_story = arg_217_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).z)
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles = arg_217_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_217_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1097ui_story"].transform.position).z)
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1097ui_story"].transform.localEulerAngles = arg_217_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1097ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1097ui_story == nil then
				arg_217_1.var_.characterEffect1097ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1097ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1097ui_story then
				arg_217_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_220_4 = 0
			local var_220_5 = 0.15

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(412061053)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 6 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 6)

				if (6 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 6)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061053", "story_v_out_412061.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061053", "story_v_out_412061.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_412061", "412061053", "story_v_out_412061.awb")

						arg_217_1:RecordAudio("412061053", var_220_11)
						arg_217_1:RecordAudio("412061053", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_412061", "412061053", "story_v_out_412061.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_412061", "412061053", "story_v_out_412061.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play412061054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 412061054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play412061055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1097ui_story = arg_221_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).z)
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles = arg_221_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1097ui_story"].transform.position).z)
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1097ui_story"].transform.localEulerAngles = arg_221_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1097ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1097ui_story == nil then
				arg_221_1.var_.characterEffect1097ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1097ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1097ui_story then
				arg_221_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_224_3 = 0
			local var_224_4 = 0.65

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(412061054).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 26 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 26)

				if (26 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 26)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play412061055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 412061055
		arg_225_1.duration_ = 8.7

		local var_225_0 = {
			zh = 6.066,
			ja = 8.7
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play412061056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if arg_225_1.actors_["2117ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2117ui_story"))) then
				local var_228_0 = Object.Instantiate(Asset.Load("Char/" .. "2117ui_story"), arg_225_1.stage_.transform)

				var_228_0.name = "2117ui_story"
				var_228_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["2117ui_story"] = var_228_0

				local var_228_1 = var_228_0:GetComponentInChildren(typeof(CharacterEffect))

				var_228_1.enabled = true

				local var_228_2 = GameObjectTools.GetOrAddComponent(var_228_0, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(false)
				end

				arg_225_1:ShowWeapon(var_228_1.transform, false)

				arg_225_1.var_["2117ui_story" .. "Animator"] = var_228_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_225_1.var_["2117ui_story" .. "Animator"].applyRootMotion = true
				arg_225_1.var_["2117ui_story" .. "LipSync"] = var_228_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_228_3 = arg_225_1.actors_["2117ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos2117ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos2117ui_story, Vector3.New(0, -0.52, -3.85), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, -0.52, -3.85)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["2117ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect2117ui_story == nil then
				arg_225_1.var_.characterEffect2117ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect2117ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect2117ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect2117ui_story then
				arg_225_1.var_.characterEffect2117ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/story2117/story2117action/2117action1_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_8 = 0
			local var_228_9 = 0.75

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[914].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_10 = arg_225_1:GetWordFromCfg(412061055)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 30 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 30)

				if (30 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 30)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061055", "story_v_out_412061.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061055", "story_v_out_412061.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_out_412061", "412061055", "story_v_out_412061.awb")

						arg_225_1:RecordAudio("412061055", var_228_15)
						arg_225_1:RecordAudio("412061055", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_412061", "412061055", "story_v_out_412061.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_412061", "412061055", "story_v_out_412061.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play412061056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 412061056
		arg_229_1.duration_ = 7.83

		local var_229_0 = {
			zh = 6.4,
			ja = 7.833
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play412061057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[914].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(412061056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061056", "story_v_out_412061.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061056", "story_v_out_412061.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_412061", "412061056", "story_v_out_412061.awb")

						arg_229_1:RecordAudio("412061056", var_232_6)
						arg_229_1:RecordAudio("412061056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_412061", "412061056", "story_v_out_412061.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_412061", "412061056", "story_v_out_412061.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play412061057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 412061057
		arg_233_1.duration_ = 6.77

		local var_233_0 = {
			zh = 6.766,
			ja = 4.3
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play412061058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10077ui_story = arg_233_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).z)
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles = arg_233_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_233_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10077ui_story"].transform.position).z)
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10077ui_story"].transform.localEulerAngles = arg_233_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["10077ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10077ui_story == nil then
				arg_233_1.var_.characterEffect10077ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect10077ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10077ui_story then
				arg_233_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = arg_233_1.actors_["2117ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos2117ui_story = var_236_4.localPosition
			end

			local var_236_5 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 then
				var_236_4.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos2117ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_5)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 then
				var_236_4.localPosition = Vector3.New(0, 100, 0)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			local var_236_6 = arg_233_1.actors_["2117ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect2117ui_story == nil then
				arg_233_1.var_.characterEffect2117ui_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_7 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 and not isNil(var_236_6) then
				if arg_233_1.var_.characterEffect2117ui_story and not isNil(var_236_6) then
					arg_233_1.var_.characterEffect2117ui_story.fillFlat = true
					arg_233_1.var_.characterEffect2117ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_7)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect2117ui_story then
				arg_233_1.var_.characterEffect2117ui_story.fillFlat = true
				arg_233_1.var_.characterEffect2117ui_story.fillRatio = 0.5
			end

			local var_236_8 = 0
			local var_236_9 = 0.9

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(412061057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 36 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 36)

				if (36 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 36)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061057", "story_v_out_412061.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061057", "story_v_out_412061.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_412061", "412061057", "story_v_out_412061.awb")

						arg_233_1:RecordAudio("412061057", var_236_15)
						arg_233_1:RecordAudio("412061057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_412061", "412061057", "story_v_out_412061.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_412061", "412061057", "story_v_out_412061.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play412061058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 412061058
		arg_237_1.duration_ = 5.43

		local var_237_0 = {
			zh = 3.033,
			ja = 5.433
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play412061059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10077ui_story = arg_237_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).z)
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles = arg_237_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10077ui_story"].transform.position).z)
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10077ui_story"].transform.localEulerAngles = arg_237_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["10077ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10077ui_story == nil then
				arg_237_1.var_.characterEffect10077ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect10077ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_2)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10077ui_story then
				arg_237_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_240_3 = arg_237_1.actors_["2117ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos2117ui_story = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos2117ui_story, Vector3.New(0, -0.52, -3.85), (arg_237_1.time_ - 0) / var_240_4)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(0, -0.52, -3.85)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			local var_240_5 = arg_237_1.actors_["2117ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect2117ui_story == nil then
				arg_237_1.var_.characterEffect2117ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.characterEffect2117ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect2117ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect2117ui_story then
				arg_237_1.var_.characterEffect2117ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/story2117/story2117action/2117action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_8 = 0
			local var_240_9 = 0.3

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[914].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(412061058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 12 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 12)

				if (12 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 12)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061058", "story_v_out_412061.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061058", "story_v_out_412061.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_412061", "412061058", "story_v_out_412061.awb")

						arg_237_1:RecordAudio("412061058", var_240_15)
						arg_237_1:RecordAudio("412061058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_412061", "412061058", "story_v_out_412061.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_412061", "412061058", "story_v_out_412061.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play412061059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 412061059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play412061060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos2117ui_story = arg_241_1.actors_["2117ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["2117ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos2117ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["2117ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).z)
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles = arg_241_1.actors_["2117ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["2117ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["2117ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["2117ui_story"].transform.position).z)
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["2117ui_story"].transform.localEulerAngles = arg_241_1.actors_["2117ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["2117ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect2117ui_story == nil then
				arg_241_1.var_.characterEffect2117ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect2117ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect2117ui_story.fillFlat = true
					arg_241_1.var_.characterEffect2117ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect2117ui_story then
				arg_241_1.var_.characterEffect2117ui_story.fillFlat = true
				arg_241_1.var_.characterEffect2117ui_story.fillRatio = 0.5
			end

			local var_244_3 = 0
			local var_244_4 = 1.15

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(412061059).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 46 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 46)

				if (46 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 46)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play412061060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 412061060
		arg_245_1.duration_ = 5.8

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play412061061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_9000

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.var_.effectgongshi1

				if not arg_245_1.var_.effectgongshi1 then
					var_248_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_248_0.name = "gongshi1"
					arg_245_1.var_.effectgongshi1 = var_248_0
				else
					var_248_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_248_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_248_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.266666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 0.266666666666667 + arg_248_0 then
				local var_248_2 = arg_245_1.var_.effectgongshi1

				if not arg_245_1.var_.effectgongshi1 then
					var_248_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_248_2.name = "gongshi1"
					arg_245_1.var_.effectgongshi1 = var_248_2
				else
					var_248_2.transform:SetParent(var_248_9000)
				end

				var_248_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_248_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_248_4 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_4 + 0.8 and arg_245_1.time_ < var_248_4 + 0.8 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_5 = manager.ui.mainCamera.transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_5.localPosition
			end

			local var_248_6 = 0.8

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 then
				local var_248_7, var_248_8 = math.modf((arg_245_1.time_ - 0) / 0.066)

				var_248_5.localPosition = Vector3.New(var_248_8 * 0.13, var_248_8 * 0.13, var_248_8 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 then
				var_248_5.localPosition = arg_245_1.var_.shakeOldPos
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_whoosh", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_10 = 0.8
			local var_248_11 = 1.425

			if 0.8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_12 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_12:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_13 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(412061060).content)

				arg_245_1.text_.text = var_248_13

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_15 = 57 <= 0 and var_248_11 or var_248_11 * (utf8.len(var_248_13) / 57)

				if (57 <= 0 and var_248_11 or var_248_11 * (utf8.len(var_248_13) / 57)) > 0 and var_248_11 < var_248_15 then
					arg_245_1.talkMaxDuration = var_248_15
					var_248_10 = var_248_10 + 0.3

					if var_248_15 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_10
					end
				end

				arg_245_1.text_.text = var_248_13
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = var_248_10 + 0.3
			local var_248_17 = math.max(var_248_11, arg_245_1.talkMaxDuration)

			if var_248_10 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_16) / var_248_17

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play412061061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 412061061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play412061062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.25

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(412061061).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 50 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 50)

				if (50 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 50)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play412061062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 412061062
		arg_255_1.duration_ = 11

		local var_255_0 = {
			zh = 3.7,
			ja = 11
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play412061063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos2117ui_story = arg_255_1.actors_["2117ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["2117ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos2117ui_story, Vector3.New(0, -0.52, -3.85), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["2117ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).z)
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles = arg_255_1.actors_["2117ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["2117ui_story"].transform.localPosition = Vector3.New(0, -0.52, -3.85)
				arg_255_1.actors_["2117ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2117ui_story"].transform.position).z)
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["2117ui_story"].transform.localEulerAngles = arg_255_1.actors_["2117ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["2117ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect2117ui_story == nil then
				arg_255_1.var_.characterEffect2117ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect2117ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect2117ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect2117ui_story then
				arg_255_1.var_.characterEffect2117ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/story2117/story2117action/2117action1_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("2117ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_258_4 = 0
			local var_258_5 = 0.425

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[914].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(412061062)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 17 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 17)

				if (17 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 17)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061062", "story_v_out_412061.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061062", "story_v_out_412061.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_412061", "412061062", "story_v_out_412061.awb")

						arg_255_1:RecordAudio("412061062", var_258_11)
						arg_255_1:RecordAudio("412061062", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_412061", "412061062", "story_v_out_412061.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_412061", "412061062", "story_v_out_412061.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play412061063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 412061063
		arg_259_1.duration_ = 7.53

		local var_259_0 = {
			zh = 3.633,
			ja = 7.533
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play412061064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10077ui_story = arg_259_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).z)
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles = arg_259_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_259_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10077ui_story"].transform.position).z)
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10077ui_story"].transform.localEulerAngles = arg_259_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["10077ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10077ui_story == nil then
				arg_259_1.var_.characterEffect10077ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect10077ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10077ui_story then
				arg_259_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action6_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_4 = arg_259_1.actors_["2117ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos2117ui_story = var_262_4.localPosition
			end

			local var_262_5 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 then
				var_262_4.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos2117ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_5)
				var_262_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_4.position).x, (manager.ui.mainCamera.transform.position - var_262_4.position).y, (manager.ui.mainCamera.transform.position - var_262_4.position).z)
				var_262_4.localEulerAngles.z = 0
				var_262_4.localEulerAngles.x = 0
				var_262_4.localEulerAngles = var_262_4.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 then
				var_262_4.localPosition = Vector3.New(0, 100, 0)
				var_262_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_4.position).x, (manager.ui.mainCamera.transform.position - var_262_4.position).y, (manager.ui.mainCamera.transform.position - var_262_4.position).z)
				var_262_4.localEulerAngles.z = 0
				var_262_4.localEulerAngles.x = 0
				var_262_4.localEulerAngles = var_262_4.localEulerAngles
			end

			local var_262_6 = 0
			local var_262_7 = 0.5

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_8 = arg_259_1:GetWordFromCfg(412061063)
				local var_262_9 = arg_259_1:FormatText(var_262_8.content)

				arg_259_1.text_.text = var_262_9

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 20 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 20)

				if (20 <= 0 and var_262_7 or var_262_7 * (utf8.len(var_262_9) / 20)) > 0 and var_262_7 < var_262_11 then
					arg_259_1.talkMaxDuration = var_262_11

					if var_262_11 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_9
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061063", "story_v_out_412061.awb") ~= 0 then
					local var_262_12 = manager.audio:GetVoiceLength("story_v_out_412061", "412061063", "story_v_out_412061.awb") / 1000

					if var_262_12 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_6
					end

					if var_262_8.prefab_name ~= "" and arg_259_1.actors_[var_262_8.prefab_name] ~= nil then
						local var_262_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_8.prefab_name].transform, "story_v_out_412061", "412061063", "story_v_out_412061.awb")

						arg_259_1:RecordAudio("412061063", var_262_13)
						arg_259_1:RecordAudio("412061063", var_262_13)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_412061", "412061063", "story_v_out_412061.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_412061", "412061063", "story_v_out_412061.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2117ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play412061064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 412061064
		arg_263_1.duration_ = 5.7

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play412061065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_9000

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10077ui_story = arg_263_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).z)
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles = arg_263_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["10077ui_story"].transform.position).z)
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["10077ui_story"].transform.localEulerAngles = arg_263_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["10077ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10077ui_story == nil then
				arg_263_1.var_.characterEffect10077ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect10077ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_2)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect10077ui_story then
				arg_263_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				local var_266_3 = arg_263_1.var_.effectxiaoyang1

				if not arg_263_1.var_.effectxiaoyang1 then
					var_266_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_266_3.name = "xiaoyang1"
					arg_263_1.var_.effectxiaoyang1 = var_266_3
				else
					var_266_3.transform:SetParent(var_266_9000)
				end

				var_266_3.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_266_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_263_1.time_ and arg_263_1.time_ <= 1 + arg_266_0 then
				if arg_263_1.var_.effectxiaoyang1 then
					Object.Destroy(arg_263_1.var_.effectxiaoyang1)

					arg_263_1.var_.effectxiaoyang1 = nil
				end
			end

			if 0.233333333333333 < arg_263_1.time_ and arg_263_1.time_ <= 0.233333333333333 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_whoosh", "")
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_7 = 0.7
			local var_266_8 = 1.35

			if 0.7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_9 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_9:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(412061064).content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_12 = 54 <= 0 and var_266_8 or var_266_8 * (utf8.len(var_266_10) / 54)

				if (54 <= 0 and var_266_8 or var_266_8 * (utf8.len(var_266_10) / 54)) > 0 and var_266_8 < var_266_12 then
					arg_263_1.talkMaxDuration = var_266_12
					var_266_7 = var_266_7 + 0.3

					if var_266_12 + var_266_7 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_7
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = var_266_7 + 0.3
			local var_266_14 = math.max(var_266_8, arg_263_1.talkMaxDuration)

			if var_266_7 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_13 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_13) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_13 + var_266_14 and arg_263_1.time_ < var_266_13 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play412061065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 412061065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play412061066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.625

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(412061065).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 25)

				if (25 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 25)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play412061066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 412061066
		arg_273_1.duration_ = 6.63

		local var_273_0 = {
			zh = 5.4,
			ja = 6.633
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play412061067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10077ui_story = arg_273_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).z)
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles = arg_273_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_273_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10077ui_story"].transform.position).z)
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10077ui_story"].transform.localEulerAngles = arg_273_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10077ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10077ui_story == nil then
				arg_273_1.var_.characterEffect10077ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10077ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10077ui_story then
				arg_273_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_4 = 0
			local var_276_5 = 0.525

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(412061066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 21 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 21)

				if (21 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 21)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061066", "story_v_out_412061.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061066", "story_v_out_412061.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_412061", "412061066", "story_v_out_412061.awb")

						arg_273_1:RecordAudio("412061066", var_276_11)
						arg_273_1:RecordAudio("412061066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_412061", "412061066", "story_v_out_412061.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_412061", "412061066", "story_v_out_412061.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play412061067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 412061067
		arg_277_1.duration_ = 4.03

		local var_277_0 = {
			zh = 4.033,
			ja = 1.999999999999
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play412061068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1097ui_story = arg_277_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).z)
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles = arg_277_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_277_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1097ui_story"].transform.position).z)
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1097ui_story"].transform.localEulerAngles = arg_277_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1097ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1097ui_story == nil then
				arg_277_1.var_.characterEffect1097ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1097ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1097ui_story then
				arg_277_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_280_4 = arg_277_1.actors_["10077ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10077ui_story = var_280_4.localPosition
			end

			local var_280_5 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 then
				var_280_4.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_5)
				var_280_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_4.position).x, (manager.ui.mainCamera.transform.position - var_280_4.position).y, (manager.ui.mainCamera.transform.position - var_280_4.position).z)
				var_280_4.localEulerAngles.z = 0
				var_280_4.localEulerAngles.x = 0
				var_280_4.localEulerAngles = var_280_4.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 then
				var_280_4.localPosition = Vector3.New(0, 100, 0)
				var_280_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_4.position).x, (manager.ui.mainCamera.transform.position - var_280_4.position).y, (manager.ui.mainCamera.transform.position - var_280_4.position).z)
				var_280_4.localEulerAngles.z = 0
				var_280_4.localEulerAngles.x = 0
				var_280_4.localEulerAngles = var_280_4.localEulerAngles
			end

			local var_280_6 = arg_277_1.actors_["10077ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect10077ui_story == nil then
				arg_277_1.var_.characterEffect10077ui_story = var_280_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_7 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 and not isNil(var_280_6) then
				if arg_277_1.var_.characterEffect10077ui_story and not isNil(var_280_6) then
					arg_277_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_7)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect10077ui_story then
				arg_277_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_280_8 = 0
			local var_280_9 = 0.275

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(412061067)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 11 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 11)

				if (11 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 11)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061067", "story_v_out_412061.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061067", "story_v_out_412061.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_412061", "412061067", "story_v_out_412061.awb")

						arg_277_1:RecordAudio("412061067", var_280_15)
						arg_277_1:RecordAudio("412061067", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_412061", "412061067", "story_v_out_412061.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_412061", "412061067", "story_v_out_412061.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play412061068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 412061068
		arg_281_1.duration_ = 6.03

		local var_281_0 = {
			zh = 6.033,
			ja = 5.633
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play412061069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.65

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(412061068)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 26 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 26)

				if (26 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 26)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061068", "story_v_out_412061.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_412061", "412061068", "story_v_out_412061.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_412061", "412061068", "story_v_out_412061.awb")

						arg_281_1:RecordAudio("412061068", var_284_7)
						arg_281_1:RecordAudio("412061068", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_412061", "412061068", "story_v_out_412061.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_412061", "412061068", "story_v_out_412061.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play412061069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 412061069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play412061070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1097ui_story = arg_285_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).z)
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles = arg_285_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1097ui_story"].transform.position).z)
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1097ui_story"].transform.localEulerAngles = arg_285_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1097ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1097ui_story == nil then
				arg_285_1.var_.characterEffect1097ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1097ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_2)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1097ui_story then
				arg_285_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_treat", "")
			end

			local var_288_4 = 0
			local var_288_5 = 0.675

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(412061069).content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 27 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 27)

				if (27 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 27)) > 0 and var_288_5 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_9 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_9 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_9

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_9 and arg_285_1.time_ < var_288_4 + var_288_9 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play412061070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 412061070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play412061071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.9

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(412061070).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 36 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 36)

				if (36 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 36)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play412061071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 412061071
		arg_293_1.duration_ = 4.43

		local var_293_0 = {
			zh = 4.433,
			ja = 4.166
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play412061072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_9000

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10077ui_story = arg_293_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).z)
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles = arg_293_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_293_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10077ui_story"].transform.position).z)
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10077ui_story"].transform.localEulerAngles = arg_293_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["10077ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10077ui_story == nil then
				arg_293_1.var_.characterEffect10077ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect10077ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10077ui_story then
				arg_293_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action3_2")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				local var_296_4 = arg_293_1.var_.effect10077ui_story俄尼里伊治疗

				if not arg_293_1.var_.effect10077ui_story俄尼里伊治疗 then
					var_296_4 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_293_1.actors_["10077ui_story"].transform)
					var_296_4.name = "俄尼里伊治疗"
					arg_293_1.var_.effect10077ui_story俄尼里伊治疗 = var_296_4
				else
					var_296_4.transform:SetParent(var_296_9000)
				end

				var_296_4.transform.localPosition = Vector3.New(0, 1.02, 0.3)
				var_296_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				if arg_293_1.var_.effect10077ui_story俄尼里伊治疗 then
					Object.Destroy(arg_293_1.var_.effect10077ui_story俄尼里伊治疗)

					arg_293_1.var_.effect10077ui_story俄尼里伊治疗 = nil
				end
			end

			local var_296_7 = 0
			local var_296_8 = 0.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_9 = arg_293_1:GetWordFromCfg(412061071)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_12 = 18 <= 0 and var_296_8 or var_296_8 * (utf8.len(var_296_10) / 18)

				if (18 <= 0 and var_296_8 or var_296_8 * (utf8.len(var_296_10) / 18)) > 0 and var_296_8 < var_296_12 then
					arg_293_1.talkMaxDuration = var_296_12

					if var_296_12 + var_296_7 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_7
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061071", "story_v_out_412061.awb") ~= 0 then
					local var_296_13 = manager.audio:GetVoiceLength("story_v_out_412061", "412061071", "story_v_out_412061.awb") / 1000

					if var_296_13 + var_296_7 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_7
					end

					if var_296_9.prefab_name ~= "" and arg_293_1.actors_[var_296_9.prefab_name] ~= nil then
						local var_296_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_9.prefab_name].transform, "story_v_out_412061", "412061071", "story_v_out_412061.awb")

						arg_293_1:RecordAudio("412061071", var_296_14)
						arg_293_1:RecordAudio("412061071", var_296_14)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_412061", "412061071", "story_v_out_412061.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_412061", "412061071", "story_v_out_412061.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_15 = math.max(var_296_8, arg_293_1.talkMaxDuration)

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_15 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_7) / var_296_15

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_7 + var_296_15 and arg_293_1.time_ < var_296_7 + var_296_15 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play412061072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 412061072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play412061073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10077ui_story = arg_297_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).z)
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles = arg_297_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10077ui_story"].transform.position).z)
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10077ui_story"].transform.localEulerAngles = arg_297_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["10077ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10077ui_story == nil then
				arg_297_1.var_.characterEffect10077ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect10077ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_2)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect10077ui_story then
				arg_297_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_300_3 = 0
			local var_300_4 = 0.675

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_5 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(412061072).content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 27 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 27)

				if (27 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 27)) > 0 and var_300_4 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_3
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_4, arg_297_1.talkMaxDuration)

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_3) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_3 + var_300_8 and arg_297_1.time_ < var_300_3 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play412061073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 412061073
		arg_301_1.duration_ = 3.77

		local var_301_0 = {
			zh = 3.4,
			ja = 3.766
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play412061074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1097ui_story = arg_301_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).z)
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles = arg_301_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_301_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1097ui_story"].transform.position).z)
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1097ui_story"].transform.localEulerAngles = arg_301_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1097ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1097ui_story == nil then
				arg_301_1.var_.characterEffect1097ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1097ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1097ui_story then
				arg_301_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_304_4 = 0
			local var_304_5 = 0.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(412061073)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)

				if (12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061073", "story_v_out_412061.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061073", "story_v_out_412061.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_412061", "412061073", "story_v_out_412061.awb")

						arg_301_1:RecordAudio("412061073", var_304_11)
						arg_301_1:RecordAudio("412061073", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_412061", "412061073", "story_v_out_412061.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_412061", "412061073", "story_v_out_412061.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play412061074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 412061074
		arg_305_1.duration_ = 5.9

		local var_305_0 = {
			zh = 5.366,
			ja = 5.9
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play412061075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1097ui_story = arg_305_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).z)
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles = arg_305_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_305_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1097ui_story"].transform.position).z)
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1097ui_story"].transform.localEulerAngles = arg_305_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1097ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1097ui_story == nil then
				arg_305_1.var_.characterEffect1097ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1097ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1097ui_story then
				arg_305_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_308_4 = 0
			local var_308_5 = 0.45

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(412061074)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)

				if (18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061074", "story_v_out_412061.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061074", "story_v_out_412061.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_412061", "412061074", "story_v_out_412061.awb")

						arg_305_1:RecordAudio("412061074", var_308_11)
						arg_305_1:RecordAudio("412061074", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_412061", "412061074", "story_v_out_412061.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_412061", "412061074", "story_v_out_412061.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play412061075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 412061075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play412061076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1097ui_story = arg_309_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).z)
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles = arg_309_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1097ui_story"].transform.position).z)
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1097ui_story"].transform.localEulerAngles = arg_309_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1097ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1097ui_story == nil then
				arg_309_1.var_.characterEffect1097ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1097ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_2)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1097ui_story then
				arg_309_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_312_3 = 0
			local var_312_4 = 0.875

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(412061075).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 35 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 35)

				if (35 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 35)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play412061076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 412061076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play412061077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 1.775

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(412061076).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 71 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 71)

				if (71 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 71)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play412061077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 412061077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play412061078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.875

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(412061077).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 35 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 35)

				if (35 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 35)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play412061078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 412061078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play412061079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.7

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(412061078).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 28 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 28)

				if (28 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 28)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play412061079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 412061079
		arg_325_1.duration_ = 3.73

		local var_325_0 = {
			zh = 3.733,
			ja = 2.9
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play412061080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10076ui_story = arg_325_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).z)
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles = arg_325_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_325_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10076ui_story"].transform.position).z)
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10076ui_story"].transform.localEulerAngles = arg_325_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action4_1")
			end

			local var_328_1 = arg_325_1.actors_["10076ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10076ui_story == nil then
				arg_325_1.var_.characterEffect10076ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect10076ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10076ui_story then
				arg_325_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_328_4 = 0
			local var_328_5 = 0.4

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(412061079)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 16 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 16)

				if (16 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 16)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061079", "story_v_out_412061.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061079", "story_v_out_412061.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_412061", "412061079", "story_v_out_412061.awb")

						arg_325_1:RecordAudio("412061079", var_328_11)
						arg_325_1:RecordAudio("412061079", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_412061", "412061079", "story_v_out_412061.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_412061", "412061079", "story_v_out_412061.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play412061080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 412061080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play412061081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10076ui_story = arg_329_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).z)
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles = arg_329_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10076ui_story"].transform.position).z)
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10076ui_story"].transform.localEulerAngles = arg_329_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_332_1 = 0
			local var_332_2 = 0.3

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(412061080).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 12 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 12)

				if (12 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 12)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play412061081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 412061081
		arg_333_1.duration_ = 4.83

		local var_333_0 = {
			zh = 3.4,
			ja = 4.833
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play412061082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1097ui_story = arg_333_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).z)
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles = arg_333_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_333_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1097ui_story"].transform.position).z)
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1097ui_story"].transform.localEulerAngles = arg_333_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1097ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1097ui_story == nil then
				arg_333_1.var_.characterEffect1097ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1097ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1097ui_story then
				arg_333_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.3

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(412061081)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 12 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 12)

				if (12 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 12)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061081", "story_v_out_412061.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061081", "story_v_out_412061.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_412061", "412061081", "story_v_out_412061.awb")

						arg_333_1:RecordAudio("412061081", var_336_11)
						arg_333_1:RecordAudio("412061081", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_412061", "412061081", "story_v_out_412061.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_412061", "412061081", "story_v_out_412061.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play412061082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 412061082
		arg_337_1.duration_ = 14.53

		local var_337_0 = {
			zh = 14.533,
			ja = 12.1
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play412061083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_340_0 = 0
			local var_340_1 = 1.25

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_2 = arg_337_1:GetWordFromCfg(412061082)
				local var_340_3 = arg_337_1:FormatText(var_340_2.content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 50 <= 0 and var_340_1 or var_340_1 * (utf8.len(var_340_3) / 50)

				if (50 <= 0 and var_340_1 or var_340_1 * (utf8.len(var_340_3) / 50)) > 0 and var_340_1 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061082", "story_v_out_412061.awb") ~= 0 then
					local var_340_6 = manager.audio:GetVoiceLength("story_v_out_412061", "412061082", "story_v_out_412061.awb") / 1000

					if var_340_6 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_0
					end

					if var_340_2.prefab_name ~= "" and arg_337_1.actors_[var_340_2.prefab_name] ~= nil then
						local var_340_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_2.prefab_name].transform, "story_v_out_412061", "412061082", "story_v_out_412061.awb")

						arg_337_1:RecordAudio("412061082", var_340_7)
						arg_337_1:RecordAudio("412061082", var_340_7)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_412061", "412061082", "story_v_out_412061.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_412061", "412061082", "story_v_out_412061.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play412061083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 412061083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play412061084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1097ui_story = arg_341_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).z)
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles = arg_341_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1097ui_story"].transform.position).z)
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1097ui_story"].transform.localEulerAngles = arg_341_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1097ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1097ui_story == nil then
				arg_341_1.var_.characterEffect1097ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1097ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_2)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1097ui_story then
				arg_341_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_344_3 = 0
			local var_344_4 = 0.9

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(412061083).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 36 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 36)

				if (36 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 36)) > 0 and var_344_4 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_8 and arg_341_1.time_ < var_344_3 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play412061084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 412061084
		arg_345_1.duration_ = 5.8

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play412061085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_0 = 1

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				local var_348_1 = Color.New(1, 1, 1)

				var_348_1.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.mask_.color = var_348_1
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				local var_348_2 = Color.New(1, 1, 1)

				arg_345_1.mask_.enabled = false
				var_348_2.a = 0
				arg_345_1.mask_.color = var_348_2
			end

			local var_348_3 = arg_345_1.bgs_.ST86.transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPosST86 = var_348_3.localPosition
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_3.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPosST86, Vector3.New(0, 1, 9), (arg_345_1.time_ - 0) / var_348_4)
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_3.localPosition = Vector3.New(0, 1, 9)
			end

			local var_348_5 = arg_345_1.bgs_.ST86.transform

			if 0.0166666666666667 < arg_345_1.time_ and arg_345_1.time_ <= 0.0166666666666667 + arg_348_0 then
				arg_345_1.var_.moveOldPosST86 = var_348_5.localPosition
			end

			local var_348_6 = 3.5

			if 0.0166666666666667 <= arg_345_1.time_ and arg_345_1.time_ < 0.0166666666666667 + var_348_6 then
				var_348_5.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPosST86, Vector3.New(0, 1, 10), (arg_345_1.time_ - 0.0166666666666667) / var_348_6)
			end

			if arg_345_1.time_ >= 0.0166666666666667 + var_348_6 and arg_345_1.time_ < 0.0166666666666667 + var_348_6 + arg_348_0 then
				var_348_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_348_7 = 1

			if 1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_7 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_7 + 2.51666666666667 and arg_345_1.time_ < var_348_7 + 2.51666666666667 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_8 = 0.8
			local var_348_9 = 1.425

			if 0.8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_10 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_10:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_11 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(412061084).content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 57 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 57)

				if (57 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 57)) > 0 and var_348_9 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13
					var_348_8 = var_348_8 + 0.3

					if var_348_13 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = var_348_8 + 0.3
			local var_348_15 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_15 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_14) / var_348_15

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_14 + var_348_15 and arg_345_1.time_ < var_348_14 + var_348_15 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST86",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST86",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play412061085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 412061085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play412061086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.125

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(412061085).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 45 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 45)

				if (45 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 45)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play412061086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 412061086
		arg_355_1.duration_ = 7.2

		local var_355_0 = {
			zh = 5.266,
			ja = 7.2
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play412061087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.35

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[923].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10086")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(412061086)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 14 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 14)

				if (14 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 14)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061086", "story_v_out_412061.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061086", "story_v_out_412061.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_412061", "412061086", "story_v_out_412061.awb")

						arg_355_1:RecordAudio("412061086", var_358_6)
						arg_355_1:RecordAudio("412061086", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_412061", "412061086", "story_v_out_412061.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_412061", "412061086", "story_v_out_412061.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play412061087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 412061087
		arg_359_1.duration_ = 4.03

		local var_359_0 = {
			zh = 3.966,
			ja = 4.033
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play412061088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.475

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[924].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10087")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(412061087)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 19 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 19)

				if (19 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 19)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061087", "story_v_out_412061.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061087", "story_v_out_412061.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_412061", "412061087", "story_v_out_412061.awb")

						arg_359_1:RecordAudio("412061087", var_362_6)
						arg_359_1:RecordAudio("412061087", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_412061", "412061087", "story_v_out_412061.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_412061", "412061087", "story_v_out_412061.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play412061088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 412061088
		arg_363_1.duration_ = 1.8

		local var_363_0 = {
			zh = 1.066,
			ja = 1.8
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play412061089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.075

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[923].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10086")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(412061088)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 3 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 3)

				if (3 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 3)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061088", "story_v_out_412061.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061088", "story_v_out_412061.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_412061", "412061088", "story_v_out_412061.awb")

						arg_363_1:RecordAudio("412061088", var_366_6)
						arg_363_1:RecordAudio("412061088", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_412061", "412061088", "story_v_out_412061.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_412061", "412061088", "story_v_out_412061.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play412061089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 412061089
		arg_367_1.duration_ = 2.63

		local var_367_0 = {
			zh = 2.466,
			ja = 2.633
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play412061090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1097ui_story = arg_367_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).z)
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles = arg_367_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_367_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1097ui_story"].transform.position).z)
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1097ui_story"].transform.localEulerAngles = arg_367_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1097ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1097ui_story == nil then
				arg_367_1.var_.characterEffect1097ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1097ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1097ui_story then
				arg_367_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_370_4 = 0
			local var_370_5 = 0.25

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(412061089)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 10 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 10)

				if (10 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 10)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061089", "story_v_out_412061.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061089", "story_v_out_412061.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_out_412061", "412061089", "story_v_out_412061.awb")

						arg_367_1:RecordAudio("412061089", var_370_11)
						arg_367_1:RecordAudio("412061089", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_412061", "412061089", "story_v_out_412061.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_412061", "412061089", "story_v_out_412061.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play412061090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 412061090
		arg_371_1.duration_ = 18.07

		local var_371_0 = {
			zh = 13.9,
			ja = 18.066
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play412061091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.475

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(412061090)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 59 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 59)

				if (59 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 59)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061090", "story_v_out_412061.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061090", "story_v_out_412061.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_412061", "412061090", "story_v_out_412061.awb")

						arg_371_1:RecordAudio("412061090", var_374_6)
						arg_371_1:RecordAudio("412061090", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_412061", "412061090", "story_v_out_412061.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_412061", "412061090", "story_v_out_412061.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play412061091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 412061091
		arg_375_1.duration_ = 9.53

		local var_375_0 = {
			zh = 9.2,
			ja = 9.533
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play412061092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_0 = 0
			local var_378_1 = 1.05

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(412061091)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 42 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 42)

				if (42 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 42)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061091", "story_v_out_412061.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_out_412061", "412061091", "story_v_out_412061.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_out_412061", "412061091", "story_v_out_412061.awb")

						arg_375_1:RecordAudio("412061091", var_378_7)
						arg_375_1:RecordAudio("412061091", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_412061", "412061091", "story_v_out_412061.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_412061", "412061091", "story_v_out_412061.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play412061092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 412061092
		arg_379_1.duration_ = 5.47

		local var_379_0 = {
			zh = 4.833,
			ja = 5.466
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play412061093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1097ui_story = arg_379_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).z)
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles = arg_379_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_379_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1097ui_story"].transform.position).z)
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1097ui_story"].transform.localEulerAngles = arg_379_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1097ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1097ui_story == nil then
				arg_379_1.var_.characterEffect1097ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1097ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_2)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1097ui_story then
				arg_379_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_382_3 = 0
			local var_382_4 = 0.6

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[924].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10087")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_5 = arg_379_1:GetWordFromCfg(412061092)
				local var_382_6 = arg_379_1:FormatText(var_382_5.content)

				arg_379_1.text_.text = var_382_6

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_8 = 24 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 24)

				if (24 <= 0 and var_382_4 or var_382_4 * (utf8.len(var_382_6) / 24)) > 0 and var_382_4 < var_382_8 then
					arg_379_1.talkMaxDuration = var_382_8

					if var_382_8 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_3
					end
				end

				arg_379_1.text_.text = var_382_6
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061092", "story_v_out_412061.awb") ~= 0 then
					local var_382_9 = manager.audio:GetVoiceLength("story_v_out_412061", "412061092", "story_v_out_412061.awb") / 1000

					if var_382_9 + var_382_3 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_3
					end

					if var_382_5.prefab_name ~= "" and arg_379_1.actors_[var_382_5.prefab_name] ~= nil then
						local var_382_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_5.prefab_name].transform, "story_v_out_412061", "412061092", "story_v_out_412061.awb")

						arg_379_1:RecordAudio("412061092", var_382_10)
						arg_379_1:RecordAudio("412061092", var_382_10)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_412061", "412061092", "story_v_out_412061.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_412061", "412061092", "story_v_out_412061.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_11 = math.max(var_382_4, arg_379_1.talkMaxDuration)

			if var_382_3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_3 + var_382_11 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_3) / var_382_11

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_3 + var_382_11 and arg_379_1.time_ < var_382_3 + var_382_11 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play412061093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 412061093
		arg_383_1.duration_ = 9.03

		local var_383_0 = {
			zh = 8.2,
			ja = 9.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play412061094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.075

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[923].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10086")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:GetWordFromCfg(412061093)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 43)

				if (43 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 43)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061093", "story_v_out_412061.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061093", "story_v_out_412061.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_412061", "412061093", "story_v_out_412061.awb")

						arg_383_1:RecordAudio("412061093", var_386_6)
						arg_383_1:RecordAudio("412061093", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_412061", "412061093", "story_v_out_412061.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_412061", "412061093", "story_v_out_412061.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play412061094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 412061094
		arg_387_1.duration_ = 8.17

		local var_387_0 = {
			zh = 6.9,
			ja = 8.166
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play412061095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[925].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10087")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:GetWordFromCfg(412061094)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 40 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 40)

				if (40 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 40)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061094", "story_v_out_412061.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061094", "story_v_out_412061.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_412061", "412061094", "story_v_out_412061.awb")

						arg_387_1:RecordAudio("412061094", var_390_6)
						arg_387_1:RecordAudio("412061094", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_412061", "412061094", "story_v_out_412061.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_412061", "412061094", "story_v_out_412061.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play412061095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 412061095
		arg_391_1.duration_ = 2.03

		local var_391_0 = {
			zh = 1.833,
			ja = 2.033
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play412061096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.15

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[924].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10087")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(412061095)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 6 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 6)

				if (6 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 6)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061095", "story_v_out_412061.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061095", "story_v_out_412061.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_412061", "412061095", "story_v_out_412061.awb")

						arg_391_1:RecordAudio("412061095", var_394_6)
						arg_391_1:RecordAudio("412061095", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_412061", "412061095", "story_v_out_412061.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_412061", "412061095", "story_v_out_412061.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play412061096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 412061096
		arg_395_1.duration_ = 6.83

		local var_395_0 = {
			zh = 5.3,
			ja = 6.833
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play412061097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.7

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[926].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10086")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:GetWordFromCfg(412061096)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 28 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 28)

				if (28 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 28)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061096", "story_v_out_412061.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_412061", "412061096", "story_v_out_412061.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_412061", "412061096", "story_v_out_412061.awb")

						arg_395_1:RecordAudio("412061096", var_398_6)
						arg_395_1:RecordAudio("412061096", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_412061", "412061096", "story_v_out_412061.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_412061", "412061096", "story_v_out_412061.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play412061097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 412061097
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play412061098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 1.15

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(412061097).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 46 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 46)

				if (46 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 46)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play412061098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 412061098
		arg_403_1.duration_ = 3.87

		local var_403_0 = {
			zh = 2.7,
			ja = 3.866
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play412061099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1097ui_story = arg_403_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).z)
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles = arg_403_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_403_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1097ui_story"].transform.position).z)
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1097ui_story"].transform.localEulerAngles = arg_403_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1097ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1097ui_story == nil then
				arg_403_1.var_.characterEffect1097ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1097ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1097ui_story then
				arg_403_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.275

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(412061098)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 11 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 11)

				if (11 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 11)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061098", "story_v_out_412061.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061098", "story_v_out_412061.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_out_412061", "412061098", "story_v_out_412061.awb")

						arg_403_1:RecordAudio("412061098", var_406_11)
						arg_403_1:RecordAudio("412061098", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_412061", "412061098", "story_v_out_412061.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_412061", "412061098", "story_v_out_412061.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play412061099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 412061099
		arg_407_1.duration_ = 4.4

		local var_407_0 = {
			zh = 1.999999999999,
			ja = 4.4
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play412061100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10077ui_story = arg_407_1.actors_["10077ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["10077ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).z)
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles = arg_407_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["10077ui_story"].transform.localPosition = Vector3.New(0, 0, -5)
				arg_407_1.actors_["10077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["10077ui_story"].transform.position).z)
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["10077ui_story"].transform.localEulerAngles = arg_407_1.actors_["10077ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["10077ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect10077ui_story == nil then
				arg_407_1.var_.characterEffect10077ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect10077ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect10077ui_story then
				arg_407_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action6_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_4 = arg_407_1.actors_["1097ui_story"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1097ui_story = var_410_4.localPosition
			end

			local var_410_5 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_5 then
				var_410_4.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_407_1.time_ - 0) / var_410_5)
				var_410_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_4.position).x, (manager.ui.mainCamera.transform.position - var_410_4.position).y, (manager.ui.mainCamera.transform.position - var_410_4.position).z)
				var_410_4.localEulerAngles.z = 0
				var_410_4.localEulerAngles.x = 0
				var_410_4.localEulerAngles = var_410_4.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_5 and arg_407_1.time_ < 0 + var_410_5 + arg_410_0 then
				var_410_4.localPosition = Vector3.New(0, 100, 0)
				var_410_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_4.position).x, (manager.ui.mainCamera.transform.position - var_410_4.position).y, (manager.ui.mainCamera.transform.position - var_410_4.position).z)
				var_410_4.localEulerAngles.z = 0
				var_410_4.localEulerAngles.x = 0
				var_410_4.localEulerAngles = var_410_4.localEulerAngles
			end

			local var_410_6 = arg_407_1.actors_["1097ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect1097ui_story == nil then
				arg_407_1.var_.characterEffect1097ui_story = var_410_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_7 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 and not isNil(var_410_6) then
				if arg_407_1.var_.characterEffect1097ui_story and not isNil(var_410_6) then
					arg_407_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_7)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 and not isNil(var_410_6) and arg_407_1.var_.characterEffect1097ui_story then
				arg_407_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_410_8 = 0
			local var_410_9 = 0.1

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(412061099)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 4 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 4)

				if (4 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 4)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061099", "story_v_out_412061.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061099", "story_v_out_412061.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_out_412061", "412061099", "story_v_out_412061.awb")

						arg_407_1:RecordAudio("412061099", var_410_15)
						arg_407_1:RecordAudio("412061099", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_412061", "412061099", "story_v_out_412061.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_412061", "412061099", "story_v_out_412061.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_9, arg_407_1.talkMaxDuration)

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_8) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_8 + var_410_16 and arg_407_1.time_ < var_410_8 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play412061100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 412061100
		arg_411_1.duration_ = 3.43

		local var_411_0 = {
			zh = 2.966,
			ja = 3.433
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play412061101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1097ui_story = arg_411_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).z)
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles = arg_411_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_411_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1097ui_story"].transform.position).z)
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1097ui_story"].transform.localEulerAngles = arg_411_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1097ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1097ui_story == nil then
				arg_411_1.var_.characterEffect1097ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1097ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1097ui_story then
				arg_411_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_4 = arg_411_1.actors_["10077ui_story"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10077ui_story = var_414_4.localPosition
			end

			local var_414_5 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_5 then
				var_414_4.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_5)
				var_414_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_4.position).x, (manager.ui.mainCamera.transform.position - var_414_4.position).y, (manager.ui.mainCamera.transform.position - var_414_4.position).z)
				var_414_4.localEulerAngles.z = 0
				var_414_4.localEulerAngles.x = 0
				var_414_4.localEulerAngles = var_414_4.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_5 and arg_411_1.time_ < 0 + var_414_5 + arg_414_0 then
				var_414_4.localPosition = Vector3.New(0, 100, 0)
				var_414_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_4.position).x, (manager.ui.mainCamera.transform.position - var_414_4.position).y, (manager.ui.mainCamera.transform.position - var_414_4.position).z)
				var_414_4.localEulerAngles.z = 0
				var_414_4.localEulerAngles.x = 0
				var_414_4.localEulerAngles = var_414_4.localEulerAngles
			end

			local var_414_6 = arg_411_1.actors_["10077ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_6) and arg_411_1.var_.characterEffect10077ui_story == nil then
				arg_411_1.var_.characterEffect10077ui_story = var_414_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_7 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 and not isNil(var_414_6) then
				if arg_411_1.var_.characterEffect10077ui_story and not isNil(var_414_6) then
					arg_411_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_411_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_7)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 and not isNil(var_414_6) and arg_411_1.var_.characterEffect10077ui_story then
				arg_411_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_411_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_414_8 = 0
			local var_414_9 = 0.275

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(412061100)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 11 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 11)

				if (11 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 11)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061100", "story_v_out_412061.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_412061", "412061100", "story_v_out_412061.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_412061", "412061100", "story_v_out_412061.awb")

						arg_411_1:RecordAudio("412061100", var_414_15)
						arg_411_1:RecordAudio("412061100", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_412061", "412061100", "story_v_out_412061.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_412061", "412061100", "story_v_out_412061.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play412061101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 412061101
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play412061102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1097ui_story = arg_415_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).z)
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles = arg_415_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1097ui_story"].transform.position).z)
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1097ui_story"].transform.localEulerAngles = arg_415_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1097ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1097ui_story == nil then
				arg_415_1.var_.characterEffect1097ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1097ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_2)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1097ui_story then
				arg_415_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_418_3 = 0
			local var_418_4 = 1.45

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_5 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(412061101).content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 58 <= 0 and var_418_4 or var_418_4 * (utf8.len(var_418_5) / 58)

				if (58 <= 0 and var_418_4 or var_418_4 * (utf8.len(var_418_5) / 58)) > 0 and var_418_4 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_3 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_3
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_4, arg_415_1.talkMaxDuration)

			if var_418_3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_3 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_3) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_3 + var_418_8 and arg_415_1.time_ < var_418_3 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play412061102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 412061102
		arg_419_1.duration_ = 8.7

		local var_419_0 = {
			zh = 4.166,
			ja = 8.7
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
			arg_419_1.auto_ = false
		end

		function arg_419_1.playNext_(arg_421_0)
			arg_419_1.onStoryFinished_()
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1097ui_story = arg_419_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).z)
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles = arg_419_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_419_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1097ui_story"].transform.position).z)
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1097ui_story"].transform.localEulerAngles = arg_419_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1097ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1097ui_story == nil then
				arg_419_1.var_.characterEffect1097ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1097ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1097ui_story then
				arg_419_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_422_4 = 0
			local var_422_5 = 0.55

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(412061102)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 22 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 22)

				if (22 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 22)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412061", "412061102", "story_v_out_412061.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_out_412061", "412061102", "story_v_out_412061.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_out_412061", "412061102", "story_v_out_412061.awb")

						arg_419_1:RecordAudio("412061102", var_422_11)
						arg_419_1:RecordAudio("412061102", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_412061", "412061102", "story_v_out_412061.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_412061", "412061102", "story_v_out_412061.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST86",
		"TextureConfig/Background/EN0111"
	},
	voices = {
		"story_v_out_412061.awb"
	}
}
