return {
	Play317251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317251001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K11f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_4_0.name = "K11f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K11f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K11f

				arg_1_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K11f" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

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
			local var_4_15 = 0.825

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317251001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
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
	Play317251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317251002
		arg_9_1.duration_ = 5.83

		local var_9_0 = {
			zh = 5.833,
			ja = 5.1
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
				arg_9_0:Play317251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "2079ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["2079ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["2079ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["2079ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["2079ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos2079ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["2079ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect2079ui_story == nil then
				arg_9_1.var_.characterEffect2079ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect2079ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect2079ui_story then
				arg_9_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_12_8 = 0
			local var_12_9 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(317251002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 26 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 26)

				if (26 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 26)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251002", "story_v_out_317251.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_317251", "317251002", "story_v_out_317251.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_317251", "317251002", "story_v_out_317251.awb")

						arg_9_1:RecordAudio("317251002", var_12_15)
						arg_9_1:RecordAudio("317251002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317251", "317251002", "story_v_out_317251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317251", "317251002", "story_v_out_317251.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317251003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 3.433,
			ja = 3.133
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
				arg_13_0:Play317251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "2078ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["2078ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["2078ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["2078ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["2078ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos2078ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["2078ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect2078ui_story == nil then
				arg_13_1.var_.characterEffect2078ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect2078ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect2078ui_story then
				arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = arg_13_1.actors_["2079ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos2079ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, 100, 0)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = 0
			local var_16_11 = 0.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(317251003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 15 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 15)

				if (15 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 15)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251003", "story_v_out_317251.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_317251", "317251003", "story_v_out_317251.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_317251", "317251003", "story_v_out_317251.awb")

						arg_13_1:RecordAudio("317251003", var_16_17)
						arg_13_1:RecordAudio("317251003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317251", "317251003", "story_v_out_317251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317251", "317251003", "story_v_out_317251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317251004
		arg_17_1.duration_ = 5.2

		local var_17_0 = {
			zh = 5.2,
			ja = 4.833
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos2079ui_story = arg_17_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).z)
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles = arg_17_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_17_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).z)
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles = arg_17_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["2079ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2079ui_story == nil then
				arg_17_1.var_.characterEffect2079ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect2079ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2079ui_story then
				arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_20_4 = arg_17_1.actors_["2078ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos2078ui_story = var_20_4.localPosition
			end

			local var_20_5 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 then
				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_5)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, 100, 0)
				var_20_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_4.position).x, (manager.ui.mainCamera.transform.position - var_20_4.position).y, (manager.ui.mainCamera.transform.position - var_20_4.position).z)
				var_20_4.localEulerAngles.z = 0
				var_20_4.localEulerAngles.x = 0
				var_20_4.localEulerAngles = var_20_4.localEulerAngles
			end

			local var_20_6 = 0
			local var_20_7 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(317251004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 19 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 19)

				if (19 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_9) / 19)) > 0 and var_20_7 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251004", "story_v_out_317251.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_317251", "317251004", "story_v_out_317251.awb") / 1000

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end

					if var_20_8.prefab_name ~= "" and arg_17_1.actors_[var_20_8.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_8.prefab_name].transform, "story_v_out_317251", "317251004", "story_v_out_317251.awb")

						arg_17_1:RecordAudio("317251004", var_20_13)
						arg_17_1:RecordAudio("317251004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317251", "317251004", "story_v_out_317251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317251", "317251004", "story_v_out_317251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play317251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317251005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos2079ui_story = arg_21_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).z)
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles = arg_21_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).z)
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles = arg_21_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_24_1 = 0
			local var_24_2 = 0.75

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(317251005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 30 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 30)

				if (30 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 30)) > 0 and var_24_2 < var_24_5 then
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317251006
		arg_25_1.duration_ = 3.07

		local var_25_0 = {
			zh = 2.733,
			ja = 3.066
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos2078ui_story = arg_25_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).z)
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles = arg_25_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).z)
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles = arg_25_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["2078ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2078ui_story == nil then
				arg_25_1.var_.characterEffect2078ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect2078ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_25_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2078ui_story then
				arg_25_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_25_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_28_3 = arg_25_1.actors_["2079ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos2079ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["2079ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect2079ui_story == nil then
				arg_25_1.var_.characterEffect2079ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect2079ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect2079ui_story then
				arg_25_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(317251006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 12 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 12)

				if (12 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 12)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251006", "story_v_out_317251.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_317251", "317251006", "story_v_out_317251.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_317251", "317251006", "story_v_out_317251.awb")

						arg_25_1:RecordAudio("317251006", var_28_15)
						arg_25_1:RecordAudio("317251006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317251", "317251006", "story_v_out_317251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317251", "317251006", "story_v_out_317251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317251007
		arg_29_1.duration_ = 7.57

		local var_29_0 = {
			zh = 5.466,
			ja = 7.566
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
				arg_29_0:Play317251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(317251007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)

				if (29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 29)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251007", "story_v_out_317251.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251007", "story_v_out_317251.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_317251", "317251007", "story_v_out_317251.awb")

						arg_29_1:RecordAudio("317251007", var_32_6)
						arg_29_1:RecordAudio("317251007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317251", "317251007", "story_v_out_317251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317251", "317251007", "story_v_out_317251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317251008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos2079ui_story = arg_33_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).z)
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles = arg_33_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2079ui_story"].transform.position).z)
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["2079ui_story"].transform.localEulerAngles = arg_33_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_36_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_3 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_3

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_3
						arg_33_1.bgmTxt2_.text = var_36_3
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_4 = 0
			local var_36_5 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(317251008).content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 31 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 31)

				if (31 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 31)) > 0 and var_36_5 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_9 and arg_33_1.time_ < var_36_4 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317251009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 317251009
		arg_38_1.duration_ = 9

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play317251010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.bgs_.K12f == nil then
				local var_41_0 = Object.Instantiate(arg_38_1.paintGo_)

				var_41_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K12f")
				var_41_0.name = "K12f"
				var_41_0.transform.parent = arg_38_1.stage_.transform
				var_41_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.bgs_.K12f = var_41_0
			end

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= 2 + arg_41_0 then
				local var_41_1 = arg_38_1.bgs_.K12f

				arg_38_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_41_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_2 = var_41_1:GetComponent("SpriteRenderer")

				if var_41_2 and var_41_2.sprite then
					local var_41_3 = 2 * (var_41_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_41_1.transform.localScale = Vector3.New(var_41_3 / var_41_2.sprite.bounds.size.y < var_41_3 * manager.ui.mainCameraCom_.aspect / var_41_2.sprite.bounds.size.x and var_41_3 * manager.ui.mainCameraCom_.aspect / var_41_2.sprite.bounds.size.x or var_41_3 / var_41_2.sprite.bounds.size.y, var_41_3 / var_41_2.sprite.bounds.size.y < var_41_3 * manager.ui.mainCameraCom_.aspect / var_41_2.sprite.bounds.size.x and var_41_3 * manager.ui.mainCameraCom_.aspect / var_41_2.sprite.bounds.size.x or var_41_3 / var_41_2.sprite.bounds.size.y, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "K12f" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_4 = 0

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_5 = 2

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_5 then
				local var_41_6 = Color.New(0, 0, 0)

				var_41_6.a = Mathf.Lerp(0, 1, (arg_38_1.time_ - var_41_4) / var_41_5)
				arg_38_1.mask_.color = var_41_6
			end

			if arg_38_1.time_ >= var_41_4 + var_41_5 and arg_38_1.time_ < var_41_4 + var_41_5 + arg_41_0 then
				local var_41_7 = Color.New(0, 0, 0)

				var_41_7.a = 1
				arg_38_1.mask_.color = var_41_7
			end

			local var_41_8 = 2

			if 2 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_9 = 2

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_9 then
				local var_41_10 = Color.New(0, 0, 0)

				var_41_10.a = Mathf.Lerp(1, 0, (arg_38_1.time_ - var_41_8) / var_41_9)
				arg_38_1.mask_.color = var_41_10
			end

			if arg_38_1.time_ >= var_41_8 + var_41_9 and arg_38_1.time_ < var_41_8 + var_41_9 + arg_41_0 then
				local var_41_11 = Color.New(0, 0, 0)

				arg_38_1.mask_.enabled = false
				var_41_11.a = 0
				arg_38_1.mask_.color = var_41_11
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_41_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_38_1.bgmTxt_.text ~= var_41_14 and arg_38_1.bgmTxt_.text ~= "" then
						if arg_38_1.bgmTxt2_.text ~= "" then
							arg_38_1.bgmTxt_.text = arg_38_1.bgmTxt2_.text
						end

						arg_38_1.bgmTxt2_.text = var_41_14

						arg_38_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_38_1.bgmTxt_.text = var_41_14
						arg_38_1.bgmTxt2_.text = var_41_14
					end

					if arg_38_1.bgmTimer then
						arg_38_1.bgmTimer:Stop()

						arg_38_1.bgmTimer = nil
					end

					if arg_38_1.settingData.show_music_name == 1 then
						arg_38_1.musicController:SetSelectedState("show")
						arg_38_1.musicAnimator_:Play("open", 0, 0)

						if arg_38_1.settingData.music_time ~= 0 then
							arg_38_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_38_1.settingData.music_time), function()
								if arg_38_1 == nil or isNil(arg_38_1.bgmTxt_) then
									return
								end

								arg_38_1.musicController:SetSelectedState("hide")
								arg_38_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.55 < arg_38_1.time_ and arg_38_1.time_ <= 3.55 + arg_41_0 then
				arg_38_1:AudioAction("play", "music", "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang.awb")

				local var_41_17 = manager.audio:GetAudioName("bgm_activity_2_6_story_biwuchang", "bgm_activity_2_6_story_biwuchang")

				if "" ~= "" then
					if arg_38_1.bgmTxt_.text ~= var_41_17 and arg_38_1.bgmTxt_.text ~= "" then
						if arg_38_1.bgmTxt2_.text ~= "" then
							arg_38_1.bgmTxt_.text = arg_38_1.bgmTxt2_.text
						end

						arg_38_1.bgmTxt2_.text = var_41_17

						arg_38_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_38_1.bgmTxt_.text = var_41_17
						arg_38_1.bgmTxt2_.text = var_41_17
					end

					if arg_38_1.bgmTimer then
						arg_38_1.bgmTimer:Stop()

						arg_38_1.bgmTimer = nil
					end

					if arg_38_1.settingData.show_music_name == 1 then
						arg_38_1.musicController:SetSelectedState("show")
						arg_38_1.musicAnimator_:Play("open", 0, 0)

						if arg_38_1.settingData.music_time ~= 0 then
							arg_38_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_38_1.settingData.music_time), function()
								if arg_38_1 == nil or isNil(arg_38_1.bgmTxt_) then
									return
								end

								arg_38_1.musicController:SetSelectedState("hide")
								arg_38_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_18 = 4
			local var_41_19 = 0.55

			if 4 < arg_38_1.time_ and arg_38_1.time_ <= var_41_18 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_20 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_20:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_38_1.dialogCg_.alpha = arg_44_0
				end))
				var_41_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_21 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(317251009).content)

				arg_38_1.text_.text = var_41_21

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_23 = 22 <= 0 and var_41_19 or var_41_19 * (utf8.len(var_41_21) / 22)

				if (22 <= 0 and var_41_19 or var_41_19 * (utf8.len(var_41_21) / 22)) > 0 and var_41_19 < var_41_23 then
					arg_38_1.talkMaxDuration = var_41_23
					var_41_18 = var_41_18 + 0.3

					if var_41_23 + var_41_18 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_18
					end
				end

				arg_38_1.text_.text = var_41_21
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_24 = var_41_18 + 0.3
			local var_41_25 = math.max(var_41_19, arg_38_1.talkMaxDuration)

			if var_41_18 + 0.3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_24 + var_41_25 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_24) / var_41_25

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_24 + var_41_25 and arg_38_1.time_ < var_41_24 + var_41_25 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play317251010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 317251010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play317251011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 1.325

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(317251010).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 53 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 53)

				if (53 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 53)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play317251011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 317251011
		arg_50_1.duration_ = 2

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play317251012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["1158ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1158ui_story"))) then
				local var_53_0 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_50_1.stage_.transform)

				var_53_0.name = "1158ui_story"
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["1158ui_story"] = var_53_0

				local var_53_1 = var_53_0:GetComponentInChildren(typeof(CharacterEffect))

				var_53_1.enabled = true

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end

				arg_50_1:ShowWeapon(var_53_1.transform, false)

				arg_50_1.var_["1158ui_story" .. "Animator"] = var_53_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_50_1.var_["1158ui_story" .. "Animator"].applyRootMotion = true
				arg_50_1.var_["1158ui_story" .. "LipSync"] = var_53_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_53_3 = arg_50_1.actors_["1158ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1158ui_story = var_53_3.localPosition
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_3.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_50_1.time_ - 0) / var_53_4)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_3.localPosition = Vector3.New(0, -0.95, -6)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles
			end

			local var_53_5 = arg_50_1.actors_["1158ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect1158ui_story == nil then
				arg_50_1.var_.characterEffect1158ui_story = var_53_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_6 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_6 and not isNil(var_53_5) then
				if arg_50_1.var_.characterEffect1158ui_story and not isNil(var_53_5) then
					arg_50_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_6 and arg_50_1.time_ < 0 + var_53_6 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect1158ui_story then
				arg_50_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_53_8 = 0
			local var_53_9 = 0.175

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_10 = arg_50_1:GetWordFromCfg(317251011)
				local var_53_11 = arg_50_1:FormatText(var_53_10.content)

				arg_50_1.text_.text = var_53_11

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_13 = 7 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 7)

				if (7 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 7)) > 0 and var_53_9 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_8
					end
				end

				arg_50_1.text_.text = var_53_11
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251011", "story_v_out_317251.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_317251", "317251011", "story_v_out_317251.awb") / 1000

					if var_53_14 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_8
					end

					if var_53_10.prefab_name ~= "" and arg_50_1.actors_[var_53_10.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_10.prefab_name].transform, "story_v_out_317251", "317251011", "story_v_out_317251.awb")

						arg_50_1:RecordAudio("317251011", var_53_15)
						arg_50_1:RecordAudio("317251011", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_317251", "317251011", "story_v_out_317251.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_317251", "317251011", "story_v_out_317251.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_9, arg_50_1.talkMaxDuration)

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_8) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_8 + var_53_16 and arg_50_1.time_ < var_53_8 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play317251012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 317251012
		arg_54_1.duration_ = 2.87

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play317251013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.bgs_.ST58 == nil then
				local var_57_0 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST58")
				var_57_0.name = "ST58"
				var_57_0.transform.parent = arg_54_1.stage_.transform
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_.ST58 = var_57_0
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				local var_57_1 = arg_54_1.bgs_.ST58

				arg_54_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_2 = var_57_1:GetComponent("SpriteRenderer")

				if var_57_2 and var_57_2.sprite then
					local var_57_3 = 2 * (var_57_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_1.transform.localScale = Vector3.New(var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "ST58" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_4 = arg_54_1.actors_["1158ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1158ui_story = var_57_4.localPosition
			end

			local var_57_5 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 then
				var_57_4.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_5)
				var_57_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_4.position).x, (manager.ui.mainCamera.transform.position - var_57_4.position).y, (manager.ui.mainCamera.transform.position - var_57_4.position).z)
				var_57_4.localEulerAngles.z = 0
				var_57_4.localEulerAngles.x = 0
				var_57_4.localEulerAngles = var_57_4.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 then
				var_57_4.localPosition = Vector3.New(0, 100, 0)
				var_57_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_4.position).x, (manager.ui.mainCamera.transform.position - var_57_4.position).y, (manager.ui.mainCamera.transform.position - var_57_4.position).z)
				var_57_4.localEulerAngles.z = 0
				var_57_4.localEulerAngles.x = 0
				var_57_4.localEulerAngles = var_57_4.localEulerAngles
			end

			local var_57_6 = arg_54_1.actors_["1158ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect1158ui_story == nil then
				arg_54_1.var_.characterEffect1158ui_story = var_57_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_7 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 and not isNil(var_57_6) then
				if arg_54_1.var_.characterEffect1158ui_story and not isNil(var_57_6) then
					arg_54_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_7)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect1158ui_story then
				arg_54_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_57_8 = "1049ui_story"

			if arg_54_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_57_9 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_54_1.stage_.transform)

				var_57_9.name = var_57_8
				var_57_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_[var_57_8] = var_57_9

				local var_57_10 = var_57_9:GetComponentInChildren(typeof(CharacterEffect))

				var_57_10.enabled = true

				local var_57_11 = GameObjectTools.GetOrAddComponent(var_57_9, typeof(DynamicBoneHelper))

				if var_57_11 then
					var_57_11:EnableDynamicBone(false)
				end

				arg_54_1:ShowWeapon(var_57_10.transform, false)

				arg_54_1.var_[var_57_8 .. "Animator"] = var_57_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_54_1.var_[var_57_8 .. "Animator"].applyRootMotion = true
				arg_54_1.var_[var_57_8 .. "LipSync"] = var_57_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_57_12 = arg_54_1.actors_["1049ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1049ui_story = var_57_12.localPosition
			end

			local var_57_13 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_13 then
				var_57_12.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_54_1.time_ - 0) / var_57_13)
				var_57_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_12.position).x, (manager.ui.mainCamera.transform.position - var_57_12.position).y, (manager.ui.mainCamera.transform.position - var_57_12.position).z)
				var_57_12.localEulerAngles.z = 0
				var_57_12.localEulerAngles.x = 0
				var_57_12.localEulerAngles = var_57_12.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_13 and arg_54_1.time_ < 0 + var_57_13 + arg_57_0 then
				var_57_12.localPosition = Vector3.New(0, -1.2, -6)
				var_57_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_12.position).x, (manager.ui.mainCamera.transform.position - var_57_12.position).y, (manager.ui.mainCamera.transform.position - var_57_12.position).z)
				var_57_12.localEulerAngles.z = 0
				var_57_12.localEulerAngles.x = 0
				var_57_12.localEulerAngles = var_57_12.localEulerAngles
			end

			local var_57_14 = arg_54_1.actors_["1049ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect1049ui_story == nil then
				arg_54_1.var_.characterEffect1049ui_story = var_57_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_15 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_15 and not isNil(var_57_14) then
				if arg_54_1.var_.characterEffect1049ui_story and not isNil(var_57_14) then
					arg_54_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_15 and arg_54_1.time_ < 0 + var_57_15 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect1049ui_story then
				arg_54_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_57_17 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_18 = 1

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_18 then
				local var_57_19 = Color.New(1, 1, 1)

				var_57_19.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_17) / var_57_18)
				arg_54_1.mask_.color = var_57_19
			end

			if arg_54_1.time_ >= var_57_17 + var_57_18 and arg_54_1.time_ < var_57_17 + var_57_18 + arg_57_0 then
				local var_57_20 = Color.New(1, 1, 1)

				arg_54_1.mask_.enabled = false
				var_57_20.a = 0
				arg_54_1.mask_.color = var_57_20
			end

			local var_57_21 = 0

			arg_54_1.isInRecall_ = false

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				arg_54_1.screenFilterGo_:SetActive(true)

				arg_54_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_57_2, iter_57_3 in pairs(arg_54_1.actors_) do
					for iter_57_4, iter_57_5 in ipairs((iter_57_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_57_5.color = iter_57_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_57_22 = 0.0166666666666667

			if var_57_21 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				arg_54_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_54_1.time_ - var_57_21) / var_57_22)
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				arg_54_1.screenFilterEffect_.weight = 1
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_23 = 1
			local var_57_24 = 0.175

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_23 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_25 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_25:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_26 = arg_54_1:GetWordFromCfg(317251012)
				local var_57_27 = arg_54_1:FormatText(var_57_26.content)

				arg_54_1.text_.text = var_57_27

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_29 = 7 <= 0 and var_57_24 or var_57_24 * (utf8.len(var_57_27) / 7)

				if (7 <= 0 and var_57_24 or var_57_24 * (utf8.len(var_57_27) / 7)) > 0 and var_57_24 < var_57_29 then
					arg_54_1.talkMaxDuration = var_57_29
					var_57_23 = var_57_23 + 0.3

					if var_57_29 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_29 + var_57_23
					end
				end

				arg_54_1.text_.text = var_57_27
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251012", "story_v_out_317251.awb") ~= 0 then
					local var_57_30 = manager.audio:GetVoiceLength("story_v_out_317251", "317251012", "story_v_out_317251.awb") / 1000

					if var_57_30 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_30 + var_57_23
					end

					if var_57_26.prefab_name ~= "" and arg_54_1.actors_[var_57_26.prefab_name] ~= nil then
						local var_57_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_26.prefab_name].transform, "story_v_out_317251", "317251012", "story_v_out_317251.awb")

						arg_54_1:RecordAudio("317251012", var_57_31)
						arg_54_1:RecordAudio("317251012", var_57_31)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_317251", "317251012", "story_v_out_317251.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_317251", "317251012", "story_v_out_317251.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_32 = var_57_23 + 0.3
			local var_57_33 = math.max(var_57_24, arg_54_1.talkMaxDuration)

			if var_57_23 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_32 + var_57_33 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_32) / var_57_33

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_32 + var_57_33 and arg_54_1.time_ < var_57_32 + var_57_33 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play317251013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 317251013
		arg_60_1.duration_ = 2.07

		local var_60_0 = {
			zh = 2.066,
			ja = 1.999999999999
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play317251014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1158ui_story = arg_60_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).z)
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles = arg_60_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_60_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1158ui_story"].transform.position).z)
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1158ui_story"].transform.localEulerAngles = arg_60_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1158ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1158ui_story == nil then
				arg_60_1.var_.characterEffect1158ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect1158ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1158ui_story then
				arg_60_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_4 = arg_60_1.actors_["1049ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1049ui_story = var_63_4.localPosition
			end

			local var_63_5 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_5 then
				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_5)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_5 and arg_60_1.time_ < 0 + var_63_5 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(0, 100, 0)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			local var_63_6 = arg_60_1.actors_["1049ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1049ui_story == nil then
				arg_60_1.var_.characterEffect1049ui_story = var_63_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_7 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 and not isNil(var_63_6) then
				if arg_60_1.var_.characterEffect1049ui_story and not isNil(var_63_6) then
					arg_60_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_7)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 and not isNil(var_63_6) and arg_60_1.var_.characterEffect1049ui_story then
				arg_60_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				local var_63_8 = arg_60_1.bgs_.K12f

				arg_60_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_9 = var_63_8:GetComponent("SpriteRenderer")

				if var_63_9 and var_63_9.sprite then
					local var_63_10 = 2 * (var_63_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_8.transform.localScale = Vector3.New(var_63_10 / var_63_9.sprite.bounds.size.y < var_63_10 * manager.ui.mainCameraCom_.aspect / var_63_9.sprite.bounds.size.x and var_63_10 * manager.ui.mainCameraCom_.aspect / var_63_9.sprite.bounds.size.x or var_63_10 / var_63_9.sprite.bounds.size.y, var_63_10 / var_63_9.sprite.bounds.size.y < var_63_10 * manager.ui.mainCameraCom_.aspect / var_63_9.sprite.bounds.size.x and var_63_10 * manager.ui.mainCameraCom_.aspect / var_63_9.sprite.bounds.size.x or var_63_10 / var_63_9.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "K12f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_11 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_12 = 1

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				local var_63_13 = Color.New(1, 1, 1)

				var_63_13.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_11) / var_63_12)
				arg_60_1.mask_.color = var_63_13
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				local var_63_14 = Color.New(1, 1, 1)

				arg_60_1.mask_.enabled = false
				var_63_14.a = 0
				arg_60_1.mask_.color = var_63_14
			end

			local var_63_15 = 0

			arg_60_1.isInRecall_ = false

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.screenFilterGo_:SetActive(false)

				for iter_63_2, iter_63_3 in pairs(arg_60_1.actors_) do
					for iter_63_4, iter_63_5 in ipairs((iter_63_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_63_5.color = iter_63_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_63_16 = 0.0166666666666667

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_16 then
				arg_60_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_15) / var_63_16)
			end

			if arg_60_1.time_ >= var_63_15 + var_63_16 and arg_60_1.time_ < var_63_15 + var_63_16 + arg_63_0 then
				arg_60_1.screenFilterEffect_.weight = 0
			end

			local var_63_17 = 0
			local var_63_18 = 0.175

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_19 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_19:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_20 = arg_60_1:GetWordFromCfg(317251013)
				local var_63_21 = arg_60_1:FormatText(var_63_20.content)

				arg_60_1.text_.text = var_63_21

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_23 = 7 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_21) / 7)

				if (7 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_21) / 7)) > 0 and var_63_18 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23
					var_63_17 = var_63_17 + 0.3

					if var_63_23 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_17
					end
				end

				arg_60_1.text_.text = var_63_21
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251013", "story_v_out_317251.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_out_317251", "317251013", "story_v_out_317251.awb") / 1000

					if var_63_24 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_17
					end

					if var_63_20.prefab_name ~= "" and arg_60_1.actors_[var_63_20.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_20.prefab_name].transform, "story_v_out_317251", "317251013", "story_v_out_317251.awb")

						arg_60_1:RecordAudio("317251013", var_63_25)
						arg_60_1:RecordAudio("317251013", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_317251", "317251013", "story_v_out_317251.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_317251", "317251013", "story_v_out_317251.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = var_63_17 + 0.3
			local var_63_27 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_26 + var_63_27 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_26) / var_63_27

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_26 + var_63_27 and arg_60_1.time_ < var_63_26 + var_63_27 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play317251014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 317251014
		arg_66_1.duration_ = 3.43

		local var_66_0 = {
			zh = 2.866,
			ja = 3.433
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play317251015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1158ui_story = arg_66_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).z)
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles = arg_66_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1158ui_story"].transform.position).z)
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1158ui_story"].transform.localEulerAngles = arg_66_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1158ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1158ui_story == nil then
				arg_66_1.var_.characterEffect1158ui_story = var_69_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 and not isNil(var_69_1) then
				if arg_66_1.var_.characterEffect1158ui_story and not isNil(var_69_1) then
					arg_66_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_2)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1158ui_story then
				arg_66_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_69_3 = arg_66_1.actors_["1049ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1049ui_story = var_69_3.localPosition
			end

			local var_69_4 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				var_69_3.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_66_1.time_ - 0) / var_69_4)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				var_69_3.localPosition = Vector3.New(0, -1.2, -6)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			local var_69_5 = arg_66_1.actors_["1049ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1049ui_story == nil then
				arg_66_1.var_.characterEffect1049ui_story = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 and not isNil(var_69_5) then
				if arg_66_1.var_.characterEffect1049ui_story and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1049ui_story then
				arg_66_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				local var_69_8 = arg_66_1.bgs_.ST58

				arg_66_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_9 = var_69_8:GetComponent("SpriteRenderer")

				if var_69_9 and var_69_9.sprite then
					local var_69_10 = 2 * (var_69_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_8.transform.localScale = Vector3.New(var_69_10 / var_69_9.sprite.bounds.size.y < var_69_10 * manager.ui.mainCameraCom_.aspect / var_69_9.sprite.bounds.size.x and var_69_10 * manager.ui.mainCameraCom_.aspect / var_69_9.sprite.bounds.size.x or var_69_10 / var_69_9.sprite.bounds.size.y, var_69_10 / var_69_9.sprite.bounds.size.y < var_69_10 * manager.ui.mainCameraCom_.aspect / var_69_9.sprite.bounds.size.x and var_69_10 * manager.ui.mainCameraCom_.aspect / var_69_9.sprite.bounds.size.x or var_69_10 / var_69_9.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST58" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_11 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_12 = 1

			if var_69_11 <= arg_66_1.time_ and arg_66_1.time_ < var_69_11 + var_69_12 then
				local var_69_13 = Color.New(1, 1, 1)

				var_69_13.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_11) / var_69_12)
				arg_66_1.mask_.color = var_69_13
			end

			if arg_66_1.time_ >= var_69_11 + var_69_12 and arg_66_1.time_ < var_69_11 + var_69_12 + arg_69_0 then
				local var_69_14 = Color.New(1, 1, 1)

				arg_66_1.mask_.enabled = false
				var_69_14.a = 0
				arg_66_1.mask_.color = var_69_14
			end

			local var_69_15 = 0

			arg_66_1.isInRecall_ = false

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.screenFilterGo_:SetActive(true)

				arg_66_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_69_2, iter_69_3 in pairs(arg_66_1.actors_) do
					for iter_69_4, iter_69_5 in ipairs((iter_69_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_69_5.color = iter_69_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_69_16 = 0.0166666666666667

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_16 then
				arg_66_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_15) / var_69_16)
			end

			if arg_66_1.time_ >= var_69_15 + var_69_16 and arg_66_1.time_ < var_69_15 + var_69_16 + arg_69_0 then
				arg_66_1.screenFilterEffect_.weight = 1
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_17 = 1
			local var_69_18 = 0.125

			if 1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_19 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_19:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(317251014)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_23 = 5 <= 0 and var_69_18 or var_69_18 * (utf8.len(var_69_21) / 5)

				if (5 <= 0 and var_69_18 or var_69_18 * (utf8.len(var_69_21) / 5)) > 0 and var_69_18 < var_69_23 then
					arg_66_1.talkMaxDuration = var_69_23
					var_69_17 = var_69_17 + 0.3

					if var_69_23 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_17
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251014", "story_v_out_317251.awb") ~= 0 then
					local var_69_24 = manager.audio:GetVoiceLength("story_v_out_317251", "317251014", "story_v_out_317251.awb") / 1000

					if var_69_24 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_17
					end

					if var_69_20.prefab_name ~= "" and arg_66_1.actors_[var_69_20.prefab_name] ~= nil then
						local var_69_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_20.prefab_name].transform, "story_v_out_317251", "317251014", "story_v_out_317251.awb")

						arg_66_1:RecordAudio("317251014", var_69_25)
						arg_66_1:RecordAudio("317251014", var_69_25)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_317251", "317251014", "story_v_out_317251.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_317251", "317251014", "story_v_out_317251.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_26 = var_69_17 + 0.3
			local var_69_27 = math.max(var_69_18, arg_66_1.talkMaxDuration)

			if var_69_17 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_26 + var_69_27 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_26) / var_69_27

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_26 + var_69_27 and arg_66_1.time_ < var_69_26 + var_69_27 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play317251015 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 317251015
		arg_72_1.duration_ = 3.28

		local var_72_0 = {
			zh = 3.28266666666667,
			ja = 2.74966666666667
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play317251016(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1158ui_story = arg_72_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).z)
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles = arg_72_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_72_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1158ui_story"].transform.position).z)
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1158ui_story"].transform.localEulerAngles = arg_72_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1158ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1158ui_story == nil then
				arg_72_1.var_.characterEffect1158ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect1158ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1158ui_story then
				arg_72_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_75_4 = arg_72_1.actors_["1049ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1049ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, 100, 0)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				local var_75_6 = arg_72_1.bgs_.K12f

				arg_72_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_7 = var_75_6:GetComponent("SpriteRenderer")

				if var_75_7 and var_75_7.sprite then
					local var_75_8 = 2 * (var_75_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_6.transform.localScale = Vector3.New(var_75_8 / var_75_7.sprite.bounds.size.y < var_75_8 * manager.ui.mainCameraCom_.aspect / var_75_7.sprite.bounds.size.x and var_75_8 * manager.ui.mainCameraCom_.aspect / var_75_7.sprite.bounds.size.x or var_75_8 / var_75_7.sprite.bounds.size.y, var_75_8 / var_75_7.sprite.bounds.size.y < var_75_8 * manager.ui.mainCameraCom_.aspect / var_75_7.sprite.bounds.size.x and var_75_8 * manager.ui.mainCameraCom_.aspect / var_75_7.sprite.bounds.size.x or var_75_8 / var_75_7.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "K12f" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_9 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_10 = 1

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_10 then
				local var_75_11 = Color.New(1, 1, 1)

				var_75_11.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_9) / var_75_10)
				arg_72_1.mask_.color = var_75_11
			end

			if arg_72_1.time_ >= var_75_9 + var_75_10 and arg_72_1.time_ < var_75_9 + var_75_10 + arg_75_0 then
				local var_75_12 = Color.New(1, 1, 1)

				arg_72_1.mask_.enabled = false
				var_75_12.a = 0
				arg_72_1.mask_.color = var_75_12
			end

			local var_75_13 = 0

			arg_72_1.isInRecall_ = false

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1.screenFilterGo_:SetActive(false)

				for iter_75_2, iter_75_3 in pairs(arg_72_1.actors_) do
					for iter_75_4, iter_75_5 in ipairs((iter_75_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_75_5.color = iter_75_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_75_14 = 0.0166666666666667

			if var_75_13 <= arg_72_1.time_ and arg_72_1.time_ < var_75_13 + var_75_14 then
				arg_72_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_13) / var_75_14)
			end

			if arg_72_1.time_ >= var_75_13 + var_75_14 and arg_72_1.time_ < var_75_13 + var_75_14 + arg_75_0 then
				arg_72_1.screenFilterEffect_.weight = 0
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_15 = 1.01666666666667
			local var_75_16 = 0.175

			if 1.01666666666667 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_17 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_17:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_18 = arg_72_1:GetWordFromCfg(317251015)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_21 = 7 <= 0 and var_75_16 or var_75_16 * (utf8.len(var_75_19) / 7)

				if (7 <= 0 and var_75_16 or var_75_16 * (utf8.len(var_75_19) / 7)) > 0 and var_75_16 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21
					var_75_15 = var_75_15 + 0.3

					if var_75_21 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251015", "story_v_out_317251.awb") ~= 0 then
					local var_75_22 = manager.audio:GetVoiceLength("story_v_out_317251", "317251015", "story_v_out_317251.awb") / 1000

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_317251", "317251015", "story_v_out_317251.awb")

						arg_72_1:RecordAudio("317251015", var_75_23)
						arg_72_1:RecordAudio("317251015", var_75_23)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_317251", "317251015", "story_v_out_317251.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_317251", "317251015", "story_v_out_317251.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_24 = var_75_15 + 0.3
			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_24 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_24) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_24 + var_75_25 and arg_72_1.time_ < var_75_24 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play317251016 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 317251016
		arg_78_1.duration_ = 3.37

		local var_78_0 = {
			zh = 1.999999999999,
			ja = 3.366
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play317251017(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1158ui_story = arg_78_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).z)
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles = arg_78_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1158ui_story"].transform.position).z)
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1158ui_story"].transform.localEulerAngles = arg_78_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["1049ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1049ui_story = var_81_1.localPosition
			end

			local var_81_2 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_78_1.time_ - 0) / var_81_2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, -1.2, -6)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			local var_81_3 = arg_78_1.actors_["1049ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1049ui_story == nil then
				arg_78_1.var_.characterEffect1049ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1049ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1049ui_story then
				arg_78_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_6 = arg_78_1.bgs_.ST58

				arg_78_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_7 = var_81_6:GetComponent("SpriteRenderer")

				if var_81_7 and var_81_7.sprite then
					local var_81_8 = 2 * (var_81_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_6.transform.localScale = Vector3.New(var_81_8 / var_81_7.sprite.bounds.size.y < var_81_8 * manager.ui.mainCameraCom_.aspect / var_81_7.sprite.bounds.size.x and var_81_8 * manager.ui.mainCameraCom_.aspect / var_81_7.sprite.bounds.size.x or var_81_8 / var_81_7.sprite.bounds.size.y, var_81_8 / var_81_7.sprite.bounds.size.y < var_81_8 * manager.ui.mainCameraCom_.aspect / var_81_7.sprite.bounds.size.x and var_81_8 * manager.ui.mainCameraCom_.aspect / var_81_7.sprite.bounds.size.x or var_81_8 / var_81_7.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "ST58" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_9 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_10 = 1

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_10 then
				local var_81_11 = Color.New(1, 1, 1)

				var_81_11.a = Mathf.Lerp(1, 0, (arg_78_1.time_ - var_81_9) / var_81_10)
				arg_78_1.mask_.color = var_81_11
			end

			if arg_78_1.time_ >= var_81_9 + var_81_10 and arg_78_1.time_ < var_81_9 + var_81_10 + arg_81_0 then
				local var_81_12 = Color.New(1, 1, 1)

				arg_78_1.mask_.enabled = false
				var_81_12.a = 0
				arg_78_1.mask_.color = var_81_12
			end

			local var_81_13 = 0

			arg_78_1.isInRecall_ = false

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				arg_78_1.screenFilterGo_:SetActive(true)

				arg_78_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_81_2, iter_81_3 in pairs(arg_78_1.actors_) do
					for iter_81_4, iter_81_5 in ipairs((iter_81_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_81_5.color = iter_81_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_81_14 = 0.0166666666666667

			if var_81_13 <= arg_78_1.time_ and arg_78_1.time_ < var_81_13 + var_81_14 then
				arg_78_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_78_1.time_ - var_81_13) / var_81_14)
			end

			if arg_78_1.time_ >= var_81_13 + var_81_14 and arg_78_1.time_ < var_81_13 + var_81_14 + arg_81_0 then
				arg_78_1.screenFilterEffect_.weight = 1
			end

			local var_81_15 = 0
			local var_81_16 = 0.1

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_17 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_17:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(317251016)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_21 = 4 <= 0 and var_81_16 or var_81_16 * (utf8.len(var_81_19) / 4)

				if (4 <= 0 and var_81_16 or var_81_16 * (utf8.len(var_81_19) / 4)) > 0 and var_81_16 < var_81_21 then
					arg_78_1.talkMaxDuration = var_81_21
					var_81_15 = var_81_15 + 0.3

					if var_81_21 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_21 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251016", "story_v_out_317251.awb") ~= 0 then
					local var_81_22 = manager.audio:GetVoiceLength("story_v_out_317251", "317251016", "story_v_out_317251.awb") / 1000

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_317251", "317251016", "story_v_out_317251.awb")

						arg_78_1:RecordAudio("317251016", var_81_23)
						arg_78_1:RecordAudio("317251016", var_81_23)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_317251", "317251016", "story_v_out_317251.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_317251", "317251016", "story_v_out_317251.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_24 = var_81_15 + 0.3
			local var_81_25 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_24 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_24) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_24 + var_81_25 and arg_78_1.time_ < var_81_24 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play317251017 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 317251017
		arg_84_1.duration_ = 9

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play317251018(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				arg_84_1.var_.moveOldPos1049ui_story = arg_84_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 2 <= arg_84_1.time_ and arg_84_1.time_ < 2 + var_87_0 then
				arg_84_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 2) / var_87_0)
				arg_84_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).z)
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles = arg_84_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 2 + var_87_0 and arg_84_1.time_ < 2 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1049ui_story"].transform.position).z)
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1049ui_story"].transform.localEulerAngles = arg_84_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if 2.00066666851441 < arg_84_1.time_ and arg_84_1.time_ <= 2.00066666851441 + arg_87_0 then
				local var_87_1 = arg_84_1.bgs_.K12f

				arg_84_1.bgs_.K12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_2 = var_87_1:GetComponent("SpriteRenderer")

				if var_87_2 and var_87_2.sprite then
					local var_87_3 = 2 * (var_87_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_1.transform.localScale = Vector3.New(var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "K12f" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_4 = 0

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_5 = 2

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_5 then
				local var_87_6 = Color.New(0, 0, 0)

				var_87_6.a = Mathf.Lerp(0, 1, (arg_84_1.time_ - var_87_4) / var_87_5)
				arg_84_1.mask_.color = var_87_6
			end

			if arg_84_1.time_ >= var_87_4 + var_87_5 and arg_84_1.time_ < var_87_4 + var_87_5 + arg_87_0 then
				local var_87_7 = Color.New(0, 0, 0)

				var_87_7.a = 1
				arg_84_1.mask_.color = var_87_7
			end

			local var_87_8 = 2

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_9 = 2

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_9 then
				local var_87_10 = Color.New(0, 0, 0)

				var_87_10.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_8) / var_87_9)
				arg_84_1.mask_.color = var_87_10
			end

			if arg_84_1.time_ >= var_87_8 + var_87_9 and arg_84_1.time_ < var_87_8 + var_87_9 + arg_87_0 then
				local var_87_11 = Color.New(0, 0, 0)

				arg_84_1.mask_.enabled = false
				var_87_11.a = 0
				arg_84_1.mask_.color = var_87_11
			end

			local var_87_12 = 2

			arg_84_1.isInRecall_ = false

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.screenFilterGo_:SetActive(false)

				for iter_87_2, iter_87_3 in pairs(arg_84_1.actors_) do
					for iter_87_4, iter_87_5 in ipairs((iter_87_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_87_5.color = iter_87_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_87_13 = 0.0166666666666667

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 then
				arg_84_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_12) / var_87_13)
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 then
				arg_84_1.screenFilterEffect_.weight = 0
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_14 = 4
			local var_87_15 = 0.75

			if 4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_16 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_16:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_17 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(317251017).content)

				arg_84_1.text_.text = var_87_17

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 30 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 30)

				if (30 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 30)) > 0 and var_87_15 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19
					var_87_14 = var_87_14 + 0.3

					if var_87_19 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_14
					end
				end

				arg_84_1.text_.text = var_87_17
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = var_87_14 + 0.3
			local var_87_21 = math.max(var_87_15, arg_84_1.talkMaxDuration)

			if var_87_14 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_21 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_21

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_21 and arg_84_1.time_ < var_87_20 + var_87_21 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play317251018 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 317251018
		arg_90_1.duration_ = 13.77

		local var_90_0 = {
			zh = 12.133,
			ja = 13.766
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play317251019(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(317251018)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 44 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 44)

				if (44 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 44)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251018", "story_v_out_317251.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251018", "story_v_out_317251.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_317251", "317251018", "story_v_out_317251.awb")

						arg_90_1:RecordAudio("317251018", var_93_6)
						arg_90_1:RecordAudio("317251018", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_317251", "317251018", "story_v_out_317251.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_317251", "317251018", "story_v_out_317251.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play317251019 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317251019
		arg_94_1.duration_ = 8.2

		local var_94_0 = {
			zh = 8.2,
			ja = 5.866
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317251020(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.775

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(317251019)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 31 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 31)

				if (31 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 31)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251019", "story_v_out_317251.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251019", "story_v_out_317251.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_317251", "317251019", "story_v_out_317251.awb")

						arg_94_1:RecordAudio("317251019", var_97_6)
						arg_94_1:RecordAudio("317251019", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_317251", "317251019", "story_v_out_317251.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_317251", "317251019", "story_v_out_317251.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play317251020 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 317251020
		arg_98_1.duration_ = 5.43

		local var_98_0 = {
			zh = 5.433,
			ja = 4.666
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play317251021(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.6

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(317251020)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 24 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 24)

				if (24 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 24)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251020", "story_v_out_317251.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251020", "story_v_out_317251.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_317251", "317251020", "story_v_out_317251.awb")

						arg_98_1:RecordAudio("317251020", var_101_6)
						arg_98_1:RecordAudio("317251020", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_317251", "317251020", "story_v_out_317251.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_317251", "317251020", "story_v_out_317251.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play317251021 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 317251021
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play317251022(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.875

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(317251021).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 35 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 35)

				if (35 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 35)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play317251022 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 317251022
		arg_106_1.duration_ = 1.33

		local var_106_0 = {
			zh = 1.3,
			ja = 1.333
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play317251023(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.1

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(317251022)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 4 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 4)

				if (4 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 4)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251022", "story_v_out_317251.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251022", "story_v_out_317251.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_317251", "317251022", "story_v_out_317251.awb")

						arg_106_1:RecordAudio("317251022", var_109_6)
						arg_106_1:RecordAudio("317251022", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_317251", "317251022", "story_v_out_317251.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_317251", "317251022", "story_v_out_317251.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play317251023 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317251023
		arg_110_1.duration_ = 1.8

		local var_110_0 = {
			zh = 1.8,
			ja = 1.666
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play317251024(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.125

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[563].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(317251023)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 5 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 5)

				if (5 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 5)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251023", "story_v_out_317251.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251023", "story_v_out_317251.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_317251", "317251023", "story_v_out_317251.awb")

						arg_110_1:RecordAudio("317251023", var_113_6)
						arg_110_1:RecordAudio("317251023", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_317251", "317251023", "story_v_out_317251.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_317251", "317251023", "story_v_out_317251.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317251024 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 317251024
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play317251025(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.55

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(317251024).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 22)

				if (22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 22)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play317251025 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 317251025
		arg_118_1.duration_ = 11.83

		local var_118_0 = {
			zh = 8.066,
			ja = 11.833
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play317251026(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.95

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:GetWordFromCfg(317251025)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 38 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 38)

				if (38 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 38)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251025", "story_v_out_317251.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251025", "story_v_out_317251.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_317251", "317251025", "story_v_out_317251.awb")

						arg_118_1:RecordAudio("317251025", var_121_6)
						arg_118_1:RecordAudio("317251025", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_317251", "317251025", "story_v_out_317251.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_317251", "317251025", "story_v_out_317251.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play317251026 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 317251026
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play317251027(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 2.025

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(317251026).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 81 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 81)

				if (81 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 81)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play317251027 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 317251027
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play317251028(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.9

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(317251027).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 36 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 36)

				if (36 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 36)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play317251028 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 317251028
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play317251029(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.075

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(317251028).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 43 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 43)

				if (43 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 43)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play317251029 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 317251029
		arg_134_1.duration_ = 4.87

		local var_134_0 = {
			zh = 3,
			ja = 4.866
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play317251030(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1158ui_story = arg_134_1.actors_["1158ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1158ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1158ui_story, Vector3.New(0, -0.95, -6), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).z)
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles = arg_134_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1158ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6)
				arg_134_1.actors_["1158ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1158ui_story"].transform.position).z)
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1158ui_story"].transform.localEulerAngles = arg_134_1.actors_["1158ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1158ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1158ui_story == nil then
				arg_134_1.var_.characterEffect1158ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1158ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1158ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1158ui_story then
				arg_134_1.var_.characterEffect1158ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/story1158/story1158action/1158action1_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1158ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_137_4 = 0
			local var_137_5 = 0.275

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(317251029)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 11 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 11)

				if (11 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 11)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251029", "story_v_out_317251.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_317251", "317251029", "story_v_out_317251.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_317251", "317251029", "story_v_out_317251.awb")

						arg_134_1:RecordAudio("317251029", var_137_11)
						arg_134_1:RecordAudio("317251029", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_317251", "317251029", "story_v_out_317251.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_317251", "317251029", "story_v_out_317251.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play317251030 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 317251030
		arg_138_1.duration_ = 8.9

		local var_138_0 = {
			zh = 8.7,
			ja = 8.9
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play317251031(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1158ui_story"]) and arg_138_1.var_.characterEffect1158ui_story == nil then
				arg_138_1.var_.characterEffect1158ui_story = arg_138_1.actors_["1158ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1158ui_story"]) then
				if arg_138_1.var_.characterEffect1158ui_story and not isNil(arg_138_1.actors_["1158ui_story"]) then
					arg_138_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1158ui_story"]) and arg_138_1.var_.characterEffect1158ui_story then
				arg_138_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_141_1 = arg_138_1.actors_["1158ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1158ui_story = var_141_1.localPosition
			end

			local var_141_2 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 then
				var_141_1.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1158ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_2)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 then
				var_141_1.localPosition = Vector3.New(0, 100, 0)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			local var_141_3 = 0
			local var_141_4 = 0.9

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_5 = arg_138_1:GetWordFromCfg(317251030)
				local var_141_6 = arg_138_1:FormatText(var_141_5.content)

				arg_138_1.text_.text = var_141_6

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_8 = 36 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 36)

				if (36 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 36)) > 0 and var_141_4 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_3
					end
				end

				arg_138_1.text_.text = var_141_6
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251030", "story_v_out_317251.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_317251", "317251030", "story_v_out_317251.awb") / 1000

					if var_141_9 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_3
					end

					if var_141_5.prefab_name ~= "" and arg_138_1.actors_[var_141_5.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_5.prefab_name].transform, "story_v_out_317251", "317251030", "story_v_out_317251.awb")

						arg_138_1:RecordAudio("317251030", var_141_10)
						arg_138_1:RecordAudio("317251030", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_317251", "317251030", "story_v_out_317251.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_317251", "317251030", "story_v_out_317251.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_4, arg_138_1.talkMaxDuration)

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_3) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_3 + var_141_11 and arg_138_1.time_ < var_141_3 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1158ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play317251031 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 317251031
		arg_142_1.duration_ = 8.73

		local var_142_0 = {
			zh = 8.1,
			ja = 8.733
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play317251032(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.9

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:GetWordFromCfg(317251031)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 36 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 36)

				if (36 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 36)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251031", "story_v_out_317251.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251031", "story_v_out_317251.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_317251", "317251031", "story_v_out_317251.awb")

						arg_142_1:RecordAudio("317251031", var_145_6)
						arg_142_1:RecordAudio("317251031", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_317251", "317251031", "story_v_out_317251.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_317251", "317251031", "story_v_out_317251.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play317251032 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 317251032
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play317251033(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.65

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(317251032).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 26 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 26)

				if (26 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 26)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play317251033 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 317251033
		arg_150_1.duration_ = 8.63

		local var_150_0 = {
			zh = 8.633,
			ja = 6.2
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play317251034(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.975

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:GetWordFromCfg(317251033)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 39 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 39)

				if (39 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 39)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251033", "story_v_out_317251.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251033", "story_v_out_317251.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_317251", "317251033", "story_v_out_317251.awb")

						arg_150_1:RecordAudio("317251033", var_153_6)
						arg_150_1:RecordAudio("317251033", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_317251", "317251033", "story_v_out_317251.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_317251", "317251033", "story_v_out_317251.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play317251034 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 317251034
		arg_154_1.duration_ = 9.5

		local var_154_0 = {
			zh = 5.9,
			ja = 9.5
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play317251035(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.575

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:GetWordFromCfg(317251034)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 23 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 23)

				if (23 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 23)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251034", "story_v_out_317251.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251034", "story_v_out_317251.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_317251", "317251034", "story_v_out_317251.awb")

						arg_154_1:RecordAudio("317251034", var_157_6)
						arg_154_1:RecordAudio("317251034", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_317251", "317251034", "story_v_out_317251.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_317251", "317251034", "story_v_out_317251.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play317251035 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 317251035
		arg_158_1.duration_ = 7.27

		local var_158_0 = {
			zh = 1.666,
			ja = 7.266
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play317251036(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.125

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_1 = arg_158_1:GetWordFromCfg(317251035)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 5 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 5)

				if (5 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 5)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317251", "317251035", "story_v_out_317251.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_317251", "317251035", "story_v_out_317251.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_317251", "317251035", "story_v_out_317251.awb")

						arg_158_1:RecordAudio("317251035", var_161_6)
						arg_158_1:RecordAudio("317251035", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_317251", "317251035", "story_v_out_317251.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_317251", "317251035", "story_v_out_317251.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play317251036 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 317251036
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
			arg_162_1.auto_ = false
		end

		function arg_162_1.playNext_(arg_164_0)
			arg_162_1.onStoryFinished_()
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.275

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(317251036).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 51 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 51)

				if (51 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 51)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/K12f",
		"TextureConfig/Background/ST58"
	},
	voices = {
		"story_v_out_317251.awb"
	}
}
