return {
	Play317171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.733333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.55

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317171001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 22 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 22)

				if (22 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 22)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317171002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317171002
		arg_9_1.duration_ = 5.1

		local var_9_0 = {
			zh = 5.1,
			ja = 2.766
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317171003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["3007_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3007_tpose"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_9_1.stage_.transform)

				var_12_0.name = "3007_tpose"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["3007_tpose"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["3007_tpose" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["3007_tpose" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["3007_tpose" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["3007_tpose"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos3007_tpose = var_12_3.localPosition

				local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_4 then
					var_12_4:EnableDynamicBone(false)
				end
			end

			local var_12_5 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_9_1.time_ - 0) / var_12_5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles

				local var_12_6 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_6 then
					var_12_6:EnableDynamicBone(true)
				end
			end

			local var_12_7 = arg_9_1.actors_["3007_tpose"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect3007_tpose == nil then
				arg_9_1.var_.characterEffect3007_tpose = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect3007_tpose and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect3007_tpose then
				arg_9_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_12_10 = 0
			local var_12_11 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[560].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(317171002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)

				if (7 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 7)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171002", "story_v_out_317171.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_317171", "317171002", "story_v_out_317171.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_317171", "317171002", "story_v_out_317171.awb")

						arg_9_1:RecordAudio("317171002", var_12_17)
						arg_9_1:RecordAudio("317171002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317171", "317171002", "story_v_out_317171.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317171", "317171002", "story_v_out_317171.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play317171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317171003
		arg_13_1.duration_ = 4.33

		local var_13_0 = {
			zh = 3.033,
			ja = 4.333
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
				arg_13_0:Play317171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos3007_tpose = arg_13_1.actors_["3007_tpose"].transform.localPosition

				local var_16_0 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_0 then
					var_16_0:EnableDynamicBone(false)
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_1)
				arg_13_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).z)
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles = arg_13_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["3007_tpose"].transform.position).z)
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["3007_tpose"].transform.localEulerAngles = arg_13_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_16_2 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(true)
				end
			end

			local var_16_3 = "1199ui_story"

			if arg_13_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_16_4 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_13_1.stage_.transform)

				var_16_4.name = var_16_3
				var_16_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_3] = var_16_4

				local var_16_5 = var_16_4:GetComponentInChildren(typeof(CharacterEffect))

				var_16_5.enabled = true

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_4, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_5.transform, false)

				arg_13_1.var_[var_16_3 .. "Animator"] = var_16_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_3 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_3 .. "LipSync"] = var_16_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_7 = arg_13_1.actors_["1199ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1199ui_story = var_16_7.localPosition
			end

			local var_16_8 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 then
				var_16_7.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_13_1.time_ - 0) / var_16_8)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 then
				var_16_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_16_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_7.position).x, (manager.ui.mainCamera.transform.position - var_16_7.position).y, (manager.ui.mainCamera.transform.position - var_16_7.position).z)
				var_16_7.localEulerAngles.z = 0
				var_16_7.localEulerAngles.x = 0
				var_16_7.localEulerAngles = var_16_7.localEulerAngles
			end

			local var_16_9 = arg_13_1.actors_["1199ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1199ui_story == nil then
				arg_13_1.var_.characterEffect1199ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_10 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 and not isNil(var_16_9) then
				if arg_13_1.var_.characterEffect1199ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1199ui_story then
				arg_13_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_16_12 = 0
			local var_16_13 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(317171003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 11 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 11)

				if (11 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 11)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171003", "story_v_out_317171.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_317171", "317171003", "story_v_out_317171.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_317171", "317171003", "story_v_out_317171.awb")

						arg_13_1:RecordAudio("317171003", var_16_19)
						arg_13_1:RecordAudio("317171003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317171", "317171003", "story_v_out_317171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317171", "317171003", "story_v_out_317171.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317171004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_9000

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1199ui_story = arg_17_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_hit", "")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_2 = arg_17_1.var_.effectF03daoguang1

				if not arg_17_1.var_.effectF03daoguang1 then
					var_20_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_20_2.name = "daoguang1"
					arg_17_1.var_.effectF03daoguang1 = var_20_2
				else
					var_20_2.transform:SetParent(var_20_9000)
				end

				var_20_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_20_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.866666666666668 < arg_17_1.time_ and arg_17_1.time_ <= 0.866666666666668 + arg_20_0 then
				if arg_17_1.var_.effectF03daoguang1 then
					Object.Destroy(arg_17_1.var_.effectF03daoguang1)

					arg_17_1.var_.effectF03daoguang1 = nil
				end
			end

			local var_20_5 = 0
			local var_20_6 = 1.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(317171004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 50 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 50)

				if (50 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 50)) > 0 and var_20_6 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_10 and arg_17_1.time_ < var_20_5 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317171005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_127", "se_story_127_dart", "")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				if arg_21_1.var_.effectlingli then
					Object.Destroy(arg_21_1.var_.effectlingli)

					arg_21_1.var_.effectlingli = nil
				end
			end

			local var_24_2 = 0
			local var_24_3 = 1.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(317171005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 45 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 45)

				if (45 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 45)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play317171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317171006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1199ui_story"]) and arg_25_1.var_.characterEffect1199ui_story == nil then
				arg_25_1.var_.characterEffect1199ui_story = arg_25_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1199ui_story"]) then
				if arg_25_1.var_.characterEffect1199ui_story and not isNil(arg_25_1.actors_["1199ui_story"]) then
					arg_25_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1199ui_story"]) and arg_25_1.var_.characterEffect1199ui_story then
				arg_25_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_28_2 = arg_25_1.actors_["1199ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1199ui_story = var_28_2.localPosition
			end

			local var_28_3 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_25_1.time_ - 0) / var_28_3)
				var_28_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_2.position).x, (manager.ui.mainCamera.transform.position - var_28_2.position).y, (manager.ui.mainCamera.transform.position - var_28_2.position).z)
				var_28_2.localEulerAngles.z = 0
				var_28_2.localEulerAngles.x = 0
				var_28_2.localEulerAngles = var_28_2.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_28_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_2.position).x, (manager.ui.mainCamera.transform.position - var_28_2.position).y, (manager.ui.mainCamera.transform.position - var_28_2.position).z)
				var_28_2.localEulerAngles.z = 0
				var_28_2.localEulerAngles.x = 0
				var_28_2.localEulerAngles = var_28_2.localEulerAngles
			end

			local var_28_4 = 0
			local var_28_5 = 0.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(317171006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)

				if (3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171006", "story_v_out_317171.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_317171", "317171006", "story_v_out_317171.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_317171", "317171006", "story_v_out_317171.awb")

						arg_25_1:RecordAudio("317171006", var_28_11)
						arg_25_1:RecordAudio("317171006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317171", "317171006", "story_v_out_317171.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317171", "317171006", "story_v_out_317171.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317171007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1199ui_story = arg_29_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).z)
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles = arg_29_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).z)
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles = arg_29_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1199ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1199ui_story == nil then
				arg_29_1.var_.characterEffect1199ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1199ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1199ui_story then
				arg_29_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_127", "se_story_127_bomb", "")
			end

			local var_32_4 = 0
			local var_32_5 = 0.75

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(317171007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 30 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 30)

				if (30 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 30)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317171008
		arg_33_1.duration_ = 2.47

		local var_33_0 = {
			zh = 1.433,
			ja = 2.466
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["2033_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2033_tpose"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "2033_tpose"), arg_33_1.stage_.transform)

				var_36_0.name = "2033_tpose"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["2033_tpose"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["2033_tpose" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["2033_tpose" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["2033_tpose" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["2033_tpose"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos2033_tpose = var_36_3.localPosition

				local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_4 then
					var_36_4:EnableDynamicBone(false)
				end
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2033_tpose, Vector3.New(0, -1.37, -4.9), (arg_33_1.time_ - 0) / var_36_5)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -1.37, -4.9)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles

				local var_36_6 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_6 then
					var_36_6:EnableDynamicBone(true)
				end
			end

			local var_36_7 = arg_33_1.actors_["2033_tpose"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect2033_tpose == nil then
				arg_33_1.var_.characterEffect2033_tpose = var_36_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_8 and not isNil(var_36_7) then
				if arg_33_1.var_.characterEffect2033_tpose and not isNil(var_36_7) then
					arg_33_1.var_.characterEffect2033_tpose.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_8 and arg_33_1.time_ < 0 + var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect2033_tpose then
				arg_33_1.var_.characterEffect2033_tpose.fillFlat = false
			end

			local var_36_10 = 0
			local var_36_11 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[79].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(317171008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 4 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 4)

				if (4 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 4)) > 0 and var_36_11 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171008", "story_v_out_317171.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_317171", "317171008", "story_v_out_317171.awb") / 1000

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end

					if var_36_12.prefab_name ~= "" and arg_33_1.actors_[var_36_12.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_12.prefab_name].transform, "story_v_out_317171", "317171008", "story_v_out_317171.awb")

						arg_33_1:RecordAudio("317171008", var_36_17)
						arg_33_1:RecordAudio("317171008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317171", "317171008", "story_v_out_317171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317171", "317171008", "story_v_out_317171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_18 and arg_33_1.time_ < var_36_10 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2033_tpose",
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
	Play317171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317171009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play317171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos2033_tpose = arg_37_1.actors_["2033_tpose"].transform.localPosition

				local var_40_0 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["2033_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_0 then
					var_40_0:EnableDynamicBone(false)
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["2033_tpose"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos2033_tpose, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_1)
				arg_37_1.actors_["2033_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).z)
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles = arg_37_1.actors_["2033_tpose"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["2033_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["2033_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["2033_tpose"].transform.position).z)
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["2033_tpose"].transform.localEulerAngles = arg_37_1.actors_["2033_tpose"].transform.localEulerAngles

				local var_40_2 = GameObjectTools.GetOrAddComponent(arg_37_1.actors_["2033_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(true)
				end
			end

			local var_40_3 = 0
			local var_40_4 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(317171009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 33 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 33)

				if (33 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 33)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2033_tpose",
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
	Play317171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317171010
		arg_41_1.duration_ = 6.6

		local var_41_0 = {
			zh = 3.6,
			ja = 6.6
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1199ui_story"]) and arg_41_1.var_.characterEffect1199ui_story == nil then
				arg_41_1.var_.characterEffect1199ui_story = arg_41_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1199ui_story"]) then
				if arg_41_1.var_.characterEffect1199ui_story and not isNil(arg_41_1.actors_["1199ui_story"]) then
					arg_41_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1199ui_story"]) and arg_41_1.var_.characterEffect1199ui_story then
				arg_41_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_44_2 = arg_41_1.actors_["1199ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1199ui_story = var_44_2.localPosition
			end

			local var_44_3 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_41_1.time_ - 0) / var_44_3)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			local var_44_4 = 0
			local var_44_5 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(317171010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 18 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 18)

				if (18 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 18)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171010", "story_v_out_317171.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_317171", "317171010", "story_v_out_317171.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_317171", "317171010", "story_v_out_317171.awb")

						arg_41_1:RecordAudio("317171010", var_44_11)
						arg_41_1:RecordAudio("317171010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317171", "317171010", "story_v_out_317171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317171", "317171010", "story_v_out_317171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317171011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_9000

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1199ui_story = arg_45_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).z)
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles = arg_45_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1199ui_story"].transform.position).z)
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1199ui_story"].transform.localEulerAngles = arg_45_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh_draw", "")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_2 = arg_45_1.var_.effectF03daoguang1

				if not arg_45_1.var_.effectF03daoguang1 then
					var_48_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_48_2.name = "daoguang1"
					arg_45_1.var_.effectF03daoguang1 = var_48_2
				else
					var_48_2.transform:SetParent(var_48_9000)
				end

				var_48_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_48_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.866666666666668 < arg_45_1.time_ and arg_45_1.time_ <= 0.866666666666668 + arg_48_0 then
				if arg_45_1.var_.effectF03daoguang1 then
					Object.Destroy(arg_45_1.var_.effectF03daoguang1)

					arg_45_1.var_.effectF03daoguang1 = nil
				end
			end

			local var_48_5 = 0
			local var_48_6 = 1.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(317171011).content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 45 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 45)

				if (45 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 45)) > 0 and var_48_6 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_10 and arg_45_1.time_ < var_48_5 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317171012
		arg_49_1.duration_ = 3.03

		local var_49_0 = {
			zh = 3.033,
			ja = 2.866
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
				arg_49_0:Play317171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["3017_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3017_tpose"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "3017_tpose"), arg_49_1.stage_.transform)

				var_52_0.name = "3017_tpose"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["3017_tpose"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["3017_tpose" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["3017_tpose" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["3017_tpose" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["3017_tpose"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos3017_tpose = var_52_3.localPosition

				local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_3.gameObject, typeof(DynamicBoneHelper))

				if var_52_4 then
					var_52_4:EnableDynamicBone(false)
				end
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos3017_tpose, Vector3.New(0, -1.73, -4.1), (arg_49_1.time_ - 0) / var_52_5)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, -1.73, -4.1)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles

				local var_52_6 = GameObjectTools.GetOrAddComponent(var_52_3.gameObject, typeof(DynamicBoneHelper))

				if var_52_6 then
					var_52_6:EnableDynamicBone(true)
				end
			end

			local var_52_7 = arg_49_1.actors_["3017_tpose"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.characterEffect3017_tpose == nil then
				arg_49_1.var_.characterEffect3017_tpose = var_52_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_8 and not isNil(var_52_7) then
				if arg_49_1.var_.characterEffect3017_tpose and not isNil(var_52_7) then
					arg_49_1.var_.characterEffect3017_tpose.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_8 and arg_49_1.time_ < 0 + var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.characterEffect3017_tpose then
				arg_49_1.var_.characterEffect3017_tpose.fillFlat = false
			end

			local var_52_10 = 0
			local var_52_11 = 0.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[561].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_12 = arg_49_1:GetWordFromCfg(317171012)
				local var_52_13 = arg_49_1:FormatText(var_52_12.content)

				arg_49_1.text_.text = var_52_13

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 8 <= 0 and var_52_11 or var_52_11 * (utf8.len(var_52_13) / 8)

				if (8 <= 0 and var_52_11 or var_52_11 * (utf8.len(var_52_13) / 8)) > 0 and var_52_11 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_13
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171012", "story_v_out_317171.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_317171", "317171012", "story_v_out_317171.awb") / 1000

					if var_52_16 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_10
					end

					if var_52_12.prefab_name ~= "" and arg_49_1.actors_[var_52_12.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_12.prefab_name].transform, "story_v_out_317171", "317171012", "story_v_out_317171.awb")

						arg_49_1:RecordAudio("317171012", var_52_17)
						arg_49_1:RecordAudio("317171012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317171", "317171012", "story_v_out_317171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317171", "317171012", "story_v_out_317171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_18 and arg_49_1.time_ < var_52_10 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3017_tpose",
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
	Play317171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317171013
		arg_53_1.duration_ = 8.53

		local var_53_0 = {
			zh = 6.933,
			ja = 8.533
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
				arg_53_0:Play317171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[561].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(317171013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 30 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 30)

				if (30 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 30)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171013", "story_v_out_317171.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_317171", "317171013", "story_v_out_317171.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_317171", "317171013", "story_v_out_317171.awb")

						arg_53_1:RecordAudio("317171013", var_56_6)
						arg_53_1:RecordAudio("317171013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317171", "317171013", "story_v_out_317171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317171", "317171013", "story_v_out_317171.awb")
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
	Play317171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317171014
		arg_57_1.duration_ = 4.47

		local var_57_0 = {
			zh = 2.8,
			ja = 4.466
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
				arg_57_0:Play317171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos3017_tpose = arg_57_1.actors_["3017_tpose"].transform.localPosition

				local var_60_0 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["3017_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_0 then
					var_60_0:EnableDynamicBone(false)
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["3017_tpose"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos3017_tpose, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_1)
				arg_57_1.actors_["3017_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).z)
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles = arg_57_1.actors_["3017_tpose"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["3017_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["3017_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["3017_tpose"].transform.position).z)
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["3017_tpose"].transform.localEulerAngles = arg_57_1.actors_["3017_tpose"].transform.localEulerAngles

				local var_60_2 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["3017_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(true)
				end
			end

			local var_60_3 = arg_57_1.actors_["1199ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1199ui_story == nil then
				arg_57_1.var_.characterEffect1199ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1199ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1199ui_story then
				arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_60_6 = arg_57_1.actors_["1199ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1199ui_story = var_60_6.localPosition
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_6.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_57_1.time_ - 0) / var_60_7)
				var_60_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_6.position).x, (manager.ui.mainCamera.transform.position - var_60_6.position).y, (manager.ui.mainCamera.transform.position - var_60_6.position).z)
				var_60_6.localEulerAngles.z = 0
				var_60_6.localEulerAngles.x = 0
				var_60_6.localEulerAngles = var_60_6.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_6.localPosition = Vector3.New(0, -1.08, -5.9)
				var_60_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_6.position).x, (manager.ui.mainCamera.transform.position - var_60_6.position).y, (manager.ui.mainCamera.transform.position - var_60_6.position).z)
				var_60_6.localEulerAngles.z = 0
				var_60_6.localEulerAngles.x = 0
				var_60_6.localEulerAngles = var_60_6.localEulerAngles
			end

			local var_60_8 = 0
			local var_60_9 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(317171014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 9 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 9)

				if (9 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 9)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171014", "story_v_out_317171.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_317171", "317171014", "story_v_out_317171.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_317171", "317171014", "story_v_out_317171.awb")

						arg_57_1:RecordAudio("317171014", var_60_15)
						arg_57_1:RecordAudio("317171014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317171", "317171014", "story_v_out_317171.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317171", "317171014", "story_v_out_317171.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3017_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317171015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_9000

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1199ui_story = arg_61_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).z)
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles = arg_61_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1199ui_story"].transform.position).z)
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1199ui_story"].transform.localEulerAngles = arg_61_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_1 = arg_61_1.var_.effectF03daoguang1

				if not arg_61_1.var_.effectF03daoguang1 then
					var_64_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_64_1.name = "daoguang1"
					arg_61_1.var_.effectF03daoguang1 = var_64_1
				else
					var_64_1.transform:SetParent(var_64_9000)
				end

				var_64_1.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_64_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.866666666666668 < arg_61_1.time_ and arg_61_1.time_ <= 0.866666666666668 + arg_64_0 then
				if arg_61_1.var_.effectF03daoguang1 then
					Object.Destroy(arg_61_1.var_.effectF03daoguang1)

					arg_61_1.var_.effectF03daoguang1 = nil
				end
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_whoosh", "")
			end

			if 0.0333333333333333 < arg_61_1.time_ and arg_61_1.time_ <= 0.0333333333333333 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hit", "")
			end

			local var_64_6 = 0
			local var_64_7 = 1.625

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(317171015).content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 65 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 65)

				if (65 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 65)) > 0 and var_64_7 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_11 and arg_61_1.time_ < var_64_6 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317171016
		arg_65_1.duration_ = 2.53

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_65_0:Play317171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) and arg_65_1.var_.characterEffect1199ui_story == nil then
				arg_65_1.var_.characterEffect1199ui_story = arg_65_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) then
				if arg_65_1.var_.characterEffect1199ui_story and not isNil(arg_65_1.actors_["1199ui_story"]) then
					arg_65_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1199ui_story"]) and arg_65_1.var_.characterEffect1199ui_story then
				arg_65_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_68_2 = arg_65_1.actors_["1199ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1199ui_story = var_68_2.localPosition
			end

			local var_68_3 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_65_1.time_ - 0) / var_68_3)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			local var_68_4 = 0
			local var_68_5 = 0.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(317171016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 6 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 6)

				if (6 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 6)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171016", "story_v_out_317171.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_317171", "317171016", "story_v_out_317171.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_317171", "317171016", "story_v_out_317171.awb")

						arg_65_1:RecordAudio("317171016", var_68_11)
						arg_65_1:RecordAudio("317171016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317171", "317171016", "story_v_out_317171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317171", "317171016", "story_v_out_317171.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317171017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1199ui_story = arg_69_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).z)
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles = arg_69_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1199ui_story"].transform.position).z)
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1199ui_story"].transform.localEulerAngles = arg_69_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_72_1 = 0
			local var_72_2 = 1.8

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(317171017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 72 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 72)

				if (72 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 72)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play317171018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317171018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317171019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.325

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(317171018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 53 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 53)

				if (53 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 53)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play317171019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317171019
		arg_77_1.duration_ = 9.2

		local var_77_0 = {
			zh = 9.2,
			ja = 5.4
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
				arg_77_0:Play317171020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_80_0 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_77_1.stage_.transform)

				var_80_0.name = "3004_tpose"
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["3004_tpose"] = var_80_0

				local var_80_1 = var_80_0:GetComponentInChildren(typeof(CharacterEffect))

				var_80_1.enabled = true

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_1.transform, false)

				arg_77_1.var_["3004_tpose" .. "Animator"] = var_80_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_["3004_tpose" .. "Animator"].applyRootMotion = true
				arg_77_1.var_["3004_tpose" .. "LipSync"] = var_80_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_3 = arg_77_1.actors_["3004_tpose"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos3004_tpose = var_80_3.localPosition

				local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_3.gameObject, typeof(DynamicBoneHelper))

				if var_80_4 then
					var_80_4:EnableDynamicBone(false)
				end
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_77_1.time_ - 0) / var_80_5)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(0, -2.22, -3.1)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles

				local var_80_6 = GameObjectTools.GetOrAddComponent(var_80_3.gameObject, typeof(DynamicBoneHelper))

				if var_80_6 then
					var_80_6:EnableDynamicBone(true)
				end
			end

			local var_80_7 = arg_77_1.actors_["3004_tpose"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.characterEffect3004_tpose == nil then
				arg_77_1.var_.characterEffect3004_tpose = var_80_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_8 and not isNil(var_80_7) then
				if arg_77_1.var_.characterEffect3004_tpose and not isNil(var_80_7) then
					arg_77_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_8 and arg_77_1.time_ < 0 + var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.characterEffect3004_tpose then
				arg_77_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_80_10 = 0
			local var_80_11 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(317171019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 21 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 21)

				if (21 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 21)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171019", "story_v_out_317171.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_317171", "317171019", "story_v_out_317171.awb") / 1000

					if var_80_16 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_10
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_317171", "317171019", "story_v_out_317171.awb")

						arg_77_1:RecordAudio("317171019", var_80_17)
						arg_77_1:RecordAudio("317171019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317171", "317171019", "story_v_out_317171.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317171", "317171019", "story_v_out_317171.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_18 and arg_77_1.time_ < var_80_10 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play317171020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317171020
		arg_81_1.duration_ = 7.37

		local var_81_0 = {
			zh = 3.5,
			ja = 7.366
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
				arg_81_0:Play317171021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos3004_tpose = arg_81_1.actors_["3004_tpose"].transform.localPosition

				local var_84_0 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_0 then
					var_84_0:EnableDynamicBone(false)
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_1)
				arg_81_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).z)
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles = arg_81_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["3004_tpose"].transform.position).z)
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["3004_tpose"].transform.localEulerAngles = arg_81_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_84_2 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(true)
				end
			end

			local var_84_3 = arg_81_1.actors_["1199ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1199ui_story == nil then
				arg_81_1.var_.characterEffect1199ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect1199ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1199ui_story then
				arg_81_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_84_6 = arg_81_1.actors_["1199ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1199ui_story = var_84_6.localPosition
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0, -1.08, -5.9)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			local var_84_8 = 0
			local var_84_9 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(317171020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 15 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 15)

				if (15 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 15)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171020", "story_v_out_317171.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_317171", "317171020", "story_v_out_317171.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_317171", "317171020", "story_v_out_317171.awb")

						arg_81_1:RecordAudio("317171020", var_84_15)
						arg_81_1:RecordAudio("317171020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317171", "317171020", "story_v_out_317171.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317171", "317171020", "story_v_out_317171.awb")
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317171021
		arg_85_1.duration_ = 10.8

		local var_85_0 = {
			zh = 10.8,
			ja = 7.6
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
				arg_85_0:Play317171022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1199ui_story = arg_85_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).z)
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles = arg_85_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).z)
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles = arg_85_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["3004_tpose"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos3004_tpose = var_88_1.localPosition

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_1.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end
			end

			local var_88_3 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_85_1.time_ - 0) / var_88_3)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0, -2.22, -3.1)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles

				local var_88_4 = GameObjectTools.GetOrAddComponent(var_88_1.gameObject, typeof(DynamicBoneHelper))

				if var_88_4 then
					var_88_4:EnableDynamicBone(true)
				end
			end

			local var_88_5 = arg_85_1.actors_["3004_tpose"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect3004_tpose == nil then
				arg_85_1.var_.characterEffect3004_tpose = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect3004_tpose and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect3004_tpose then
				arg_85_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_88_8 = 0
			local var_88_9 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(317171021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 16 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 16)

				if (16 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 16)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171021", "story_v_out_317171.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_317171", "317171021", "story_v_out_317171.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_317171", "317171021", "story_v_out_317171.awb")

						arg_85_1:RecordAudio("317171021", var_88_15)
						arg_85_1:RecordAudio("317171021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317171", "317171021", "story_v_out_317171.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317171", "317171021", "story_v_out_317171.awb")
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
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play317171022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317171022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317171023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos3004_tpose = arg_89_1.actors_["3004_tpose"].transform.localPosition

				local var_92_0 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_0 then
					var_92_0:EnableDynamicBone(false)
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_1)
				arg_89_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).z)
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles = arg_89_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["3004_tpose"].transform.position).z)
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["3004_tpose"].transform.localEulerAngles = arg_89_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_92_2 = GameObjectTools.GetOrAddComponent(arg_89_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(true)
				end
			end

			local var_92_3 = 0
			local var_92_4 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(317171022).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 19)

				if (19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 19)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play317171023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317171023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317171024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(317171023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 69 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 69)

				if (69 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 69)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317171024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317171024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317171025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.55

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(317171024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 62 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 62)

				if (62 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 62)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317171025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317171025
		arg_101_1.duration_ = 5.57

		local var_101_0 = {
			zh = 5.233,
			ja = 5.566
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317171026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_104_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_101_1.stage_.transform)

				var_104_0.name = "4014_tpose"
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["4014_tpose"] = var_104_0

				local var_104_1 = var_104_0:GetComponentInChildren(typeof(CharacterEffect))

				var_104_1.enabled = true

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end

				arg_101_1:ShowWeapon(var_104_1.transform, false)

				arg_101_1.var_["4014_tpose" .. "Animator"] = var_104_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_101_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_101_1.var_["4014_tpose" .. "LipSync"] = var_104_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_104_3 = arg_101_1.actors_["4014_tpose"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos4014_tpose = var_104_3.localPosition

				local var_104_4 = GameObjectTools.GetOrAddComponent(var_104_3.gameObject, typeof(DynamicBoneHelper))

				if var_104_4 then
					var_104_4:EnableDynamicBone(false)
				end
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_101_1.time_ - 0) / var_104_5)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles

				local var_104_6 = GameObjectTools.GetOrAddComponent(var_104_3.gameObject, typeof(DynamicBoneHelper))

				if var_104_6 then
					var_104_6:EnableDynamicBone(true)
				end
			end

			local var_104_7 = arg_101_1.actors_["4014_tpose"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.characterEffect4014_tpose == nil then
				arg_101_1.var_.characterEffect4014_tpose = var_104_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_8 and not isNil(var_104_7) then
				if arg_101_1.var_.characterEffect4014_tpose and not isNil(var_104_7) then
					arg_101_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_8 and arg_101_1.time_ < 0 + var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.characterEffect4014_tpose then
				arg_101_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_104_10 = 0
			local var_104_11 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_12 = arg_101_1:GetWordFromCfg(317171025)
				local var_104_13 = arg_101_1:FormatText(var_104_12.content)

				arg_101_1.text_.text = var_104_13

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 16 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 16)

				if (16 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 16)) > 0 and var_104_11 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_13
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171025", "story_v_out_317171.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_317171", "317171025", "story_v_out_317171.awb") / 1000

					if var_104_16 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_10
					end

					if var_104_12.prefab_name ~= "" and arg_101_1.actors_[var_104_12.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_12.prefab_name].transform, "story_v_out_317171", "317171025", "story_v_out_317171.awb")

						arg_101_1:RecordAudio("317171025", var_104_17)
						arg_101_1:RecordAudio("317171025", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317171", "317171025", "story_v_out_317171.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317171", "317171025", "story_v_out_317171.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_10) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_10 + var_104_18 and arg_101_1.time_ < var_104_10 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
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
	Play317171026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317171026
		arg_105_1.duration_ = 3.17

		local var_105_0 = {
			zh = 3.166,
			ja = 1.999999999999
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
				arg_105_0:Play317171027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) and arg_105_1.var_.characterEffect1199ui_story == nil then
				arg_105_1.var_.characterEffect1199ui_story = arg_105_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) then
				if arg_105_1.var_.characterEffect1199ui_story and not isNil(arg_105_1.actors_["1199ui_story"]) then
					arg_105_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1199ui_story"]) and arg_105_1.var_.characterEffect1199ui_story then
				arg_105_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_108_2 = arg_105_1.actors_["4014_tpose"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos4014_tpose = var_108_2.localPosition

				local var_108_3 = GameObjectTools.GetOrAddComponent(var_108_2.gameObject, typeof(DynamicBoneHelper))

				if var_108_3 then
					var_108_3:EnableDynamicBone(false)
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_4)
				var_108_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_2.position).x, (manager.ui.mainCamera.transform.position - var_108_2.position).y, (manager.ui.mainCamera.transform.position - var_108_2.position).z)
				var_108_2.localEulerAngles.z = 0
				var_108_2.localEulerAngles.x = 0
				var_108_2.localEulerAngles = var_108_2.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, 100, 0)
				var_108_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_2.position).x, (manager.ui.mainCamera.transform.position - var_108_2.position).y, (manager.ui.mainCamera.transform.position - var_108_2.position).z)
				var_108_2.localEulerAngles.z = 0
				var_108_2.localEulerAngles.x = 0
				var_108_2.localEulerAngles = var_108_2.localEulerAngles

				local var_108_5 = GameObjectTools.GetOrAddComponent(var_108_2.gameObject, typeof(DynamicBoneHelper))

				if var_108_5 then
					var_108_5:EnableDynamicBone(true)
				end
			end

			local var_108_6 = arg_105_1.actors_["1199ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1199ui_story = var_108_6.localPosition
			end

			local var_108_7 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				var_108_6.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_105_1.time_ - 0) / var_108_7)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				var_108_6.localPosition = Vector3.New(0, -1.08, -5.9)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			local var_108_8 = 0
			local var_108_9 = 0.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(317171026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 11 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 11)

				if (11 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 11)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171026", "story_v_out_317171.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_317171", "317171026", "story_v_out_317171.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_317171", "317171026", "story_v_out_317171.awb")

						arg_105_1:RecordAudio("317171026", var_108_15)
						arg_105_1:RecordAudio("317171026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317171", "317171026", "story_v_out_317171.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317171", "317171026", "story_v_out_317171.awb")
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
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play317171027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317171027
		arg_109_1.duration_ = 5.9

		local var_109_0 = {
			zh = 5.9,
			ja = 5.433
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
				arg_109_0:Play317171028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.85

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(317171027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 34 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 34)

				if (34 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 34)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171027", "story_v_out_317171.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_317171", "317171027", "story_v_out_317171.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_317171", "317171027", "story_v_out_317171.awb")

						arg_109_1:RecordAudio("317171027", var_112_6)
						arg_109_1:RecordAudio("317171027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317171", "317171027", "story_v_out_317171.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317171", "317171027", "story_v_out_317171.awb")
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
	Play317171028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317171028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317171029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1199ui_story"]) and arg_113_1.var_.characterEffect1199ui_story == nil then
				arg_113_1.var_.characterEffect1199ui_story = arg_113_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1199ui_story"]) then
				if arg_113_1.var_.characterEffect1199ui_story and not isNil(arg_113_1.actors_["1199ui_story"]) then
					arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1199ui_story"]) and arg_113_1.var_.characterEffect1199ui_story then
				arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(317171028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 14 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 14)

				if (14 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 14)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play317171029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317171029
		arg_117_1.duration_ = 10

		local var_117_0 = {
			zh = 7.233,
			ja = 10
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
				arg_117_0:Play317171030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos4014_tpose = arg_117_1.actors_["4014_tpose"].transform.localPosition

				local var_120_0 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_0 then
					var_120_0:EnableDynamicBone(false)
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_117_1.time_ - 0) / var_120_1)
				arg_117_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).z)
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles = arg_117_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, -1.95, -4.2)
				arg_117_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["4014_tpose"].transform.position).z)
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["4014_tpose"].transform.localEulerAngles = arg_117_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_120_2 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(true)
				end
			end

			local var_120_3 = arg_117_1.actors_["4014_tpose"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect4014_tpose == nil then
				arg_117_1.var_.characterEffect4014_tpose = var_120_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_3) then
				if arg_117_1.var_.characterEffect4014_tpose and not isNil(var_120_3) then
					arg_117_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect4014_tpose then
				arg_117_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_120_6 = arg_117_1.actors_["1199ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1199ui_story = var_120_6.localPosition
			end

			local var_120_7 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				var_120_6.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_7)
				var_120_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_6.position).x, (manager.ui.mainCamera.transform.position - var_120_6.position).y, (manager.ui.mainCamera.transform.position - var_120_6.position).z)
				var_120_6.localEulerAngles.z = 0
				var_120_6.localEulerAngles.x = 0
				var_120_6.localEulerAngles = var_120_6.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				var_120_6.localPosition = Vector3.New(0, 100, 0)
				var_120_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_6.position).x, (manager.ui.mainCamera.transform.position - var_120_6.position).y, (manager.ui.mainCamera.transform.position - var_120_6.position).z)
				var_120_6.localEulerAngles.z = 0
				var_120_6.localEulerAngles.x = 0
				var_120_6.localEulerAngles = var_120_6.localEulerAngles
			end

			local var_120_8 = 0
			local var_120_9 = 0.7

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(317171029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 28 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 28)

				if (28 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 28)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171029", "story_v_out_317171.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_317171", "317171029", "story_v_out_317171.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_317171", "317171029", "story_v_out_317171.awb")

						arg_117_1:RecordAudio("317171029", var_120_15)
						arg_117_1:RecordAudio("317171029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317171", "317171029", "story_v_out_317171.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317171", "317171029", "story_v_out_317171.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play317171030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317171030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317171031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1199ui_story = arg_121_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1199ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.0166666666666667

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story then
				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_124_3 = arg_121_1.actors_["4014_tpose"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos4014_tpose = var_124_3.localPosition

				local var_124_4 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_4 then
					var_124_4:EnableDynamicBone(false)
				end
			end

			local var_124_5 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_5)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles

				local var_124_6 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_6 then
					var_124_6:EnableDynamicBone(true)
				end
			end

			local var_124_7 = 0
			local var_124_8 = 0.35

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

				local var_124_9 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(317171030).content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 14 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 14)

				if (14 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 14)) > 0 and var_124_8 < var_124_11 then
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
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
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
	Play317171031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317171031
		arg_125_1.duration_ = 6

		local var_125_0 = {
			zh = 6,
			ja = 4.866
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
			arg_125_1.auto_ = false
		end

		function arg_125_1.playNext_(arg_127_0)
			arg_125_1.onStoryFinished_()
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) and arg_125_1.var_.characterEffect1199ui_story == nil then
				arg_125_1.var_.characterEffect1199ui_story = arg_125_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) then
				if arg_125_1.var_.characterEffect1199ui_story and not isNil(arg_125_1.actors_["1199ui_story"]) then
					arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1199ui_story"]) and arg_125_1.var_.characterEffect1199ui_story then
				arg_125_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action435")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.5

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(317171031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 20 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 20)

				if (20 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 20)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317171", "317171031", "story_v_out_317171.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_317171", "317171031", "story_v_out_317171.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_317171", "317171031", "story_v_out_317171.awb")

						arg_125_1:RecordAudio("317171031", var_128_9)
						arg_125_1:RecordAudio("317171031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_317171", "317171031", "story_v_out_317171.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_317171", "317171031", "story_v_out_317171.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f"
	},
	voices = {
		"story_v_out_317171.awb"
	}
}
