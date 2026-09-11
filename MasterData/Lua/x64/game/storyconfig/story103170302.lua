return {
	Play317032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317032001
		arg_1_1.duration_ = 5.27

		local var_1_0 = {
			zh = 4.233,
			ja = 5.266
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K10f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K10f")
				var_4_0.name = "K10f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K10f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K10f

				arg_1_1.bgs_.K10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K10f" then
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

			local var_4_8 = "2078ui_story"

			if arg_1_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["2078ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos2078ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.28, -5.6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["2078ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect2078ui_story == nil then
				arg_1_1.var_.characterEffect2078ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect2078ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect2078ui_story then
				arg_1_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(317032001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)

				if (6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032001", "story_v_out_317032.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_317032", "317032001", "story_v_out_317032.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_317032", "317032001", "story_v_out_317032.awb")

						arg_1_1:RecordAudio("317032001", var_4_31)
						arg_1_1:RecordAudio("317032001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317032", "317032001", "story_v_out_317032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317032", "317032001", "story_v_out_317032.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play317032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317032002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos2078ui_story = arg_9_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).z)
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles = arg_9_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2078ui_story"].transform.position).z)
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2078ui_story"].transform.localEulerAngles = arg_9_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["2078ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2078ui_story == nil then
				arg_9_1.var_.characterEffect2078ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect2078ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_9_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2078ui_story then
				arg_9_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_9_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 1.15

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(317032002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 46 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 46)

				if (46 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 46)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play317032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317032003
		arg_13_1.duration_ = 3.37

		local var_13_0 = {
			zh = 3.366,
			ja = 2.3
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
				arg_13_0:Play317032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos2078ui_story = arg_13_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).z)
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles = arg_13_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_13_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["2078ui_story"].transform.position).z)
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["2078ui_story"].transform.localEulerAngles = arg_13_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["2078ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect2078ui_story == nil then
				arg_13_1.var_.characterEffect2078ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect2078ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect2078ui_story then
				arg_13_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_4 = "1015ui_story"

			if arg_13_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_16_5 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_13_1.stage_.transform)

				var_16_5.name = var_16_4
				var_16_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_4] = var_16_5

				local var_16_6 = var_16_5:GetComponentInChildren(typeof(CharacterEffect))

				var_16_6.enabled = true

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_6.transform, false)

				arg_13_1.var_[var_16_4 .. "Animator"] = var_16_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_4 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_4 .. "LipSync"] = var_16_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_8 = arg_13_1.actors_["1015ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1015ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["1015ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1015ui_story == nil then
				arg_13_1.var_.characterEffect1015ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect1015ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1015ui_story then
				arg_13_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_16_12 = 0
			local var_16_13 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
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

				local var_16_14 = arg_13_1:GetWordFromCfg(317032003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 13 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 13)

				if (13 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 13)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032003", "story_v_out_317032.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032003", "story_v_out_317032.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_317032", "317032003", "story_v_out_317032.awb")

						arg_13_1:RecordAudio("317032003", var_16_19)
						arg_13_1:RecordAudio("317032003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317032", "317032003", "story_v_out_317032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317032", "317032003", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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
	Play317032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317032004
		arg_17_1.duration_ = 1.37

		local var_17_0 = {
			zh = 1.033,
			ja = 1.366
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
				arg_17_0:Play317032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos2078ui_story = arg_17_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).z)
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles = arg_17_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_17_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2078ui_story"].transform.position).z)
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2078ui_story"].transform.localEulerAngles = arg_17_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["2078ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2078ui_story == nil then
				arg_17_1.var_.characterEffect2078ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect2078ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_17_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2078ui_story then
				arg_17_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_17_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_20_3 = arg_17_1.actors_["1015ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1015ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1015ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1015ui_story == nil then
				arg_17_1.var_.characterEffect1015ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1015ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1015ui_story then
				arg_17_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(317032004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 5 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 5)

				if (5 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 5)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032004", "story_v_out_317032.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032004", "story_v_out_317032.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_317032", "317032004", "story_v_out_317032.awb")

						arg_17_1:RecordAudio("317032004", var_20_15)
						arg_17_1:RecordAudio("317032004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317032", "317032004", "story_v_out_317032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317032", "317032004", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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
	Play317032005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317032005
		arg_21_1.duration_ = 5.57

		local var_21_0 = {
			zh = 4.466,
			ja = 5.566
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317032006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos2078ui_story = arg_21_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).z)
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles = arg_21_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_21_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2078ui_story"].transform.position).z)
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2078ui_story"].transform.localEulerAngles = arg_21_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["2078ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect2078ui_story == nil then
				arg_21_1.var_.characterEffect2078ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect2078ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect2078ui_story then
				arg_21_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1015ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1015ui_story = var_24_4.localPosition
			end

			local var_24_5 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 then
				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_21_1.time_ - 0) / var_24_5)
				var_24_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_4.position).x, (manager.ui.mainCamera.transform.position - var_24_4.position).y, (manager.ui.mainCamera.transform.position - var_24_4.position).z)
				var_24_4.localEulerAngles.z = 0
				var_24_4.localEulerAngles.x = 0
				var_24_4.localEulerAngles = var_24_4.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_24_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_4.position).x, (manager.ui.mainCamera.transform.position - var_24_4.position).y, (manager.ui.mainCamera.transform.position - var_24_4.position).z)
				var_24_4.localEulerAngles.z = 0
				var_24_4.localEulerAngles.x = 0
				var_24_4.localEulerAngles = var_24_4.localEulerAngles
			end

			local var_24_6 = arg_21_1.actors_["1015ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1015ui_story == nil then
				arg_21_1.var_.characterEffect1015ui_story = var_24_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 and not isNil(var_24_6) then
				if arg_21_1.var_.characterEffect1015ui_story and not isNil(var_24_6) then
					arg_21_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_7)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 and not isNil(var_24_6) and arg_21_1.var_.characterEffect1015ui_story then
				arg_21_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_24_8 = 0
			local var_24_9 = 0.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(317032005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 23 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 23)

				if (23 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 23)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032005", "story_v_out_317032.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032005", "story_v_out_317032.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_317032", "317032005", "story_v_out_317032.awb")

						arg_21_1:RecordAudio("317032005", var_24_15)
						arg_21_1:RecordAudio("317032005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317032", "317032005", "story_v_out_317032.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317032", "317032005", "story_v_out_317032.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
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
	Play317032006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317032006
		arg_25_1.duration_ = 6.77

		local var_25_0 = {
			zh = 6.766,
			ja = 6.733
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
				arg_25_0:Play317032007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos2078ui_story = arg_25_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).z)
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles = arg_25_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
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

			local var_28_3 = arg_25_1.actors_["1015ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1015ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1015ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1015ui_story == nil then
				arg_25_1.var_.characterEffect1015ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1015ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1015ui_story then
				arg_25_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = 0
			local var_28_9 = 0.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(317032006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 34 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 34)

				if (34 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 34)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032006", "story_v_out_317032.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032006", "story_v_out_317032.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_317032", "317032006", "story_v_out_317032.awb")

						arg_25_1:RecordAudio("317032006", var_28_15)
						arg_25_1:RecordAudio("317032006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317032", "317032006", "story_v_out_317032.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317032", "317032006", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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
	Play317032007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317032007
		arg_29_1.duration_ = 4.77

		local var_29_0 = {
			zh = 4.033,
			ja = 4.766
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
				arg_29_0:Play317032008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos2078ui_story = arg_29_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).z)
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles = arg_29_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_29_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).z)
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles = arg_29_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["2078ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect2078ui_story == nil then
				arg_29_1.var_.characterEffect2078ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect2078ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect2078ui_story then
				arg_29_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["1015ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1015ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_29_1.time_ - 0) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = arg_29_1.actors_["1015ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1015ui_story == nil then
				arg_29_1.var_.characterEffect1015ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect1015ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1015ui_story then
				arg_29_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_32_8 = 0
			local var_32_9 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(317032007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 22 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 22)

				if (22 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 22)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032007", "story_v_out_317032.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032007", "story_v_out_317032.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_317032", "317032007", "story_v_out_317032.awb")

						arg_29_1:RecordAudio("317032007", var_32_15)
						arg_29_1:RecordAudio("317032007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317032", "317032007", "story_v_out_317032.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317032", "317032007", "story_v_out_317032.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
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
	Play317032008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317032008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317032009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos2078ui_story = arg_33_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).z)
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles = arg_33_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["2078ui_story"].transform.position).z)
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["2078ui_story"].transform.localEulerAngles = arg_33_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1015ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1015ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0, 100, 0)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = 0
			local var_36_4 = 1.375

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

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(317032008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 55 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 55)

				if (55 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 55)) > 0 and var_36_4 < var_36_7 then
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
				actorName = "1015ui_story",
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
	Play317032009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317032009
		arg_37_1.duration_ = 2.93

		local var_37_0 = {
			zh = 2.1,
			ja = 2.933
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
				arg_37_0:Play317032010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1015ui_story = arg_37_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).z)
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles = arg_37_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_37_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1015ui_story"].transform.position).z)
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1015ui_story"].transform.localEulerAngles = arg_37_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1015ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1015ui_story == nil then
				arg_37_1.var_.characterEffect1015ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1015ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1015ui_story then
				arg_37_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(317032009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)

				if (11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032009", "story_v_out_317032.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032009", "story_v_out_317032.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_317032", "317032009", "story_v_out_317032.awb")

						arg_37_1:RecordAudio("317032009", var_40_11)
						arg_37_1:RecordAudio("317032009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317032", "317032009", "story_v_out_317032.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317032", "317032009", "story_v_out_317032.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317032010
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317032011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1015ui_story = arg_41_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).z)
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles = arg_41_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).z)
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles = arg_41_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1015ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1015ui_story == nil then
				arg_41_1.var_.characterEffect1015ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1015ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1015ui_story then
				arg_41_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_44_3 = arg_41_1.actors_["2078ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos2078ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["2078ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect2078ui_story == nil then
				arg_41_1.var_.characterEffect2078ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect2078ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect2078ui_story then
				arg_41_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_8 = 0
			local var_44_9 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(317032010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 3 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 3)

				if (3 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 3)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032010", "story_v_out_317032.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032010", "story_v_out_317032.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_317032", "317032010", "story_v_out_317032.awb")

						arg_41_1:RecordAudio("317032010", var_44_15)
						arg_41_1:RecordAudio("317032010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317032", "317032010", "story_v_out_317032.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317032", "317032010", "story_v_out_317032.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play317032011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317032011
		arg_45_1.duration_ = 10.37

		local var_45_0 = {
			zh = 10.366,
			ja = 9.4
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
				arg_45_0:Play317032012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos2078ui_story = arg_45_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).z)
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles = arg_45_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).z)
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles = arg_45_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["2078ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2078ui_story == nil then
				arg_45_1.var_.characterEffect2078ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect2078ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_45_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_2)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2078ui_story then
				arg_45_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_45_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_48_3 = "2079ui_story"

			if arg_45_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_48_4 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_45_1.stage_.transform)

				var_48_4.name = var_48_3
				var_48_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_[var_48_3] = var_48_4

				local var_48_5 = var_48_4:GetComponentInChildren(typeof(CharacterEffect))

				var_48_5.enabled = true

				local var_48_6 = GameObjectTools.GetOrAddComponent(var_48_4, typeof(DynamicBoneHelper))

				if var_48_6 then
					var_48_6:EnableDynamicBone(false)
				end

				arg_45_1:ShowWeapon(var_48_5.transform, false)

				arg_45_1.var_[var_48_3 .. "Animator"] = var_48_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_45_1.var_[var_48_3 .. "Animator"].applyRootMotion = true
				arg_45_1.var_[var_48_3 .. "LipSync"] = var_48_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_48_7 = arg_45_1.actors_["2079ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos2079ui_story = var_48_7.localPosition
			end

			local var_48_8 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_8 then
				var_48_7.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_45_1.time_ - 0) / var_48_8)
				var_48_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_7.position).x, (manager.ui.mainCamera.transform.position - var_48_7.position).y, (manager.ui.mainCamera.transform.position - var_48_7.position).z)
				var_48_7.localEulerAngles.z = 0
				var_48_7.localEulerAngles.x = 0
				var_48_7.localEulerAngles = var_48_7.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_8 and arg_45_1.time_ < 0 + var_48_8 + arg_48_0 then
				var_48_7.localPosition = Vector3.New(0, -1.28, -5.6)
				var_48_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_7.position).x, (manager.ui.mainCamera.transform.position - var_48_7.position).y, (manager.ui.mainCamera.transform.position - var_48_7.position).z)
				var_48_7.localEulerAngles.z = 0
				var_48_7.localEulerAngles.x = 0
				var_48_7.localEulerAngles = var_48_7.localEulerAngles
			end

			local var_48_9 = arg_45_1.actors_["2079ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect2079ui_story == nil then
				arg_45_1.var_.characterEffect2079ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_10 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_10 and not isNil(var_48_9) then
				if arg_45_1.var_.characterEffect2079ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_10 and arg_45_1.time_ < 0 + var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect2079ui_story then
				arg_45_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_12 = 0
			local var_48_13 = 1.3

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(317032011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 52 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 52)

				if (52 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 52)) > 0 and var_48_13 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032011", "story_v_out_317032.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032011", "story_v_out_317032.awb") / 1000

					if var_48_18 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_12
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_317032", "317032011", "story_v_out_317032.awb")

						arg_45_1:RecordAudio("317032011", var_48_19)
						arg_45_1:RecordAudio("317032011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317032", "317032011", "story_v_out_317032.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317032", "317032011", "story_v_out_317032.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_20 and arg_45_1.time_ < var_48_12 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play317032012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317032012
		arg_49_1.duration_ = 8.8

		local var_49_0 = {
			zh = 8.8,
			ja = 8.1
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
				arg_49_0:Play317032013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos2079ui_story = arg_49_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).z)
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles = arg_49_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_49_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).z)
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles = arg_49_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["2079ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect2079ui_story == nil then
				arg_49_1.var_.characterEffect2079ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect2079ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_49_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect2079ui_story then
				arg_49_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_49_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_52_3 = arg_49_1.actors_["1015ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1015ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1015ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1015ui_story == nil then
				arg_49_1.var_.characterEffect1015ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1015ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1015ui_story then
				arg_49_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_8 = 0
			local var_52_9 = 1.025

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(317032012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 41 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 41)

				if (41 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 41)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032012", "story_v_out_317032.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032012", "story_v_out_317032.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_317032", "317032012", "story_v_out_317032.awb")

						arg_49_1:RecordAudio("317032012", var_52_15)
						arg_49_1:RecordAudio("317032012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317032", "317032012", "story_v_out_317032.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317032", "317032012", "story_v_out_317032.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
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
	Play317032013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317032013
		arg_53_1.duration_ = 2.43

		local var_53_0 = {
			zh = 1.1,
			ja = 2.433
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
				arg_53_0:Play317032014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos2079ui_story = arg_53_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["2079ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect2079ui_story == nil then
				arg_53_1.var_.characterEffect2079ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect2079ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect2079ui_story then
				arg_53_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["1015ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1015ui_story = var_56_4.localPosition
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_53_1.time_ - 0) / var_56_5)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_56_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_4.position).x, (manager.ui.mainCamera.transform.position - var_56_4.position).y, (manager.ui.mainCamera.transform.position - var_56_4.position).z)
				var_56_4.localEulerAngles.z = 0
				var_56_4.localEulerAngles.x = 0
				var_56_4.localEulerAngles = var_56_4.localEulerAngles
			end

			local var_56_6 = arg_53_1.actors_["1015ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1015ui_story == nil then
				arg_53_1.var_.characterEffect1015ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 and not isNil(var_56_6) then
				if arg_53_1.var_.characterEffect1015ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_7)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1015ui_story then
				arg_53_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_56_8 = 0
			local var_56_9 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(317032013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 4 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 4)

				if (4 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 4)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032013", "story_v_out_317032.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032013", "story_v_out_317032.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_317032", "317032013", "story_v_out_317032.awb")

						arg_53_1:RecordAudio("317032013", var_56_15)
						arg_53_1:RecordAudio("317032013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317032", "317032013", "story_v_out_317032.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317032", "317032013", "story_v_out_317032.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play317032014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317032014
		arg_57_1.duration_ = 8.13

		local var_57_0 = {
			zh = 5.6,
			ja = 8.133
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
				arg_57_0:Play317032015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos2079ui_story = arg_57_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).z)
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles = arg_57_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).z)
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles = arg_57_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["2079ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect2079ui_story == nil then
				arg_57_1.var_.characterEffect2079ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect2079ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_57_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect2079ui_story then
				arg_57_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_57_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_60_3 = arg_57_1.actors_["1015ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1015ui_story = var_60_3.localPosition
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_3.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_4)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_3.localPosition = Vector3.New(0, 100, 0)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			local var_60_5 = arg_57_1.actors_["1015ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1015ui_story == nil then
				arg_57_1.var_.characterEffect1015ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.characterEffect1015ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_6)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1015ui_story then
				arg_57_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_60_7 = "1093ui_story"

			if arg_57_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_60_8 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_57_1.stage_.transform)

				var_60_8.name = var_60_7
				var_60_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_[var_60_7] = var_60_8

				local var_60_9 = var_60_8:GetComponentInChildren(typeof(CharacterEffect))

				var_60_9.enabled = true

				local var_60_10 = GameObjectTools.GetOrAddComponent(var_60_8, typeof(DynamicBoneHelper))

				if var_60_10 then
					var_60_10:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_9.transform, false)

				arg_57_1.var_[var_60_7 .. "Animator"] = var_60_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_[var_60_7 .. "Animator"].applyRootMotion = true
				arg_57_1.var_[var_60_7 .. "LipSync"] = var_60_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_11 = arg_57_1.actors_["1093ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1093ui_story = var_60_11.localPosition
			end

			local var_60_12 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_12 then
				var_60_11.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_57_1.time_ - 0) / var_60_12)
				var_60_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_11.position).x, (manager.ui.mainCamera.transform.position - var_60_11.position).y, (manager.ui.mainCamera.transform.position - var_60_11.position).z)
				var_60_11.localEulerAngles.z = 0
				var_60_11.localEulerAngles.x = 0
				var_60_11.localEulerAngles = var_60_11.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_12 and arg_57_1.time_ < 0 + var_60_12 + arg_60_0 then
				var_60_11.localPosition = Vector3.New(0, -1.11, -5.88)
				var_60_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_11.position).x, (manager.ui.mainCamera.transform.position - var_60_11.position).y, (manager.ui.mainCamera.transform.position - var_60_11.position).z)
				var_60_11.localEulerAngles.z = 0
				var_60_11.localEulerAngles.x = 0
				var_60_11.localEulerAngles = var_60_11.localEulerAngles
			end

			local var_60_13 = arg_57_1.actors_["1093ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect1093ui_story == nil then
				arg_57_1.var_.characterEffect1093ui_story = var_60_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_14 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_14 and not isNil(var_60_13) then
				if arg_57_1.var_.characterEffect1093ui_story and not isNil(var_60_13) then
					arg_57_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_14 and arg_57_1.time_ < 0 + var_60_14 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect1093ui_story then
				arg_57_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_60_16 = 0
			local var_60_17 = 0.75

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(317032014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 30 <= 0 and var_60_17 or var_60_17 * (utf8.len(var_60_19) / 30)

				if (30 <= 0 and var_60_17 or var_60_17 * (utf8.len(var_60_19) / 30)) > 0 and var_60_17 < var_60_21 then
					arg_57_1.talkMaxDuration = var_60_21

					if var_60_21 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_21 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032014", "story_v_out_317032.awb") ~= 0 then
					local var_60_22 = manager.audio:GetVoiceLength("story_v_out_317032", "317032014", "story_v_out_317032.awb") / 1000

					if var_60_22 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_16
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_317032", "317032014", "story_v_out_317032.awb")

						arg_57_1:RecordAudio("317032014", var_60_23)
						arg_57_1:RecordAudio("317032014", var_60_23)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317032", "317032014", "story_v_out_317032.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317032", "317032014", "story_v_out_317032.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_24 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_24 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_24

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_24 and arg_57_1.time_ < var_60_16 + var_60_24 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317032015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317032015
		arg_61_1.duration_ = 8.7

		local var_61_0 = {
			zh = 8.7,
			ja = 6.833
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
				arg_61_0:Play317032016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1093ui_story = arg_61_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).z)
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles = arg_61_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1093ui_story"].transform.position).z)
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1093ui_story"].transform.localEulerAngles = arg_61_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1093ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1093ui_story == nil then
				arg_61_1.var_.characterEffect1093ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1093ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1093ui_story then
				arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_64_3 = arg_61_1.actors_["2078ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos2078ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["2078ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect2078ui_story == nil then
				arg_61_1.var_.characterEffect2078ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect2078ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect2078ui_story then
				arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_8 = 0
			local var_64_9 = 1.225

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(317032015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 49 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 49)

				if (49 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 49)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032015", "story_v_out_317032.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032015", "story_v_out_317032.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_317032", "317032015", "story_v_out_317032.awb")

						arg_61_1:RecordAudio("317032015", var_64_15)
						arg_61_1:RecordAudio("317032015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317032", "317032015", "story_v_out_317032.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317032", "317032015", "story_v_out_317032.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play317032016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317032016
		arg_65_1.duration_ = 2.23

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_65_0:Play317032017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1093ui_story = arg_65_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).z)
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles = arg_65_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_65_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).z)
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles = arg_65_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1093ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1093ui_story == nil then
				arg_65_1.var_.characterEffect1093ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1093ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1093ui_story then
				arg_65_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_68_4 = arg_65_1.actors_["2078ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos2078ui_story = var_68_4.localPosition
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_5)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(0, 100, 0)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			local var_68_6 = arg_65_1.actors_["2078ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2078ui_story == nil then
				arg_65_1.var_.characterEffect2078ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect2078ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2078ui_story then
				arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_68_8 = 0
			local var_68_9 = 0.2

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(317032016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 8 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 8)

				if (8 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 8)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032016", "story_v_out_317032.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032016", "story_v_out_317032.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_317032", "317032016", "story_v_out_317032.awb")

						arg_65_1:RecordAudio("317032016", var_68_15)
						arg_65_1:RecordAudio("317032016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317032", "317032016", "story_v_out_317032.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317032", "317032016", "story_v_out_317032.awb")
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
				actorName = "1093ui_story",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play317032017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317032017
		arg_69_1.duration_ = 7.37

		local var_69_0 = {
			zh = 4.333,
			ja = 7.366
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
				arg_69_0:Play317032018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1093ui_story = arg_69_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).z)
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles = arg_69_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_69_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1093ui_story"].transform.position).z)
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1093ui_story"].transform.localEulerAngles = arg_69_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1093ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1093ui_story == nil then
				arg_69_1.var_.characterEffect1093ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1093ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1093ui_story then
				arg_69_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.575

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(317032017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 21 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 21)

				if (21 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 21)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032017", "story_v_out_317032.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032017", "story_v_out_317032.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_317032", "317032017", "story_v_out_317032.awb")

						arg_69_1:RecordAudio("317032017", var_72_11)
						arg_69_1:RecordAudio("317032017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317032", "317032017", "story_v_out_317032.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317032", "317032017", "story_v_out_317032.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317032018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317032018
		arg_73_1.duration_ = 6.2

		local var_73_0 = {
			zh = 6.2,
			ja = 4.466
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
				arg_73_0:Play317032019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos2078ui_story = arg_73_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).z)
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles = arg_73_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_73_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["2078ui_story"].transform.position).z)
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["2078ui_story"].transform.localEulerAngles = arg_73_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["2078ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect2078ui_story == nil then
				arg_73_1.var_.characterEffect2078ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect2078ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect2078ui_story then
				arg_73_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = arg_73_1.actors_["1093ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1093ui_story = var_76_4.localPosition
			end

			local var_76_5 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 then
				var_76_4.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_5)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				var_76_4.localPosition = Vector3.New(0, 100, 0)
				var_76_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_4.position).x, (manager.ui.mainCamera.transform.position - var_76_4.position).y, (manager.ui.mainCamera.transform.position - var_76_4.position).z)
				var_76_4.localEulerAngles.z = 0
				var_76_4.localEulerAngles.x = 0
				var_76_4.localEulerAngles = var_76_4.localEulerAngles
			end

			local var_76_6 = arg_73_1.actors_["1093ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1093ui_story == nil then
				arg_73_1.var_.characterEffect1093ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_7 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 and not isNil(var_76_6) then
				if arg_73_1.var_.characterEffect1093ui_story and not isNil(var_76_6) then
					arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_7)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1093ui_story then
				arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_76_8 = 0
			local var_76_9 = 0.9

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(317032018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 36 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 36)

				if (36 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 36)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032018", "story_v_out_317032.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032018", "story_v_out_317032.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_317032", "317032018", "story_v_out_317032.awb")

						arg_73_1:RecordAudio("317032018", var_76_15)
						arg_73_1:RecordAudio("317032018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317032", "317032018", "story_v_out_317032.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317032", "317032018", "story_v_out_317032.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317032019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317032019
		arg_77_1.duration_ = 8.37

		local var_77_0 = {
			zh = 7.4,
			ja = 8.366
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
				arg_77_0:Play317032020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1093ui_story = arg_77_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1093ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_80_4 = arg_77_1.actors_["2078ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos2078ui_story = var_80_4.localPosition
			end

			local var_80_5 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 then
				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_5)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, 100, 0)
				var_80_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_4.position).x, (manager.ui.mainCamera.transform.position - var_80_4.position).y, (manager.ui.mainCamera.transform.position - var_80_4.position).z)
				var_80_4.localEulerAngles.z = 0
				var_80_4.localEulerAngles.x = 0
				var_80_4.localEulerAngles = var_80_4.localEulerAngles
			end

			local var_80_6 = arg_77_1.actors_["2078ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect2078ui_story == nil then
				arg_77_1.var_.characterEffect2078ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect2078ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_77_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect2078ui_story then
				arg_77_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_77_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_80_8 = 0
			local var_80_9 = 0.8

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(317032019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 32 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 32)

				if (32 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 32)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032019", "story_v_out_317032.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032019", "story_v_out_317032.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_317032", "317032019", "story_v_out_317032.awb")

						arg_77_1:RecordAudio("317032019", var_80_15)
						arg_77_1:RecordAudio("317032019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317032", "317032019", "story_v_out_317032.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317032", "317032019", "story_v_out_317032.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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

		arg_77_1:InitPlayNodeList()
	end,
	Play317032020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317032020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317032021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = arg_81_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).z)
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles = arg_81_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1093ui_story"].transform.position).z)
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1093ui_story"].transform.localEulerAngles = arg_81_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1093ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 0.8

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(317032020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 32 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 32)

				if (32 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 32)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317032021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317032021
		arg_85_1.duration_ = 6.17

		local var_85_0 = {
			zh = 5.9,
			ja = 6.166
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
				arg_85_0:Play317032022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1093ui_story = arg_85_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_85_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1093ui_story"].transform.position).z)
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1093ui_story"].transform.localEulerAngles = arg_85_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1093ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(317032021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 26 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 26)

				if (26 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 26)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032021", "story_v_out_317032.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032021", "story_v_out_317032.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_317032", "317032021", "story_v_out_317032.awb")

						arg_85_1:RecordAudio("317032021", var_88_11)
						arg_85_1:RecordAudio("317032021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317032", "317032021", "story_v_out_317032.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317032", "317032021", "story_v_out_317032.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317032022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317032022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317032023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1093ui_story = arg_89_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).z)
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles = arg_89_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).z)
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles = arg_89_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1015ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1015ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, -1.15, -6.2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_92_3 = 0
			local var_92_4 = 0.5

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

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(317032022).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 20 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 20)

				if (20 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 20)) > 0 and var_92_4 < var_92_7 then
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317032023
		arg_93_1.duration_ = 3.53

		local var_93_0 = {
			zh = 3.533,
			ja = 3.133
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
				arg_93_0:Play317032024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1015ui_story = arg_93_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).z)
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles = arg_93_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_93_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1015ui_story"].transform.position).z)
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1015ui_story"].transform.localEulerAngles = arg_93_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1015ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1015ui_story == nil then
				arg_93_1.var_.characterEffect1015ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1015ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1015ui_story then
				arg_93_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(317032023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 19 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 19)

				if (19 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 19)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032023", "story_v_out_317032.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032023", "story_v_out_317032.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_317032", "317032023", "story_v_out_317032.awb")

						arg_93_1:RecordAudio("317032023", var_96_11)
						arg_93_1:RecordAudio("317032023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_317032", "317032023", "story_v_out_317032.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_317032", "317032023", "story_v_out_317032.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317032024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317032025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1015ui_story"]) and arg_97_1.var_.characterEffect1015ui_story == nil then
				arg_97_1.var_.characterEffect1015ui_story = arg_97_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1015ui_story"]) then
				if arg_97_1.var_.characterEffect1015ui_story and not isNil(arg_97_1.actors_["1015ui_story"]) then
					arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1015ui_story"]) and arg_97_1.var_.characterEffect1015ui_story then
				arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(317032024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 13 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 13)

				if (13 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 13)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play317032025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317032025
		arg_101_1.duration_ = 7.17

		local var_101_0 = {
			zh = 7.166,
			ja = 3.666
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
				arg_101_0:Play317032026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1015ui_story = arg_101_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).z)
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles = arg_101_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_101_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1015ui_story"].transform.position).z)
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1015ui_story"].transform.localEulerAngles = arg_101_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1015ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1015ui_story == nil then
				arg_101_1.var_.characterEffect1015ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1015ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1015ui_story then
				arg_101_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_104_3 = arg_101_1.actors_["2078ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos2078ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = arg_101_1.actors_["2078ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect2078ui_story == nil then
				arg_101_1.var_.characterEffect2078ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.characterEffect2078ui_story and not isNil(var_104_5) then
					arg_101_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect2078ui_story then
				arg_101_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_8 = 0
			local var_104_9 = 0.8

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(317032025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 32 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 32)

				if (32 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 32)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032025", "story_v_out_317032.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032025", "story_v_out_317032.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_317032", "317032025", "story_v_out_317032.awb")

						arg_101_1:RecordAudio("317032025", var_104_15)
						arg_101_1:RecordAudio("317032025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317032", "317032025", "story_v_out_317032.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317032", "317032025", "story_v_out_317032.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_101_1:InitPlayNodeList()
	end,
	Play317032026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317032026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317032027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["2078ui_story"]) and arg_105_1.var_.characterEffect2078ui_story == nil then
				arg_105_1.var_.characterEffect2078ui_story = arg_105_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["2078ui_story"]) then
				if arg_105_1.var_.characterEffect2078ui_story and not isNil(arg_105_1.actors_["2078ui_story"]) then
					arg_105_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_105_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["2078ui_story"]) and arg_105_1.var_.characterEffect2078ui_story then
				arg_105_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_105_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(317032026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 40 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 40)

				if (40 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 40)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play317032027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317032027
		arg_109_1.duration_ = 2.37

		local var_109_0 = {
			zh = 1.033,
			ja = 2.366
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
				arg_109_0:Play317032028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1015ui_story = arg_109_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).z)
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles = arg_109_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_109_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1015ui_story"].transform.position).z)
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1015ui_story"].transform.localEulerAngles = arg_109_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1015ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1015ui_story == nil then
				arg_109_1.var_.characterEffect1015ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1015ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1015ui_story then
				arg_109_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_112_3 = arg_109_1.actors_["2078ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos2078ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["2078ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect2078ui_story == nil then
				arg_109_1.var_.characterEffect2078ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect2078ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect2078ui_story then
				arg_109_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_8 = 0
			local var_112_9 = 0.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(317032027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 4 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 4)

				if (4 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 4)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032027", "story_v_out_317032.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032027", "story_v_out_317032.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_317032", "317032027", "story_v_out_317032.awb")

						arg_109_1:RecordAudio("317032027", var_112_15)
						arg_109_1:RecordAudio("317032027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317032", "317032027", "story_v_out_317032.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317032", "317032027", "story_v_out_317032.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_109_1:InitPlayNodeList()
	end,
	Play317032028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317032028
		arg_113_1.duration_ = 2.2

		local var_113_0 = {
			zh = 2.2,
			ja = 2.066
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
				arg_113_0:Play317032029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1015ui_story = arg_113_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).z)
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles = arg_113_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_113_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).z)
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles = arg_113_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1015ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1015ui_story == nil then
				arg_113_1.var_.characterEffect1015ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1015ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1015ui_story then
				arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_116_4 = arg_113_1.actors_["2078ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos2078ui_story = var_116_4.localPosition
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_113_1.time_ - 0) / var_116_5)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_116_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_4.position).x, (manager.ui.mainCamera.transform.position - var_116_4.position).y, (manager.ui.mainCamera.transform.position - var_116_4.position).z)
				var_116_4.localEulerAngles.z = 0
				var_116_4.localEulerAngles.x = 0
				var_116_4.localEulerAngles = var_116_4.localEulerAngles
			end

			local var_116_6 = arg_113_1.actors_["2078ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect2078ui_story == nil then
				arg_113_1.var_.characterEffect2078ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect2078ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_113_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect2078ui_story then
				arg_113_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_113_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_116_8 = 0
			local var_116_9 = 0.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(317032028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)

				if (22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032028", "story_v_out_317032.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032028", "story_v_out_317032.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_317032", "317032028", "story_v_out_317032.awb")

						arg_113_1:RecordAudio("317032028", var_116_15)
						arg_113_1:RecordAudio("317032028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_317032", "317032028", "story_v_out_317032.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_317032", "317032028", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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

		arg_113_1:InitPlayNodeList()
	end,
	Play317032029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317032029
		arg_117_1.duration_ = 5.67

		local var_117_0 = {
			zh = 5.666,
			ja = 4.3
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
				arg_117_0:Play317032030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos2078ui_story = arg_117_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).z)
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles = arg_117_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_117_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2078ui_story"].transform.position).z)
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["2078ui_story"].transform.localEulerAngles = arg_117_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["2078ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect2078ui_story == nil then
				arg_117_1.var_.characterEffect2078ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect2078ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect2078ui_story then
				arg_117_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["2079ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos2079ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_117_1.time_ - 0) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = arg_117_1.actors_["2079ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect2079ui_story == nil then
				arg_117_1.var_.characterEffect2079ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 and not isNil(var_120_6) then
				if arg_117_1.var_.characterEffect2079ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_117_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_7)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect2079ui_story then
				arg_117_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_117_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_120_8 = arg_117_1.actors_["1015ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1015ui_story = var_120_8.localPosition
			end

			local var_120_9 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 then
				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_9)
				var_120_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_8.position).x, (manager.ui.mainCamera.transform.position - var_120_8.position).y, (manager.ui.mainCamera.transform.position - var_120_8.position).z)
				var_120_8.localEulerAngles.z = 0
				var_120_8.localEulerAngles.x = 0
				var_120_8.localEulerAngles = var_120_8.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(0, 100, 0)
				var_120_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_8.position).x, (manager.ui.mainCamera.transform.position - var_120_8.position).y, (manager.ui.mainCamera.transform.position - var_120_8.position).z)
				var_120_8.localEulerAngles.z = 0
				var_120_8.localEulerAngles.x = 0
				var_120_8.localEulerAngles = var_120_8.localEulerAngles
			end

			local var_120_10 = arg_117_1.actors_["1015ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1015ui_story == nil then
				arg_117_1.var_.characterEffect1015ui_story = var_120_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_11 and not isNil(var_120_10) then
				if arg_117_1.var_.characterEffect1015ui_story and not isNil(var_120_10) then
					arg_117_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_11)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_11 and arg_117_1.time_ < 0 + var_120_11 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1015ui_story then
				arg_117_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_120_12 = 0
			local var_120_13 = 0.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(317032029)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 19 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 19)

				if (19 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 19)) > 0 and var_120_13 < var_120_17 then
					arg_117_1.talkMaxDuration = var_120_17

					if var_120_17 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032029", "story_v_out_317032.awb") ~= 0 then
					local var_120_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032029", "story_v_out_317032.awb") / 1000

					if var_120_18 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_12
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_317032", "317032029", "story_v_out_317032.awb")

						arg_117_1:RecordAudio("317032029", var_120_19)
						arg_117_1:RecordAudio("317032029", var_120_19)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317032", "317032029", "story_v_out_317032.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317032", "317032029", "story_v_out_317032.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_20 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_20 and arg_117_1.time_ < var_120_12 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317032030
		arg_121_1.duration_ = 8.83

		local var_121_0 = {
			zh = 7.8,
			ja = 8.833
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
				arg_121_0:Play317032031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos2078ui_story = arg_121_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).z)
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles = arg_121_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_121_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["2078ui_story"].transform.position).z)
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["2078ui_story"].transform.localEulerAngles = arg_121_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["2078ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect2078ui_story == nil then
				arg_121_1.var_.characterEffect2078ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect2078ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_121_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect2078ui_story then
				arg_121_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_121_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["2079ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos2079ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["2079ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect2079ui_story == nil then
				arg_121_1.var_.characterEffect2079ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect2079ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect2079ui_story then
				arg_121_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_8 = 0
			local var_124_9 = 0.9

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(317032030)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 36 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 36)

				if (36 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 36)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032030", "story_v_out_317032.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032030", "story_v_out_317032.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_317032", "317032030", "story_v_out_317032.awb")

						arg_121_1:RecordAudio("317032030", var_124_15)
						arg_121_1:RecordAudio("317032030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317032", "317032030", "story_v_out_317032.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317032", "317032030", "story_v_out_317032.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play317032031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317032031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317032032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos2078ui_story = arg_125_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).z)
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles = arg_125_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["2078ui_story"].transform.position).z)
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["2078ui_story"].transform.localEulerAngles = arg_125_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["2078ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect2078ui_story == nil then
				arg_125_1.var_.characterEffect2078ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect2078ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_125_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect2078ui_story then
				arg_125_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_125_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_128_3 = arg_125_1.actors_["2079ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos2079ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0, 100, 0)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["2079ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect2079ui_story == nil then
				arg_125_1.var_.characterEffect2079ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect2079ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_125_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_6)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect2079ui_story then
				arg_125_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_125_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_128_7 = 0
			local var_128_8 = 0.575

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_9 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(317032031).content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 23 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_9) / 23)

				if (23 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_9) / 23)) > 0 and var_128_8 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_7 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_7
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_8, arg_125_1.talkMaxDuration)

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_7) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_7 + var_128_12 and arg_125_1.time_ < var_128_7 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play317032032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317032032
		arg_129_1.duration_ = 7.9

		local var_129_0 = {
			zh = 3.9,
			ja = 7.9
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
				arg_129_0:Play317032033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1015ui_story = arg_129_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).z)
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles = arg_129_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_129_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1015ui_story"].transform.position).z)
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1015ui_story"].transform.localEulerAngles = arg_129_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1015ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1015ui_story == nil then
				arg_129_1.var_.characterEffect1015ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1015ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1015ui_story then
				arg_129_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(317032032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)

				if (20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032032", "story_v_out_317032.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032032", "story_v_out_317032.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_317032", "317032032", "story_v_out_317032.awb")

						arg_129_1:RecordAudio("317032032", var_132_11)
						arg_129_1:RecordAudio("317032032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_317032", "317032032", "story_v_out_317032.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_317032", "317032032", "story_v_out_317032.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317032033
		arg_133_1.duration_ = 4.2

		local var_133_0 = {
			zh = 4.2,
			ja = 3.3
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
				arg_133_0:Play317032034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(317032033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)

				if (21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032033", "story_v_out_317032.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_317032", "317032033", "story_v_out_317032.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_317032", "317032033", "story_v_out_317032.awb")

						arg_133_1:RecordAudio("317032033", var_136_6)
						arg_133_1:RecordAudio("317032033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317032", "317032033", "story_v_out_317032.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317032", "317032033", "story_v_out_317032.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play317032034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317032034
		arg_137_1.duration_ = 9.03

		local var_137_0 = {
			zh = 5.6,
			ja = 9.033
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
				arg_137_0:Play317032035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos2079ui_story = arg_137_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).z)
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles = arg_137_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_137_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).z)
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles = arg_137_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["2079ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2079ui_story == nil then
				arg_137_1.var_.characterEffect2079ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect2079ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2079ui_story then
				arg_137_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = arg_137_1.actors_["1015ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1015ui_story = var_140_4.localPosition
			end

			local var_140_5 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				var_140_4.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_5)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				var_140_4.localPosition = Vector3.New(0, 100, 0)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			local var_140_6 = arg_137_1.actors_["1015ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1015ui_story == nil then
				arg_137_1.var_.characterEffect1015ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 and not isNil(var_140_6) then
				if arg_137_1.var_.characterEffect1015ui_story and not isNil(var_140_6) then
					arg_137_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_7)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1015ui_story then
				arg_137_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_140_8 = 0
			local var_140_9 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(317032034)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 28 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 28)

				if (28 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 28)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032034", "story_v_out_317032.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032034", "story_v_out_317032.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_317032", "317032034", "story_v_out_317032.awb")

						arg_137_1:RecordAudio("317032034", var_140_15)
						arg_137_1:RecordAudio("317032034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317032", "317032034", "story_v_out_317032.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317032", "317032034", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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
	Play317032035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317032035
		arg_141_1.duration_ = 8.63

		local var_141_0 = {
			zh = 8.633,
			ja = 7.833
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
				arg_141_0:Play317032036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = arg_141_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_144_4 = arg_141_1.actors_["2079ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos2079ui_story = var_144_4.localPosition
			end

			local var_144_5 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 then
				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_5)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0, 100, 0)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			local var_144_6 = arg_141_1.actors_["2079ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect2079ui_story == nil then
				arg_141_1.var_.characterEffect2079ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect2079ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_141_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect2079ui_story then
				arg_141_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_141_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_144_8 = 0
			local var_144_9 = 1.05

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(317032035)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 42 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 42)

				if (42 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 42)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032035", "story_v_out_317032.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032035", "story_v_out_317032.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_317032", "317032035", "story_v_out_317032.awb")

						arg_141_1:RecordAudio("317032035", var_144_15)
						arg_141_1:RecordAudio("317032035", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317032", "317032035", "story_v_out_317032.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317032", "317032035", "story_v_out_317032.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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

		arg_141_1:InitPlayNodeList()
	end,
	Play317032036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317032036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317032037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1093ui_story"]) and arg_145_1.var_.characterEffect1093ui_story == nil then
				arg_145_1.var_.characterEffect1093ui_story = arg_145_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1093ui_story"]) then
				if arg_145_1.var_.characterEffect1093ui_story and not isNil(arg_145_1.actors_["1093ui_story"]) then
					arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1093ui_story"]) and arg_145_1.var_.characterEffect1093ui_story then
				arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.275

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(317032036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 11 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 11)

				if (11 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 11)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play317032037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317032037
		arg_149_1.duration_ = 15.2

		local var_149_0 = {
			zh = 9.233,
			ja = 15.2
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
				arg_149_0:Play317032038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1015ui_story = arg_149_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).z)
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles = arg_149_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_149_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1015ui_story"].transform.position).z)
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1015ui_story"].transform.localEulerAngles = arg_149_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1015ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1015ui_story == nil then
				arg_149_1.var_.characterEffect1015ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1015ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1015ui_story then
				arg_149_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_4 = arg_149_1.actors_["1093ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1093ui_story = var_152_4.localPosition
			end

			local var_152_5 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 then
				var_152_4.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_5)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 then
				var_152_4.localPosition = Vector3.New(0, 100, 0)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			local var_152_6 = 0
			local var_152_7 = 0.9

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(317032037)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 36 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 36)

				if (36 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 36)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032037", "story_v_out_317032.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_317032", "317032037", "story_v_out_317032.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_317032", "317032037", "story_v_out_317032.awb")

						arg_149_1:RecordAudio("317032037", var_152_13)
						arg_149_1:RecordAudio("317032037", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317032", "317032037", "story_v_out_317032.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317032", "317032037", "story_v_out_317032.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play317032038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317032038
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play317032039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos2078ui_story = arg_153_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).z)
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles = arg_153_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_153_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).z)
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles = arg_153_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["2078ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect2078ui_story == nil then
				arg_153_1.var_.characterEffect2078ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect2078ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect2078ui_story then
				arg_153_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = arg_153_1.actors_["2079ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos2079ui_story = var_156_4.localPosition
			end

			local var_156_5 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				var_156_4.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_153_1.time_ - 0) / var_156_5)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				var_156_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			local var_156_6 = arg_153_1.actors_["2079ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect2079ui_story == nil then
				arg_153_1.var_.characterEffect2079ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 and not isNil(var_156_6) then
				if arg_153_1.var_.characterEffect2079ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_153_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_7)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect2079ui_story then
				arg_153_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_153_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_156_8 = arg_153_1.actors_["1015ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1015ui_story = var_156_8.localPosition
			end

			local var_156_9 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_9 then
				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_9)
				var_156_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_8.position).x, (manager.ui.mainCamera.transform.position - var_156_8.position).y, (manager.ui.mainCamera.transform.position - var_156_8.position).z)
				var_156_8.localEulerAngles.z = 0
				var_156_8.localEulerAngles.x = 0
				var_156_8.localEulerAngles = var_156_8.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_9 and arg_153_1.time_ < 0 + var_156_9 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(0, 100, 0)
				var_156_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_8.position).x, (manager.ui.mainCamera.transform.position - var_156_8.position).y, (manager.ui.mainCamera.transform.position - var_156_8.position).z)
				var_156_8.localEulerAngles.z = 0
				var_156_8.localEulerAngles.x = 0
				var_156_8.localEulerAngles = var_156_8.localEulerAngles
			end

			local var_156_10 = 0
			local var_156_11 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_12 = arg_153_1:GetWordFromCfg(317032038)
				local var_156_13 = arg_153_1:FormatText(var_156_12.content)

				arg_153_1.text_.text = var_156_13

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 6 <= 0 and var_156_11 or var_156_11 * (utf8.len(var_156_13) / 6)

				if (6 <= 0 and var_156_11 or var_156_11 * (utf8.len(var_156_13) / 6)) > 0 and var_156_11 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_13
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032038", "story_v_out_317032.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_317032", "317032038", "story_v_out_317032.awb") / 1000

					if var_156_16 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_10
					end

					if var_156_12.prefab_name ~= "" and arg_153_1.actors_[var_156_12.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_12.prefab_name].transform, "story_v_out_317032", "317032038", "story_v_out_317032.awb")

						arg_153_1:RecordAudio("317032038", var_156_17)
						arg_153_1:RecordAudio("317032038", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_317032", "317032038", "story_v_out_317032.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_317032", "317032038", "story_v_out_317032.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_18 and arg_153_1.time_ < var_156_10 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play317032039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317032039
		arg_157_1.duration_ = 2.87

		local var_157_0 = {
			zh = 1.833,
			ja = 2.866
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
				arg_157_0:Play317032040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos2078ui_story = arg_157_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).z)
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles = arg_157_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_157_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["2078ui_story"].transform.position).z)
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["2078ui_story"].transform.localEulerAngles = arg_157_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["2078ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect2078ui_story == nil then
				arg_157_1.var_.characterEffect2078ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect2078ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect2078ui_story then
				arg_157_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = arg_157_1.actors_["2079ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos2079ui_story = var_160_4.localPosition
			end

			local var_160_5 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				var_160_4.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_157_1.time_ - 0) / var_160_5)
				var_160_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_4.position).x, (manager.ui.mainCamera.transform.position - var_160_4.position).y, (manager.ui.mainCamera.transform.position - var_160_4.position).z)
				var_160_4.localEulerAngles.z = 0
				var_160_4.localEulerAngles.x = 0
				var_160_4.localEulerAngles = var_160_4.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				var_160_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_160_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_4.position).x, (manager.ui.mainCamera.transform.position - var_160_4.position).y, (manager.ui.mainCamera.transform.position - var_160_4.position).z)
				var_160_4.localEulerAngles.z = 0
				var_160_4.localEulerAngles.x = 0
				var_160_4.localEulerAngles = var_160_4.localEulerAngles
			end

			local var_160_6 = arg_157_1.actors_["2079ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect2079ui_story == nil then
				arg_157_1.var_.characterEffect2079ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_7 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 and not isNil(var_160_6) then
				if arg_157_1.var_.characterEffect2079ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_157_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_7)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect2079ui_story then
				arg_157_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_157_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_160_8 = 0
			local var_160_9 = 0.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(317032039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 10 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 10)

				if (10 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 10)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032039", "story_v_out_317032.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032039", "story_v_out_317032.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_317032", "317032039", "story_v_out_317032.awb")

						arg_157_1:RecordAudio("317032039", var_160_15)
						arg_157_1:RecordAudio("317032039", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_317032", "317032039", "story_v_out_317032.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_317032", "317032039", "story_v_out_317032.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play317032040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 317032040
		arg_161_1.duration_ = 4.8

		local var_161_0 = {
			zh = 4.8,
			ja = 4.266
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
				arg_161_0:Play317032041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos2078ui_story = arg_161_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).z)
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles = arg_161_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_161_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).z)
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles = arg_161_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["2078ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect2078ui_story == nil then
				arg_161_1.var_.characterEffect2078ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect2078ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_161_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect2078ui_story then
				arg_161_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_161_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_164_3 = arg_161_1.actors_["2079ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos2079ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["2079ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect2079ui_story == nil then
				arg_161_1.var_.characterEffect2079ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect2079ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect2079ui_story then
				arg_161_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_8 = 0
			local var_164_9 = 0.475

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(317032040)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 19 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 19)

				if (19 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 19)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032040", "story_v_out_317032.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032040", "story_v_out_317032.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_317032", "317032040", "story_v_out_317032.awb")

						arg_161_1:RecordAudio("317032040", var_164_15)
						arg_161_1:RecordAudio("317032040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_317032", "317032040", "story_v_out_317032.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_317032", "317032040", "story_v_out_317032.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play317032041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 317032041
		arg_165_1.duration_ = 2.5

		local var_165_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play317032042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos2078ui_story = arg_165_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).z)
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles = arg_165_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["2078ui_story"].transform.position).z)
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["2078ui_story"].transform.localEulerAngles = arg_165_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["2078ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect2078ui_story == nil then
				arg_165_1.var_.characterEffect2078ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect2078ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_165_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect2078ui_story then
				arg_165_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_165_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_168_3 = arg_165_1.actors_["2079ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos2079ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(0, 100, 0)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["2079ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect2079ui_story == nil then
				arg_165_1.var_.characterEffect2079ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect2079ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_165_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_6)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect2079ui_story then
				arg_165_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_165_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_168_7 = arg_165_1.actors_["1015ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1015ui_story = var_168_7.localPosition
			end

			local var_168_8 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_8 then
				var_168_7.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_165_1.time_ - 0) / var_168_8)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_8 and arg_165_1.time_ < 0 + var_168_8 + arg_168_0 then
				var_168_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			local var_168_9 = arg_165_1.actors_["1015ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1015ui_story == nil then
				arg_165_1.var_.characterEffect1015ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_10 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_10 and not isNil(var_168_9) then
				if arg_165_1.var_.characterEffect1015ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_10 and arg_165_1.time_ < 0 + var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1015ui_story then
				arg_165_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_12 = 0
			local var_168_13 = 0.175

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_14 = arg_165_1:GetWordFromCfg(317032041)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 7 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 7)

				if (7 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 7)) > 0 and var_168_13 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032041", "story_v_out_317032.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032041", "story_v_out_317032.awb") / 1000

					if var_168_18 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_12
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_out_317032", "317032041", "story_v_out_317032.awb")

						arg_165_1:RecordAudio("317032041", var_168_19)
						arg_165_1:RecordAudio("317032041", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_317032", "317032041", "story_v_out_317032.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_317032", "317032041", "story_v_out_317032.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_20 and arg_165_1.time_ < var_168_12 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317032042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 317032042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play317032043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1015ui_story"]) and arg_169_1.var_.characterEffect1015ui_story == nil then
				arg_169_1.var_.characterEffect1015ui_story = arg_169_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1015ui_story"]) then
				if arg_169_1.var_.characterEffect1015ui_story and not isNil(arg_169_1.actors_["1015ui_story"]) then
					arg_169_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1015ui_story"]) and arg_169_1.var_.characterEffect1015ui_story then
				arg_169_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.175

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(317032042).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 7 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 7)

				if (7 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 7)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play317032043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 317032043
		arg_173_1.duration_ = 8.73

		local var_173_0 = {
			zh = 8.066,
			ja = 8.733
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
				arg_173_0:Play317032044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1015ui_story"]) and arg_173_1.var_.characterEffect1015ui_story == nil then
				arg_173_1.var_.characterEffect1015ui_story = arg_173_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1015ui_story"]) then
				if arg_173_1.var_.characterEffect1015ui_story and not isNil(arg_173_1.actors_["1015ui_story"]) then
					arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1015ui_story"]) and arg_173_1.var_.characterEffect1015ui_story then
				arg_173_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_176_2 = 0
			local var_176_3 = 1.025

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(317032043)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 41 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 41)

				if (41 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 41)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032043", "story_v_out_317032.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_317032", "317032043", "story_v_out_317032.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_317032", "317032043", "story_v_out_317032.awb")

						arg_173_1:RecordAudio("317032043", var_176_9)
						arg_173_1:RecordAudio("317032043", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_317032", "317032043", "story_v_out_317032.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_317032", "317032043", "story_v_out_317032.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play317032044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 317032044
		arg_177_1.duration_ = 11.57

		local var_177_0 = {
			zh = 11.566,
			ja = 10.566
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
				arg_177_0:Play317032045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.6

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(317032044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 64 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 64)

				if (64 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 64)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032044", "story_v_out_317032.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_317032", "317032044", "story_v_out_317032.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_317032", "317032044", "story_v_out_317032.awb")

						arg_177_1:RecordAudio("317032044", var_180_6)
						arg_177_1:RecordAudio("317032044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_317032", "317032044", "story_v_out_317032.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_317032", "317032044", "story_v_out_317032.awb")
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
	Play317032045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 317032045
		arg_181_1.duration_ = 6.77

		local var_181_0 = {
			zh = 4.766,
			ja = 6.766
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
				arg_181_0:Play317032046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.6

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(317032045)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 24 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 24)

				if (24 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 24)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032045", "story_v_out_317032.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_317032", "317032045", "story_v_out_317032.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_317032", "317032045", "story_v_out_317032.awb")

						arg_181_1:RecordAudio("317032045", var_184_6)
						arg_181_1:RecordAudio("317032045", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_317032", "317032045", "story_v_out_317032.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_317032", "317032045", "story_v_out_317032.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play317032046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317032046
		arg_185_1.duration_ = 0.5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				SetActive(iter_186_1.go, iter_186_0 <= 1)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[524].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play317032047(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(317032046, 524)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) and arg_185_1.var_.characterEffect1015ui_story == nil then
				arg_185_1.var_.characterEffect1015ui_story = arg_185_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) then
				if arg_185_1.var_.characterEffect1015ui_story and not isNil(arg_185_1.actors_["1015ui_story"]) then
					arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1015ui_story"]) and arg_185_1.var_.characterEffect1015ui_story then
				arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_1 + 0.5 and arg_185_1.time_ < var_188_1 + 0.5 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play317032047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 317032047
		arg_189_1.duration_ = 14.5

		local var_189_0 = {
			zh = 14.5,
			ja = 10.5
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play317032048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1015ui_story"]) and arg_189_1.var_.characterEffect1015ui_story == nil then
				arg_189_1.var_.characterEffect1015ui_story = arg_189_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1015ui_story"]) then
				if arg_189_1.var_.characterEffect1015ui_story and not isNil(arg_189_1.actors_["1015ui_story"]) then
					arg_189_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1015ui_story"]) and arg_189_1.var_.characterEffect1015ui_story then
				arg_189_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_192_2 = 0
			local var_192_3 = 1.875

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(317032047)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 75 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 75)

				if (75 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 75)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032047", "story_v_out_317032.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_317032", "317032047", "story_v_out_317032.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_out_317032", "317032047", "story_v_out_317032.awb")

						arg_189_1:RecordAudio("317032047", var_192_9)
						arg_189_1:RecordAudio("317032047", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_317032", "317032047", "story_v_out_317032.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_317032", "317032047", "story_v_out_317032.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play317032048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 317032048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play317032049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1015ui_story"]) and arg_193_1.var_.characterEffect1015ui_story == nil then
				arg_193_1.var_.characterEffect1015ui_story = arg_193_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1015ui_story"]) then
				if arg_193_1.var_.characterEffect1015ui_story and not isNil(arg_193_1.actors_["1015ui_story"]) then
					arg_193_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1015ui_story"]) and arg_193_1.var_.characterEffect1015ui_story then
				arg_193_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.6

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(317032048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 24 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 24)

				if (24 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 24)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play317032049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 317032049
		arg_197_1.duration_ = 6.17

		local var_197_0 = {
			zh = 4.966,
			ja = 6.166
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play317032050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1015ui_story = arg_197_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).z)
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles = arg_197_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_197_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1015ui_story"].transform.position).z)
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1015ui_story"].transform.localEulerAngles = arg_197_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1015ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1015ui_story == nil then
				arg_197_1.var_.characterEffect1015ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1015ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_2)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1015ui_story then
				arg_197_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_200_3 = arg_197_1.actors_["2078ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos2078ui_story = var_200_3.localPosition
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_3.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_197_1.time_ - 0) / var_200_4)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			local var_200_5 = arg_197_1.actors_["2078ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect2078ui_story == nil then
				arg_197_1.var_.characterEffect2078ui_story = var_200_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.characterEffect2078ui_story and not isNil(var_200_5) then
					arg_197_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect2078ui_story then
				arg_197_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_8 = 0
			local var_200_9 = 0.6

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(317032049)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 24 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 24)

				if (24 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 24)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032049", "story_v_out_317032.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032049", "story_v_out_317032.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_317032", "317032049", "story_v_out_317032.awb")

						arg_197_1:RecordAudio("317032049", var_200_15)
						arg_197_1:RecordAudio("317032049", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_317032", "317032049", "story_v_out_317032.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_317032", "317032049", "story_v_out_317032.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_197_1:InitPlayNodeList()
	end,
	Play317032050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 317032050
		arg_201_1.duration_ = 8.17

		local var_201_0 = {
			zh = 8.166,
			ja = 7.8
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
				arg_201_0:Play317032051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1015ui_story = arg_201_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).z)
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles = arg_201_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_201_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).z)
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles = arg_201_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1015ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1015ui_story == nil then
				arg_201_1.var_.characterEffect1015ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1015ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1015ui_story then
				arg_201_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_4 = arg_201_1.actors_["2078ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos2078ui_story = var_204_4.localPosition
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_4.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_201_1.time_ - 0) / var_204_5)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			local var_204_6 = arg_201_1.actors_["2078ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect2078ui_story == nil then
				arg_201_1.var_.characterEffect2078ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_7 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 and not isNil(var_204_6) then
				if arg_201_1.var_.characterEffect2078ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_201_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_7)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect2078ui_story then
				arg_201_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_201_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_204_8 = 0
			local var_204_9 = 0.975

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(317032050)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 39 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 39)

				if (39 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 39)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032050", "story_v_out_317032.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032050", "story_v_out_317032.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_317032", "317032050", "story_v_out_317032.awb")

						arg_201_1:RecordAudio("317032050", var_204_15)
						arg_201_1:RecordAudio("317032050", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_317032", "317032050", "story_v_out_317032.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_317032", "317032050", "story_v_out_317032.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_201_1:InitPlayNodeList()
	end,
	Play317032051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 317032051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play317032052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1015ui_story"]) and arg_205_1.var_.characterEffect1015ui_story == nil then
				arg_205_1.var_.characterEffect1015ui_story = arg_205_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1015ui_story"]) then
				if arg_205_1.var_.characterEffect1015ui_story and not isNil(arg_205_1.actors_["1015ui_story"]) then
					arg_205_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1015ui_story"]) and arg_205_1.var_.characterEffect1015ui_story then
				arg_205_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.225

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(317032051).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 9 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 9)

				if (9 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 9)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play317032052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 317032052
		arg_209_1.duration_ = 2.53

		local var_209_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play317032053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1015ui_story = arg_209_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).z)
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles = arg_209_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_209_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).z)
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles = arg_209_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["2078ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos2078ui_story = var_212_1.localPosition
			end

			local var_212_2 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 then
				var_212_1.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_209_1.time_ - 0) / var_212_2)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 then
				var_212_1.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			local var_212_3 = arg_209_1.actors_["2078ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect2078ui_story == nil then
				arg_209_1.var_.characterEffect2078ui_story = var_212_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_4 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 and not isNil(var_212_3) then
				if arg_209_1.var_.characterEffect2078ui_story and not isNil(var_212_3) then
					arg_209_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect2078ui_story then
				arg_209_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_6 = 0
			local var_212_7 = 0.2

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(317032052)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 8 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 8)

				if (8 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 8)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032052", "story_v_out_317032.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_317032", "317032052", "story_v_out_317032.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_317032", "317032052", "story_v_out_317032.awb")

						arg_209_1:RecordAudio("317032052", var_212_13)
						arg_209_1:RecordAudio("317032052", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_317032", "317032052", "story_v_out_317032.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_317032", "317032052", "story_v_out_317032.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play317032053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 317032053
		arg_213_1.duration_ = 6.23

		local var_213_0 = {
			zh = 6.066,
			ja = 6.233
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play317032054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1015ui_story = arg_213_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).z)
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles = arg_213_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_213_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1015ui_story"].transform.position).z)
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1015ui_story"].transform.localEulerAngles = arg_213_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1015ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1015ui_story == nil then
				arg_213_1.var_.characterEffect1015ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1015ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1015ui_story then
				arg_213_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_4 = arg_213_1.actors_["2078ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos2078ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			local var_216_6 = arg_213_1.actors_["2078ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect2078ui_story == nil then
				arg_213_1.var_.characterEffect2078ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect2078ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_213_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect2078ui_story then
				arg_213_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_213_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_216_8 = 0
			local var_216_9 = 0.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(317032053)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 28 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 28)

				if (28 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 28)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032053", "story_v_out_317032.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032053", "story_v_out_317032.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_317032", "317032053", "story_v_out_317032.awb")

						arg_213_1:RecordAudio("317032053", var_216_15)
						arg_213_1:RecordAudio("317032053", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_317032", "317032053", "story_v_out_317032.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_317032", "317032053", "story_v_out_317032.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_213_1:InitPlayNodeList()
	end,
	Play317032054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 317032054
		arg_217_1.duration_ = 5.43

		local var_217_0 = {
			zh = 5.433,
			ja = 4.366
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
				arg_217_0:Play317032055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1015ui_story = arg_217_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).z)
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles = arg_217_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_217_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1015ui_story"].transform.position).z)
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1015ui_story"].transform.localEulerAngles = arg_217_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1015ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1015ui_story == nil then
				arg_217_1.var_.characterEffect1015ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1015ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1015ui_story then
				arg_217_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_220_3 = arg_217_1.actors_["2078ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos2078ui_story = var_220_3.localPosition
			end

			local var_220_4 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				var_220_3.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_217_1.time_ - 0) / var_220_4)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				var_220_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles
			end

			local var_220_5 = arg_217_1.actors_["2078ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.characterEffect2078ui_story == nil then
				arg_217_1.var_.characterEffect2078ui_story = var_220_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_6 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_6 and not isNil(var_220_5) then
				if arg_217_1.var_.characterEffect2078ui_story and not isNil(var_220_5) then
					arg_217_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_6 and arg_217_1.time_ < 0 + var_220_6 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.characterEffect2078ui_story then
				arg_217_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_8 = 0
			local var_220_9 = 0.55

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(317032054)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 22 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 22)

				if (22 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 22)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032054", "story_v_out_317032.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032054", "story_v_out_317032.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_317032", "317032054", "story_v_out_317032.awb")

						arg_217_1:RecordAudio("317032054", var_220_15)
						arg_217_1:RecordAudio("317032054", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_317032", "317032054", "story_v_out_317032.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_317032", "317032054", "story_v_out_317032.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_217_1:InitPlayNodeList()
	end,
	Play317032055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 317032055
		arg_221_1.duration_ = 1.67

		local var_221_0 = {
			zh = 1.3,
			ja = 1.666
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play317032056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1015ui_story = arg_221_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).z)
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles = arg_221_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_221_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1015ui_story"].transform.position).z)
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1015ui_story"].transform.localEulerAngles = arg_221_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1015ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1015ui_story == nil then
				arg_221_1.var_.characterEffect1015ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1015ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1015ui_story then
				arg_221_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_224_3 = arg_221_1.actors_["2078ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos2078ui_story = var_224_3.localPosition
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_3.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_221_1.time_ - 0) / var_224_4)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			local var_224_5 = arg_221_1.actors_["2078ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect2078ui_story == nil then
				arg_221_1.var_.characterEffect2078ui_story = var_224_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.characterEffect2078ui_story and not isNil(var_224_5) then
					arg_221_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect2078ui_story then
				arg_221_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_8 = 0
			local var_224_9 = 0.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(317032055)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 4 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 4)

				if (4 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 4)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032055", "story_v_out_317032.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032055", "story_v_out_317032.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_317032", "317032055", "story_v_out_317032.awb")

						arg_221_1:RecordAudio("317032055", var_224_15)
						arg_221_1:RecordAudio("317032055", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_317032", "317032055", "story_v_out_317032.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_317032", "317032055", "story_v_out_317032.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_221_1:InitPlayNodeList()
	end,
	Play317032056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 317032056
		arg_225_1.duration_ = 12.8

		local var_225_0 = {
			zh = 8.466,
			ja = 12.8
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
				arg_225_0:Play317032057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1015ui_story = arg_225_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).z)
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles = arg_225_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1015ui_story"].transform.position).z)
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1015ui_story"].transform.localEulerAngles = arg_225_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1015ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1015ui_story == nil then
				arg_225_1.var_.characterEffect1015ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1015ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_2)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1015ui_story then
				arg_225_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_228_3 = arg_225_1.actors_["2078ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos2078ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, 100, 0)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["2078ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect2078ui_story == nil then
				arg_225_1.var_.characterEffect2078ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect2078ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_225_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_6)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect2078ui_story then
				arg_225_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_225_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_228_7 = arg_225_1.actors_["2079ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos2079ui_story = var_228_7.localPosition
			end

			local var_228_8 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_8 then
				var_228_7.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_225_1.time_ - 0) / var_228_8)
				var_228_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_7.position).x, (manager.ui.mainCamera.transform.position - var_228_7.position).y, (manager.ui.mainCamera.transform.position - var_228_7.position).z)
				var_228_7.localEulerAngles.z = 0
				var_228_7.localEulerAngles.x = 0
				var_228_7.localEulerAngles = var_228_7.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_8 and arg_225_1.time_ < 0 + var_228_8 + arg_228_0 then
				var_228_7.localPosition = Vector3.New(0, -1.28, -5.6)
				var_228_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_7.position).x, (manager.ui.mainCamera.transform.position - var_228_7.position).y, (manager.ui.mainCamera.transform.position - var_228_7.position).z)
				var_228_7.localEulerAngles.z = 0
				var_228_7.localEulerAngles.x = 0
				var_228_7.localEulerAngles = var_228_7.localEulerAngles
			end

			local var_228_9 = arg_225_1.actors_["2079ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect2079ui_story == nil then
				arg_225_1.var_.characterEffect2079ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_10 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_10 and not isNil(var_228_9) then
				if arg_225_1.var_.characterEffect2079ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_10 and arg_225_1.time_ < 0 + var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect2079ui_story then
				arg_225_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_12 = 0
			local var_228_13 = 1.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_14 = arg_225_1:GetWordFromCfg(317032056)
				local var_228_15 = arg_225_1:FormatText(var_228_14.content)

				arg_225_1.text_.text = var_228_15

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_17 = 51 <= 0 and var_228_13 or var_228_13 * (utf8.len(var_228_15) / 51)

				if (51 <= 0 and var_228_13 or var_228_13 * (utf8.len(var_228_15) / 51)) > 0 and var_228_13 < var_228_17 then
					arg_225_1.talkMaxDuration = var_228_17

					if var_228_17 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_17 + var_228_12
					end
				end

				arg_225_1.text_.text = var_228_15
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032056", "story_v_out_317032.awb") ~= 0 then
					local var_228_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032056", "story_v_out_317032.awb") / 1000

					if var_228_18 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_12
					end

					if var_228_14.prefab_name ~= "" and arg_225_1.actors_[var_228_14.prefab_name] ~= nil then
						local var_228_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_14.prefab_name].transform, "story_v_out_317032", "317032056", "story_v_out_317032.awb")

						arg_225_1:RecordAudio("317032056", var_228_19)
						arg_225_1:RecordAudio("317032056", var_228_19)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_317032", "317032056", "story_v_out_317032.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_317032", "317032056", "story_v_out_317032.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_20 = math.max(var_228_13, arg_225_1.talkMaxDuration)

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_20 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_12) / var_228_20

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_12 + var_228_20 and arg_225_1.time_ < var_228_12 + var_228_20 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_225_1:InitPlayNodeList()
	end,
	Play317032057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 317032057
		arg_229_1.duration_ = 13.83

		local var_229_0 = {
			zh = 13.833,
			ja = 11.6
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
				arg_229_0:Play317032058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1015ui_story = arg_229_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).z)
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles = arg_229_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_229_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1015ui_story"].transform.position).z)
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1015ui_story"].transform.localEulerAngles = arg_229_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1015ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1015ui_story == nil then
				arg_229_1.var_.characterEffect1015ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1015ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_2)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1015ui_story then
				arg_229_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_232_3 = arg_229_1.actors_["2078ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos2078ui_story = var_232_3.localPosition
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_229_1.time_ - 0) / var_232_4)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			local var_232_5 = arg_229_1.actors_["2078ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect2078ui_story == nil then
				arg_229_1.var_.characterEffect2078ui_story = var_232_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.characterEffect2078ui_story and not isNil(var_232_5) then
					arg_229_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect2078ui_story then
				arg_229_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_8 = arg_229_1.actors_["2079ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos2079ui_story = var_232_8.localPosition
			end

			local var_232_9 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_9 then
				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_9)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_9 and arg_229_1.time_ < 0 + var_232_9 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(0, 100, 0)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			local var_232_10 = arg_229_1.actors_["2079ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect2079ui_story == nil then
				arg_229_1.var_.characterEffect2079ui_story = var_232_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_11 and not isNil(var_232_10) then
				if arg_229_1.var_.characterEffect2079ui_story and not isNil(var_232_10) then
					arg_229_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_229_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_11)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_11 and arg_229_1.time_ < 0 + var_232_11 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect2079ui_story then
				arg_229_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_229_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_232_12 = 0
			local var_232_13 = 1.775

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(317032057)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 67 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 67)

				if (67 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 67)) > 0 and var_232_13 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032057", "story_v_out_317032.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032057", "story_v_out_317032.awb") / 1000

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_out_317032", "317032057", "story_v_out_317032.awb")

						arg_229_1:RecordAudio("317032057", var_232_19)
						arg_229_1:RecordAudio("317032057", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_317032", "317032057", "story_v_out_317032.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_317032", "317032057", "story_v_out_317032.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_20 and arg_229_1.time_ < var_232_12 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_229_1:InitPlayNodeList()
	end,
	Play317032058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 317032058
		arg_233_1.duration_ = 5.4

		local var_233_0 = {
			zh = 4.6,
			ja = 5.4
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
				arg_233_0:Play317032059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1015ui_story = arg_233_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).z)
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles = arg_233_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_233_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).z)
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles = arg_233_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1015ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1015ui_story == nil then
				arg_233_1.var_.characterEffect1015ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1015ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1015ui_story then
				arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = arg_233_1.actors_["2078ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos2078ui_story = var_236_4.localPosition
			end

			local var_236_5 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 then
				var_236_4.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_233_1.time_ - 0) / var_236_5)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 then
				var_236_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			local var_236_6 = arg_233_1.actors_["2078ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect2078ui_story == nil then
				arg_233_1.var_.characterEffect2078ui_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_7 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 and not isNil(var_236_6) then
				if arg_233_1.var_.characterEffect2078ui_story and not isNil(var_236_6) then
					arg_233_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_233_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_7)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect2078ui_story then
				arg_233_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_233_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_236_8 = 0
			local var_236_9 = 0.625

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(317032058)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 25 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 25)

				if (25 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 25)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032058", "story_v_out_317032.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032058", "story_v_out_317032.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_317032", "317032058", "story_v_out_317032.awb")

						arg_233_1:RecordAudio("317032058", var_236_15)
						arg_233_1:RecordAudio("317032058", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_317032", "317032058", "story_v_out_317032.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_317032", "317032058", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play317032059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 317032059
		arg_237_1.duration_ = 15.27

		local var_237_0 = {
			zh = 11.566,
			ja = 15.266
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
				arg_237_0:Play317032060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1015ui_story = arg_237_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).z)
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles = arg_237_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_237_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1015ui_story"].transform.position).z)
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1015ui_story"].transform.localEulerAngles = arg_237_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1015ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1015ui_story == nil then
				arg_237_1.var_.characterEffect1015ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1015ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1015ui_story then
				arg_237_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_240_4 = arg_237_1.actors_["2078ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos2078ui_story = var_240_4.localPosition
			end

			local var_240_5 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 then
				var_240_4.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_237_1.time_ - 0) / var_240_5)
				var_240_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_4.position).x, (manager.ui.mainCamera.transform.position - var_240_4.position).y, (manager.ui.mainCamera.transform.position - var_240_4.position).z)
				var_240_4.localEulerAngles.z = 0
				var_240_4.localEulerAngles.x = 0
				var_240_4.localEulerAngles = var_240_4.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 then
				var_240_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_240_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_4.position).x, (manager.ui.mainCamera.transform.position - var_240_4.position).y, (manager.ui.mainCamera.transform.position - var_240_4.position).z)
				var_240_4.localEulerAngles.z = 0
				var_240_4.localEulerAngles.x = 0
				var_240_4.localEulerAngles = var_240_4.localEulerAngles
			end

			local var_240_6 = arg_237_1.actors_["2078ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect2078ui_story == nil then
				arg_237_1.var_.characterEffect2078ui_story = var_240_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_7 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 and not isNil(var_240_6) then
				if arg_237_1.var_.characterEffect2078ui_story and not isNil(var_240_6) then
					arg_237_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_237_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_7)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect2078ui_story then
				arg_237_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_237_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_240_8 = 0
			local var_240_9 = 1.375

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(317032059)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 55 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 55)

				if (55 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 55)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032059", "story_v_out_317032.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032059", "story_v_out_317032.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_317032", "317032059", "story_v_out_317032.awb")

						arg_237_1:RecordAudio("317032059", var_240_15)
						arg_237_1:RecordAudio("317032059", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_317032", "317032059", "story_v_out_317032.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_317032", "317032059", "story_v_out_317032.awb")
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
				actorName = "1015ui_story",
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

		arg_237_1:InitPlayNodeList()
	end,
	Play317032060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 317032060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play317032061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1015ui_story"]) and arg_241_1.var_.characterEffect1015ui_story == nil then
				arg_241_1.var_.characterEffect1015ui_story = arg_241_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1015ui_story"]) then
				if arg_241_1.var_.characterEffect1015ui_story and not isNil(arg_241_1.actors_["1015ui_story"]) then
					arg_241_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1015ui_story"]) and arg_241_1.var_.characterEffect1015ui_story then
				arg_241_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.625

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(317032060).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 25 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 25)

				if (25 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 25)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play317032061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 317032061
		arg_245_1.duration_ = 6.03

		local var_245_0 = {
			zh = 5.133,
			ja = 6.033
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play317032062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1015ui_story = arg_245_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).z)
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles = arg_245_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_245_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).z)
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles = arg_245_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1015ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1015ui_story == nil then
				arg_245_1.var_.characterEffect1015ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1015ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_2)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1015ui_story then
				arg_245_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_248_3 = arg_245_1.actors_["2078ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos2078ui_story = var_248_3.localPosition
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_245_1.time_ - 0) / var_248_4)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			local var_248_5 = arg_245_1.actors_["2078ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect2078ui_story == nil then
				arg_245_1.var_.characterEffect2078ui_story = var_248_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.characterEffect2078ui_story and not isNil(var_248_5) then
					arg_245_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect2078ui_story then
				arg_245_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_8 = 0
			local var_248_9 = 0.55

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:GetWordFromCfg(317032061)
				local var_248_11 = arg_245_1:FormatText(var_248_10.content)

				arg_245_1.text_.text = var_248_11

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 22 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 22)

				if (22 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 22)) > 0 and var_248_9 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_11
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032061", "story_v_out_317032.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032061", "story_v_out_317032.awb") / 1000

					if var_248_14 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_8
					end

					if var_248_10.prefab_name ~= "" and arg_245_1.actors_[var_248_10.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_10.prefab_name].transform, "story_v_out_317032", "317032061", "story_v_out_317032.awb")

						arg_245_1:RecordAudio("317032061", var_248_15)
						arg_245_1:RecordAudio("317032061", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_317032", "317032061", "story_v_out_317032.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_317032", "317032061", "story_v_out_317032.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_16 and arg_245_1.time_ < var_248_8 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_245_1:InitPlayNodeList()
	end,
	Play317032062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 317032062
		arg_249_1.duration_ = 13.5

		local var_249_0 = {
			zh = 13.5,
			ja = 11.333
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play317032063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.7

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(317032062)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 68 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 68)

				if (68 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 68)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032062", "story_v_out_317032.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_317032", "317032062", "story_v_out_317032.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_317032", "317032062", "story_v_out_317032.awb")

						arg_249_1:RecordAudio("317032062", var_252_6)
						arg_249_1:RecordAudio("317032062", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_317032", "317032062", "story_v_out_317032.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_317032", "317032062", "story_v_out_317032.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play317032063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 317032063
		arg_253_1.duration_ = 8.6

		local var_253_0 = {
			zh = 6.933,
			ja = 8.6
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play317032064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1015ui_story = arg_253_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).z)
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles = arg_253_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_253_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1015ui_story"].transform.position).z)
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1015ui_story"].transform.localEulerAngles = arg_253_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1015ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1015ui_story == nil then
				arg_253_1.var_.characterEffect1015ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1015ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1015ui_story then
				arg_253_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_4 = arg_253_1.actors_["2078ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos2078ui_story = var_256_4.localPosition
			end

			local var_256_5 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 then
				var_256_4.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_253_1.time_ - 0) / var_256_5)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 then
				var_256_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			local var_256_6 = arg_253_1.actors_["2078ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect2078ui_story == nil then
				arg_253_1.var_.characterEffect2078ui_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_7 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 and not isNil(var_256_6) then
				if arg_253_1.var_.characterEffect2078ui_story and not isNil(var_256_6) then
					arg_253_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_253_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_7)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect2078ui_story then
				arg_253_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_253_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_256_8 = 0
			local var_256_9 = 0.95

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(317032063)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 38 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 38)

				if (38 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 38)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032063", "story_v_out_317032.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032063", "story_v_out_317032.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_317032", "317032063", "story_v_out_317032.awb")

						arg_253_1:RecordAudio("317032063", var_256_15)
						arg_253_1:RecordAudio("317032063", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_317032", "317032063", "story_v_out_317032.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_317032", "317032063", "story_v_out_317032.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_253_1:InitPlayNodeList()
	end,
	Play317032064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 317032064
		arg_257_1.duration_ = 4.63

		local var_257_0 = {
			zh = 4.633,
			ja = 3.566
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play317032065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1015ui_story = arg_257_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).z)
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles = arg_257_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_257_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1015ui_story"].transform.position).z)
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1015ui_story"].transform.localEulerAngles = arg_257_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1015ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1015ui_story == nil then
				arg_257_1.var_.characterEffect1015ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1015ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_2)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1015ui_story then
				arg_257_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_260_3 = arg_257_1.actors_["2078ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos2078ui_story = var_260_3.localPosition
			end

			local var_260_4 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				var_260_3.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_257_1.time_ - 0) / var_260_4)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				var_260_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			local var_260_5 = arg_257_1.actors_["2078ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect2078ui_story == nil then
				arg_257_1.var_.characterEffect2078ui_story = var_260_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.characterEffect2078ui_story and not isNil(var_260_5) then
					arg_257_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect2078ui_story then
				arg_257_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_260_8 = 0
			local var_260_9 = 0.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(317032064)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 15 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 15)

				if (15 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 15)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032064", "story_v_out_317032.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032064", "story_v_out_317032.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_317032", "317032064", "story_v_out_317032.awb")

						arg_257_1:RecordAudio("317032064", var_260_15)
						arg_257_1:RecordAudio("317032064", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_317032", "317032064", "story_v_out_317032.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_317032", "317032064", "story_v_out_317032.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_257_1:InitPlayNodeList()
	end,
	Play317032065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 317032065
		arg_261_1.duration_ = 3.3

		local var_261_0 = {
			zh = 2.1,
			ja = 3.3
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play317032066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1015ui_story = arg_261_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).z)
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles = arg_261_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1015ui_story"].transform.position).z)
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1015ui_story"].transform.localEulerAngles = arg_261_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1015ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1015ui_story == nil then
				arg_261_1.var_.characterEffect1015ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1015ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_2)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1015ui_story then
				arg_261_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_264_3 = arg_261_1.actors_["2078ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos2078ui_story = var_264_3.localPosition
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_3.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_4)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_3.localPosition = Vector3.New(0, 100, 0)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			local var_264_5 = arg_261_1.actors_["2078ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect2078ui_story == nil then
				arg_261_1.var_.characterEffect2078ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.characterEffect2078ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_261_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_6)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect2078ui_story then
				arg_261_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_261_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_264_7 = arg_261_1.actors_["1093ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1093ui_story = var_264_7.localPosition
			end

			local var_264_8 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_8 then
				var_264_7.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_261_1.time_ - 0) / var_264_8)
				var_264_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_7.position).x, (manager.ui.mainCamera.transform.position - var_264_7.position).y, (manager.ui.mainCamera.transform.position - var_264_7.position).z)
				var_264_7.localEulerAngles.z = 0
				var_264_7.localEulerAngles.x = 0
				var_264_7.localEulerAngles = var_264_7.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_8 and arg_261_1.time_ < 0 + var_264_8 + arg_264_0 then
				var_264_7.localPosition = Vector3.New(0, -1.11, -5.88)
				var_264_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_7.position).x, (manager.ui.mainCamera.transform.position - var_264_7.position).y, (manager.ui.mainCamera.transform.position - var_264_7.position).z)
				var_264_7.localEulerAngles.z = 0
				var_264_7.localEulerAngles.x = 0
				var_264_7.localEulerAngles = var_264_7.localEulerAngles
			end

			local var_264_9 = arg_261_1.actors_["1093ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1093ui_story == nil then
				arg_261_1.var_.characterEffect1093ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_10 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_10 and not isNil(var_264_9) then
				if arg_261_1.var_.characterEffect1093ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_10 and arg_261_1.time_ < 0 + var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1093ui_story then
				arg_261_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_12 = 0
			local var_264_13 = 0.25

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_14 = arg_261_1:GetWordFromCfg(317032065)
				local var_264_15 = arg_261_1:FormatText(var_264_14.content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 10 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 10)

				if (10 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 10)) > 0 and var_264_13 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032065", "story_v_out_317032.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032065", "story_v_out_317032.awb") / 1000

					if var_264_18 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_12
					end

					if var_264_14.prefab_name ~= "" and arg_261_1.actors_[var_264_14.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_14.prefab_name].transform, "story_v_out_317032", "317032065", "story_v_out_317032.awb")

						arg_261_1:RecordAudio("317032065", var_264_19)
						arg_261_1:RecordAudio("317032065", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_317032", "317032065", "story_v_out_317032.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_317032", "317032065", "story_v_out_317032.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_20 and arg_261_1.time_ < var_264_12 + var_264_20 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play317032066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 317032066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play317032067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1093ui_story"]) and arg_265_1.var_.characterEffect1093ui_story == nil then
				arg_265_1.var_.characterEffect1093ui_story = arg_265_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1093ui_story"]) then
				if arg_265_1.var_.characterEffect1093ui_story and not isNil(arg_265_1.actors_["1093ui_story"]) then
					arg_265_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1093ui_story"]) and arg_265_1.var_.characterEffect1093ui_story then
				arg_265_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 1.35

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(317032066).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 54 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 54)

				if (54 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 54)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play317032067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 317032067
		arg_269_1.duration_ = 1

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play317032068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0
				arg_269_1.fswt_.text = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(317032067).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_0 = 0.033

			if 0.033 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_1 = 10
			local var_272_2 = 0.666666666666667
			local var_272_3, var_272_4 = arg_269_1:GetPercentByPara(arg_269_1:FormatText(arg_269_1:GetWordFromCfg(317032067).content), 1)

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_5 = var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)

				if (var_272_1 <= 0 and var_272_2 or var_272_2 * ((var_272_4 - arg_269_1.typewritterCharCountI18N) / var_272_1)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end
			end

			local var_272_6 = math.max(0.666666666666667, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_6 then
				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_3, (arg_269_1.time_ - var_272_0) / var_272_6)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_6 and arg_269_1.time_ < var_272_0 + var_272_6 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_3

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_4
			end

			local var_272_7 = 0
			local var_272_8 = manager.audio:GetVoiceLength("story_v_out_317032", "317032067", "story_v_out_317032.awb") / 1000

			if var_272_8 > 0 and 1 < var_272_8 and var_272_8 + var_272_7 > arg_269_1.duration_ then
				arg_269_1.duration_ = var_272_8 + var_272_7
			end

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 then
				arg_269_1:AudioAction("play", "voice", "story_v_out_317032", "317032067", "story_v_out_317032.awb")
			end

			local var_272_10 = arg_269_1.actors_["1093ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1093ui_story = var_272_10.localPosition
			end

			local var_272_11 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_11 then
				var_272_10.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_11)
				var_272_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_10.position).x, (manager.ui.mainCamera.transform.position - var_272_10.position).y, (manager.ui.mainCamera.transform.position - var_272_10.position).z)
				var_272_10.localEulerAngles.z = 0
				var_272_10.localEulerAngles.x = 0
				var_272_10.localEulerAngles = var_272_10.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_11 and arg_269_1.time_ < 0 + var_272_11 + arg_272_0 then
				var_272_10.localPosition = Vector3.New(0, 100, 0)
				var_272_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_10.position).x, (manager.ui.mainCamera.transform.position - var_272_10.position).y, (manager.ui.mainCamera.transform.position - var_272_10.position).z)
				var_272_10.localEulerAngles.z = 0
				var_272_10.localEulerAngles.x = 0
				var_272_10.localEulerAngles = var_272_10.localEulerAngles
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play317032068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 317032068
		arg_273_1.duration_ = 1

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play317032069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.oldValueTypewriter = arg_273_1.fswtw_.percent

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_0 = 10
			local var_276_1 = 0.666666666666667
			local var_276_2, var_276_3 = arg_273_1:GetPercentByPara(arg_273_1:FormatText(arg_273_1:GetWordFromCfg(317032067).content), 2)

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				local var_276_4 = var_276_0 <= 0 and var_276_1 or var_276_1 * ((var_276_3 - arg_273_1.typewritterCharCountI18N) / var_276_0)

				if (var_276_0 <= 0 and var_276_1 or var_276_1 * ((var_276_3 - arg_273_1.typewritterCharCountI18N) / var_276_0)) > 0 and var_276_1 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end
			end

			local var_276_5 = math.max(0.666666666666667, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				arg_273_1.fswtw_.percent = Mathf.Lerp(arg_273_1.var_.oldValueTypewriter, var_276_2, (arg_273_1.time_ - 0) / var_276_5)
				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_273_1.fswtw_:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				arg_273_1.fswtw_.percent = var_276_2

				arg_273_1.fswtw_:SetDirty()
				arg_273_1:ShowNextGo(true)

				arg_273_1.typewritterCharCountI18N = var_276_3
			end

			local var_276_6 = 0
			local var_276_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032068", "story_v_out_317032.awb") / 1000

			if var_276_7 > 0 and 1 < var_276_7 and var_276_7 + var_276_6 > arg_273_1.duration_ then
				arg_273_1.duration_ = var_276_7 + var_276_6
			end

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1:AudioAction("play", "voice", "story_v_out_317032", "317032068", "story_v_out_317032.awb")
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play317032069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 317032069
		arg_277_1.duration_ = 1.13

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play317032070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.oldValueTypewriter = arg_277_1.fswtw_.percent

				SetActive(arg_277_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_277_1:ShowNextGo(false)
			end

			local var_280_0 = 17
			local var_280_1 = 1.13333333333333
			local var_280_2, var_280_3 = arg_277_1:GetPercentByPara(arg_277_1:FormatText(arg_277_1:GetWordFromCfg(317032067).content), 3)

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				local var_280_4 = var_280_0 <= 0 and var_280_1 or var_280_1 * ((var_280_3 - arg_277_1.typewritterCharCountI18N) / var_280_0)

				if (var_280_0 <= 0 and var_280_1 or var_280_1 * ((var_280_3 - arg_277_1.typewritterCharCountI18N) / var_280_0)) > 0 and var_280_1 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end
			end

			local var_280_5 = math.max(1.13333333333333, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 then
				arg_277_1.fswtw_.percent = Mathf.Lerp(arg_277_1.var_.oldValueTypewriter, var_280_2, (arg_277_1.time_ - 0) / var_280_5)
				arg_277_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_277_1.fswtw_:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 then
				arg_277_1.fswtw_.percent = var_280_2

				arg_277_1.fswtw_:SetDirty()
				arg_277_1:ShowNextGo(true)

				arg_277_1.typewritterCharCountI18N = var_280_3
			end

			local var_280_6 = 0
			local var_280_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032069", "story_v_out_317032.awb") / 1000

			if var_280_7 > 0 and 1 < var_280_7 and var_280_7 + var_280_6 > arg_277_1.duration_ then
				arg_277_1.duration_ = var_280_7 + var_280_6
			end

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1:AudioAction("play", "voice", "story_v_out_317032", "317032069", "story_v_out_317032.awb")
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play317032070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 317032070
		arg_281_1.duration_ = 1.93

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play317032071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.oldValueTypewriter = arg_281_1.fswtw_.percent

				SetActive(arg_281_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_281_1:ShowNextGo(false)
			end

			local var_284_0 = 29
			local var_284_1 = 1.93333333333333
			local var_284_2, var_284_3 = arg_281_1:GetPercentByPara(arg_281_1:FormatText(arg_281_1:GetWordFromCfg(317032067).content), 4)

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				local var_284_4 = var_284_0 <= 0 and var_284_1 or var_284_1 * ((var_284_3 - arg_281_1.typewritterCharCountI18N) / var_284_0)

				if (var_284_0 <= 0 and var_284_1 or var_284_1 * ((var_284_3 - arg_281_1.typewritterCharCountI18N) / var_284_0)) > 0 and var_284_1 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end
			end

			local var_284_5 = math.max(1.93333333333333, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 then
				arg_281_1.fswtw_.percent = Mathf.Lerp(arg_281_1.var_.oldValueTypewriter, var_284_2, (arg_281_1.time_ - 0) / var_284_5)
				arg_281_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_281_1.fswtw_:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 then
				arg_281_1.fswtw_.percent = var_284_2

				arg_281_1.fswtw_:SetDirty()
				arg_281_1:ShowNextGo(true)

				arg_281_1.typewritterCharCountI18N = var_284_3
			end

			local var_284_6 = 0
			local var_284_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032070", "story_v_out_317032.awb") / 1000

			if var_284_7 > 0 and 1 < var_284_7 and var_284_7 + var_284_6 > arg_281_1.duration_ then
				arg_281_1.duration_ = var_284_7 + var_284_6
			end

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1:AudioAction("play", "voice", "story_v_out_317032", "317032070", "story_v_out_317032.awb")
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play317032071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 317032071
		arg_285_1.duration_ = 1.8

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play317032072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.oldValueTypewriter = arg_285_1.fswtw_.percent

				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_0 = 27
			local var_288_1 = 1.8
			local var_288_2, var_288_3 = arg_285_1:GetPercentByPara(arg_285_1:FormatText(arg_285_1:GetWordFromCfg(317032067).content), 5)

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				local var_288_4 = var_288_0 <= 0 and var_288_1 or var_288_1 * ((var_288_3 - arg_285_1.typewritterCharCountI18N) / var_288_0)

				if (var_288_0 <= 0 and var_288_1 or var_288_1 * ((var_288_3 - arg_285_1.typewritterCharCountI18N) / var_288_0)) > 0 and var_288_1 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end
			end

			local var_288_5 = math.max(1.8, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_5 then
				arg_285_1.fswtw_.percent = Mathf.Lerp(arg_285_1.var_.oldValueTypewriter, var_288_2, (arg_285_1.time_ - 0) / var_288_5)
				arg_285_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_285_1.fswtw_:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_5 and arg_285_1.time_ < 0 + var_288_5 + arg_288_0 then
				arg_285_1.fswtw_.percent = var_288_2

				arg_285_1.fswtw_:SetDirty()
				arg_285_1:ShowNextGo(true)

				arg_285_1.typewritterCharCountI18N = var_288_3
			end

			local var_288_6 = 0
			local var_288_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032071", "story_v_out_317032.awb") / 1000

			if var_288_7 > 0 and 1 < var_288_7 and var_288_7 + var_288_6 > arg_285_1.duration_ then
				arg_285_1.duration_ = var_288_7 + var_288_6
			end

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1:AudioAction("play", "voice", "story_v_out_317032", "317032071", "story_v_out_317032.awb")
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play317032072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 317032072
		arg_289_1.duration_ = 1

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play317032073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_0 = 13
			local var_292_1 = 0.866666666666667
			local var_292_2, var_292_3 = arg_289_1:GetPercentByPara(arg_289_1:FormatText(arg_289_1:GetWordFromCfg(317032067).content), 6)

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_4 = var_292_0 <= 0 and var_292_1 or var_292_1 * ((var_292_3 - arg_289_1.typewritterCharCountI18N) / var_292_0)

				if (var_292_0 <= 0 and var_292_1 or var_292_1 * ((var_292_3 - arg_289_1.typewritterCharCountI18N) / var_292_0)) > 0 and var_292_1 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end
			end

			local var_292_5 = math.max(0.866666666666667, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_5 then
				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_2, (arg_289_1.time_ - 0) / var_292_5)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_5 and arg_289_1.time_ < 0 + var_292_5 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_2

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_3
			end

			local var_292_6 = 0
			local var_292_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032072", "story_v_out_317032.awb") / 1000

			if var_292_7 > 0 and 1 < var_292_7 and var_292_7 + var_292_6 > arg_289_1.duration_ then
				arg_289_1.duration_ = var_292_7 + var_292_6
			end

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1:AudioAction("play", "voice", "story_v_out_317032", "317032072", "story_v_out_317032.awb")
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play317032073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 317032073
		arg_293_1.duration_ = 1.13

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play317032074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.oldValueTypewriter = arg_293_1.fswtw_.percent

				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_0 = 17
			local var_296_1 = 1.13333333333333
			local var_296_2, var_296_3 = arg_293_1:GetPercentByPara(arg_293_1:FormatText(arg_293_1:GetWordFromCfg(317032067).content), 7)

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				local var_296_4 = var_296_0 <= 0 and var_296_1 or var_296_1 * ((var_296_3 - arg_293_1.typewritterCharCountI18N) / var_296_0)

				if (var_296_0 <= 0 and var_296_1 or var_296_1 * ((var_296_3 - arg_293_1.typewritterCharCountI18N) / var_296_0)) > 0 and var_296_1 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end
			end

			local var_296_5 = math.max(1.13333333333333, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 then
				arg_293_1.fswtw_.percent = Mathf.Lerp(arg_293_1.var_.oldValueTypewriter, var_296_2, (arg_293_1.time_ - 0) / var_296_5)
				arg_293_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_293_1.fswtw_:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 then
				arg_293_1.fswtw_.percent = var_296_2

				arg_293_1.fswtw_:SetDirty()
				arg_293_1:ShowNextGo(true)

				arg_293_1.typewritterCharCountI18N = var_296_3
			end

			local var_296_6 = 0
			local var_296_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032073", "story_v_out_317032.awb") / 1000

			if var_296_7 > 0 and 1 < var_296_7 and var_296_7 + var_296_6 > arg_293_1.duration_ then
				arg_293_1.duration_ = var_296_7 + var_296_6
			end

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1:AudioAction("play", "voice", "story_v_out_317032", "317032073", "story_v_out_317032.awb")
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play317032074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 317032074
		arg_297_1.duration_ = 1.67

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play317032075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.oldValueTypewriter = arg_297_1.fswtw_.percent

				SetActive(arg_297_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_297_1:ShowNextGo(false)
			end

			local var_300_0 = 25
			local var_300_1 = 1.66666666666667
			local var_300_2, var_300_3 = arg_297_1:GetPercentByPara(arg_297_1:FormatText(arg_297_1:GetWordFromCfg(317032067).content), 8)

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				local var_300_4 = var_300_0 <= 0 and var_300_1 or var_300_1 * ((var_300_3 - arg_297_1.typewritterCharCountI18N) / var_300_0)

				if (var_300_0 <= 0 and var_300_1 or var_300_1 * ((var_300_3 - arg_297_1.typewritterCharCountI18N) / var_300_0)) > 0 and var_300_1 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end
			end

			local var_300_5 = math.max(1.66666666666667, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				arg_297_1.fswtw_.percent = Mathf.Lerp(arg_297_1.var_.oldValueTypewriter, var_300_2, (arg_297_1.time_ - 0) / var_300_5)
				arg_297_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_297_1.fswtw_:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				arg_297_1.fswtw_.percent = var_300_2

				arg_297_1.fswtw_:SetDirty()
				arg_297_1:ShowNextGo(true)

				arg_297_1.typewritterCharCountI18N = var_300_3
			end

			local var_300_6 = 0
			local var_300_7 = manager.audio:GetVoiceLength("story_v_out_317032", "317032074", "story_v_out_317032.awb") / 1000

			if var_300_7 > 0 and 1 < var_300_7 and var_300_7 + var_300_6 > arg_297_1.duration_ then
				arg_297_1.duration_ = var_300_7 + var_300_6
			end

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1:AudioAction("play", "voice", "story_v_out_317032", "317032074", "story_v_out_317032.awb")
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play317032075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 317032075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play317032076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.fswbg_:SetActive(false)
				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_301_1:ShowNextGo(false)
			end

			local var_304_0 = 0
			local var_304_1 = 0.725

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(317032075).content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 29 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_2) / 29)

				if (29 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_2) / 29)) > 0 and var_304_1 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_5 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_5 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_5

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_5 and arg_301_1.time_ < var_304_0 + var_304_5 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play317032076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 317032076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play317032077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.15

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(317032076).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 46 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 46)

				if (46 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 46)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play317032077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 317032077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play317032078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.775

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(317032077).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 31)

				if (31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 31)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play317032078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 317032078
		arg_313_1.duration_ = 4.5

		local var_313_0 = {
			zh = 4.5,
			ja = 4.333
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play317032079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1015ui_story = arg_313_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).z)
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles = arg_313_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_313_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1015ui_story"].transform.position).z)
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1015ui_story"].transform.localEulerAngles = arg_313_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1015ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1015ui_story == nil then
				arg_313_1.var_.characterEffect1015ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1015ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1015ui_story then
				arg_313_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_4 = arg_313_1.actors_["2078ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos2078ui_story = var_316_4.localPosition
			end

			local var_316_5 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_5 then
				var_316_4.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_313_1.time_ - 0) / var_316_5)
				var_316_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_4.position).x, (manager.ui.mainCamera.transform.position - var_316_4.position).y, (manager.ui.mainCamera.transform.position - var_316_4.position).z)
				var_316_4.localEulerAngles.z = 0
				var_316_4.localEulerAngles.x = 0
				var_316_4.localEulerAngles = var_316_4.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_5 and arg_313_1.time_ < 0 + var_316_5 + arg_316_0 then
				var_316_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_316_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_4.position).x, (manager.ui.mainCamera.transform.position - var_316_4.position).y, (manager.ui.mainCamera.transform.position - var_316_4.position).z)
				var_316_4.localEulerAngles.z = 0
				var_316_4.localEulerAngles.x = 0
				var_316_4.localEulerAngles = var_316_4.localEulerAngles
			end

			local var_316_6 = arg_313_1.actors_["2078ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect2078ui_story == nil then
				arg_313_1.var_.characterEffect2078ui_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_7 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 and not isNil(var_316_6) then
				if arg_313_1.var_.characterEffect2078ui_story and not isNil(var_316_6) then
					arg_313_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_313_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_7)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect2078ui_story then
				arg_313_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_313_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_316_8 = 0
			local var_316_9 = 0.45

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(317032078)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 17 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 17)

				if (17 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 17)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032078", "story_v_out_317032.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032078", "story_v_out_317032.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_317032", "317032078", "story_v_out_317032.awb")

						arg_313_1:RecordAudio("317032078", var_316_15)
						arg_313_1:RecordAudio("317032078", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_317032", "317032078", "story_v_out_317032.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_317032", "317032078", "story_v_out_317032.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_313_1:InitPlayNodeList()
	end,
	Play317032079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 317032079
		arg_317_1.duration_ = 3.2

		local var_317_0 = {
			zh = 3.066,
			ja = 3.2
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play317032080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1015ui_story = arg_317_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).z)
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles = arg_317_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_317_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1015ui_story"].transform.position).z)
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1015ui_story"].transform.localEulerAngles = arg_317_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1015ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1015ui_story == nil then
				arg_317_1.var_.characterEffect1015ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1015ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1015ui_story then
				arg_317_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_320_3 = arg_317_1.actors_["2078ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos2078ui_story = var_320_3.localPosition
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_3.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_317_1.time_ - 0) / var_320_4)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			local var_320_5 = arg_317_1.actors_["2078ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect2078ui_story == nil then
				arg_317_1.var_.characterEffect2078ui_story = var_320_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.characterEffect2078ui_story and not isNil(var_320_5) then
					arg_317_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect2078ui_story then
				arg_317_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_8 = 0
			local var_320_9 = 0.3

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:GetWordFromCfg(317032079)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.text_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 12 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 12)

				if (12 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 12)) > 0 and var_320_9 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_11
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032079", "story_v_out_317032.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032079", "story_v_out_317032.awb") / 1000

					if var_320_14 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_8
					end

					if var_320_10.prefab_name ~= "" and arg_317_1.actors_[var_320_10.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_10.prefab_name].transform, "story_v_out_317032", "317032079", "story_v_out_317032.awb")

						arg_317_1:RecordAudio("317032079", var_320_15)
						arg_317_1:RecordAudio("317032079", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_317032", "317032079", "story_v_out_317032.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_317032", "317032079", "story_v_out_317032.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_16 and arg_317_1.time_ < var_320_8 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_317_1:InitPlayNodeList()
	end,
	Play317032080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 317032080
		arg_321_1.duration_ = 9.73

		local var_321_0 = {
			zh = 9.133,
			ja = 9.733
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play317032081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1015ui_story"]) and arg_321_1.var_.characterEffect1015ui_story == nil then
				arg_321_1.var_.characterEffect1015ui_story = arg_321_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1015ui_story"]) then
				if arg_321_1.var_.characterEffect1015ui_story and not isNil(arg_321_1.actors_["1015ui_story"]) then
					arg_321_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1015ui_story"]) and arg_321_1.var_.characterEffect1015ui_story then
				arg_321_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_324_2 = arg_321_1.actors_["2078ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.characterEffect2078ui_story == nil then
				arg_321_1.var_.characterEffect2078ui_story = var_324_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_3 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.characterEffect2078ui_story and not isNil(var_324_2) then
					arg_321_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_321_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_3)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.characterEffect2078ui_story then
				arg_321_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_321_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_324_4 = 0
			local var_324_5 = 0.95

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(317032080)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 38 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 38)

				if (38 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 38)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032080", "story_v_out_317032.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032080", "story_v_out_317032.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_317032", "317032080", "story_v_out_317032.awb")

						arg_321_1:RecordAudio("317032080", var_324_11)
						arg_321_1:RecordAudio("317032080", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_317032", "317032080", "story_v_out_317032.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_317032", "317032080", "story_v_out_317032.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play317032081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 317032081
		arg_325_1.duration_ = 2.97

		local var_325_0 = {
			zh = 1.1,
			ja = 2.966
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
				arg_325_0:Play317032082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1015ui_story = arg_325_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).z)
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles = arg_325_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_325_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1015ui_story"].transform.position).z)
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1015ui_story"].transform.localEulerAngles = arg_325_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1015ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1015ui_story == nil then
				arg_325_1.var_.characterEffect1015ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1015ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_2)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1015ui_story then
				arg_325_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_328_3 = arg_325_1.actors_["2078ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos2078ui_story = var_328_3.localPosition
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_3.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_325_1.time_ - 0) / var_328_4)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_3.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			local var_328_5 = arg_325_1.actors_["2078ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect2078ui_story == nil then
				arg_325_1.var_.characterEffect2078ui_story = var_328_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_6 and not isNil(var_328_5) then
				if arg_325_1.var_.characterEffect2078ui_story and not isNil(var_328_5) then
					arg_325_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_6 and arg_325_1.time_ < 0 + var_328_6 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect2078ui_story then
				arg_325_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_8 = 0
			local var_328_9 = 0.075

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:GetWordFromCfg(317032081)
				local var_328_11 = arg_325_1:FormatText(var_328_10.content)

				arg_325_1.text_.text = var_328_11

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_13 = 3 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_11) / 3)

				if (3 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_11) / 3)) > 0 and var_328_9 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_8
					end
				end

				arg_325_1.text_.text = var_328_11
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032081", "story_v_out_317032.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032081", "story_v_out_317032.awb") / 1000

					if var_328_14 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_8
					end

					if var_328_10.prefab_name ~= "" and arg_325_1.actors_[var_328_10.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_10.prefab_name].transform, "story_v_out_317032", "317032081", "story_v_out_317032.awb")

						arg_325_1:RecordAudio("317032081", var_328_15)
						arg_325_1:RecordAudio("317032081", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_317032", "317032081", "story_v_out_317032.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_317032", "317032081", "story_v_out_317032.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_9, arg_325_1.talkMaxDuration)

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_8) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_8 + var_328_16 and arg_325_1.time_ < var_328_8 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_325_1:InitPlayNodeList()
	end,
	Play317032082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 317032082
		arg_329_1.duration_ = 11.1

		local var_329_0 = {
			zh = 7.866,
			ja = 11.1
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play317032083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1015ui_story"]) and arg_329_1.var_.characterEffect1015ui_story == nil then
				arg_329_1.var_.characterEffect1015ui_story = arg_329_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1015ui_story"]) then
				if arg_329_1.var_.characterEffect1015ui_story and not isNil(arg_329_1.actors_["1015ui_story"]) then
					arg_329_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1015ui_story"]) and arg_329_1.var_.characterEffect1015ui_story then
				arg_329_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_332_2 = arg_329_1.actors_["2078ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect2078ui_story == nil then
				arg_329_1.var_.characterEffect2078ui_story = var_332_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_3 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.characterEffect2078ui_story and not isNil(var_332_2) then
					arg_329_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_329_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_3)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect2078ui_story then
				arg_329_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_329_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_332_4 = 0
			local var_332_5 = 0.925

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(317032082)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 37 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 37)

				if (37 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 37)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032082", "story_v_out_317032.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032082", "story_v_out_317032.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_out_317032", "317032082", "story_v_out_317032.awb")

						arg_329_1:RecordAudio("317032082", var_332_11)
						arg_329_1:RecordAudio("317032082", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_317032", "317032082", "story_v_out_317032.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_317032", "317032082", "story_v_out_317032.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play317032083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 317032083
		arg_333_1.duration_ = 10.37

		local var_333_0 = {
			zh = 8.5,
			ja = 10.366
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
				arg_333_0:Play317032084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1015ui_story"]) and arg_333_1.var_.characterEffect1015ui_story == nil then
				arg_333_1.var_.characterEffect1015ui_story = arg_333_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1015ui_story"]) then
				if arg_333_1.var_.characterEffect1015ui_story and not isNil(arg_333_1.actors_["1015ui_story"]) then
					arg_333_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1015ui_story"]) and arg_333_1.var_.characterEffect1015ui_story then
				arg_333_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_336_1 = arg_333_1.actors_["2078ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect2078ui_story == nil then
				arg_333_1.var_.characterEffect2078ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect2078ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect2078ui_story then
				arg_333_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_336_4 = 0
			local var_336_5 = 1.175

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(317032083)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 47 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 47)

				if (47 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 47)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032083", "story_v_out_317032.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032083", "story_v_out_317032.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_317032", "317032083", "story_v_out_317032.awb")

						arg_333_1:RecordAudio("317032083", var_336_11)
						arg_333_1:RecordAudio("317032083", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_317032", "317032083", "story_v_out_317032.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_317032", "317032083", "story_v_out_317032.awb")
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

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play317032084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 317032084
		arg_337_1.duration_ = 4.2

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play317032085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1015ui_story"]) and arg_337_1.var_.characterEffect1015ui_story == nil then
				arg_337_1.var_.characterEffect1015ui_story = arg_337_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1015ui_story"]) then
				if arg_337_1.var_.characterEffect1015ui_story and not isNil(arg_337_1.actors_["1015ui_story"]) then
					arg_337_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1015ui_story"]) and arg_337_1.var_.characterEffect1015ui_story then
				arg_337_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_340_2 = arg_337_1.actors_["2078ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect2078ui_story == nil then
				arg_337_1.var_.characterEffect2078ui_story = var_340_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_3 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.characterEffect2078ui_story and not isNil(var_340_2) then
					arg_337_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_337_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_3)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect2078ui_story then
				arg_337_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_337_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_340_4 = 0
			local var_340_5 = 0.325

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(317032084)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 13 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 13)

				if (13 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 13)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032084", "story_v_out_317032.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032084", "story_v_out_317032.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_317032", "317032084", "story_v_out_317032.awb")

						arg_337_1:RecordAudio("317032084", var_340_11)
						arg_337_1:RecordAudio("317032084", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_317032", "317032084", "story_v_out_317032.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_317032", "317032084", "story_v_out_317032.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play317032085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 317032085
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play317032086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1015ui_story = arg_341_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).z)
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles = arg_341_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1015ui_story"].transform.position).z)
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1015ui_story"].transform.localEulerAngles = arg_341_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["2078ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos2078ui_story = var_344_1.localPosition
			end

			local var_344_2 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 then
				var_344_1.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_2)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 then
				var_344_1.localPosition = Vector3.New(0, 100, 0)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			local var_344_3 = 0
			local var_344_4 = 0.45

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

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(317032085).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 18 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 18)

				if (18 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 18)) > 0 and var_344_4 < var_344_7 then
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
				actorName = "1015ui_story",
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

		arg_341_1:InitPlayNodeList()
	end,
	Play317032086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 317032086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play317032087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.25

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(317032086).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 10 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 10)

				if (10 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 10)) > 0 and var_348_0 < var_348_3 then
					arg_345_1.talkMaxDuration = var_348_3

					if var_348_3 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_3 + 0
					end
				end

				arg_345_1.text_.text = var_348_1
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_4 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_4

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play317032087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 317032087
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play317032088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 1.175

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(317032087).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 47 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 47)

				if (47 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 47)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play317032088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 317032088
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play317032089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.2

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(317032088).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 8 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 8)

				if (8 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 8)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play317032089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 317032089
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play317032090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.5

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(317032089).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 20 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 20)

				if (20 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 20)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play317032090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 317032090
		arg_361_1.duration_ = 9.1

		local var_361_0 = {
			zh = 9.1,
			ja = 7.8
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play317032091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1015ui_story = arg_361_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).z)
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles = arg_361_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_361_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1015ui_story"].transform.position).z)
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1015ui_story"].transform.localEulerAngles = arg_361_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["1015ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1015ui_story == nil then
				arg_361_1.var_.characterEffect1015ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect1015ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect1015ui_story then
				arg_361_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_364_4 = arg_361_1.actors_["2078ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos2078ui_story = var_364_4.localPosition
			end

			local var_364_5 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_5 then
				var_364_4.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_361_1.time_ - 0) / var_364_5)
				var_364_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_4.position).x, (manager.ui.mainCamera.transform.position - var_364_4.position).y, (manager.ui.mainCamera.transform.position - var_364_4.position).z)
				var_364_4.localEulerAngles.z = 0
				var_364_4.localEulerAngles.x = 0
				var_364_4.localEulerAngles = var_364_4.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_5 and arg_361_1.time_ < 0 + var_364_5 + arg_364_0 then
				var_364_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_364_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_4.position).x, (manager.ui.mainCamera.transform.position - var_364_4.position).y, (manager.ui.mainCamera.transform.position - var_364_4.position).z)
				var_364_4.localEulerAngles.z = 0
				var_364_4.localEulerAngles.x = 0
				var_364_4.localEulerAngles = var_364_4.localEulerAngles
			end

			local var_364_6 = arg_361_1.actors_["2078ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect2078ui_story == nil then
				arg_361_1.var_.characterEffect2078ui_story = var_364_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_7 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 and not isNil(var_364_6) then
				if arg_361_1.var_.characterEffect2078ui_story and not isNil(var_364_6) then
					arg_361_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_361_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_7)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect2078ui_story then
				arg_361_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_361_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_364_8 = 0
			local var_364_9 = 0.975

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(317032090)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_13 = 40 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 40)

				if (40 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 40)) > 0 and var_364_9 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_8
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032090", "story_v_out_317032.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032090", "story_v_out_317032.awb") / 1000

					if var_364_14 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_8
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_317032", "317032090", "story_v_out_317032.awb")

						arg_361_1:RecordAudio("317032090", var_364_15)
						arg_361_1:RecordAudio("317032090", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_317032", "317032090", "story_v_out_317032.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_317032", "317032090", "story_v_out_317032.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_9, arg_361_1.talkMaxDuration)

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_8) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_8 + var_364_16 and arg_361_1.time_ < var_364_8 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_361_1:InitPlayNodeList()
	end,
	Play317032091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 317032091
		arg_365_1.duration_ = 2.6

		local var_365_0 = {
			zh = 1.3,
			ja = 2.6
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play317032092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1015ui_story"]) and arg_365_1.var_.characterEffect1015ui_story == nil then
				arg_365_1.var_.characterEffect1015ui_story = arg_365_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1015ui_story"]) then
				if arg_365_1.var_.characterEffect1015ui_story and not isNil(arg_365_1.actors_["1015ui_story"]) then
					arg_365_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1015ui_story"]) and arg_365_1.var_.characterEffect1015ui_story then
				arg_365_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_368_1 = arg_365_1.actors_["2078ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect2078ui_story == nil then
				arg_365_1.var_.characterEffect2078ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect2078ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect2078ui_story then
				arg_365_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_368_4 = 0
			local var_368_5 = 0.125

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(317032091)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 5 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 5)

				if (5 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 5)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032091", "story_v_out_317032.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032091", "story_v_out_317032.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_out_317032", "317032091", "story_v_out_317032.awb")

						arg_365_1:RecordAudio("317032091", var_368_11)
						arg_365_1:RecordAudio("317032091", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_317032", "317032091", "story_v_out_317032.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_317032", "317032091", "story_v_out_317032.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play317032092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 317032092
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play317032093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1015ui_story = arg_369_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).z)
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles = arg_369_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).z)
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles = arg_369_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1015ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1015ui_story == nil then
				arg_369_1.var_.characterEffect1015ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1015ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_2)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1015ui_story then
				arg_369_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_372_3 = arg_369_1.actors_["2078ui_story"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos2078ui_story = var_372_3.localPosition
			end

			local var_372_4 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_3.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_4)
				var_372_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_3.position).x, (manager.ui.mainCamera.transform.position - var_372_3.position).y, (manager.ui.mainCamera.transform.position - var_372_3.position).z)
				var_372_3.localEulerAngles.z = 0
				var_372_3.localEulerAngles.x = 0
				var_372_3.localEulerAngles = var_372_3.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_3.localPosition = Vector3.New(0, 100, 0)
				var_372_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_3.position).x, (manager.ui.mainCamera.transform.position - var_372_3.position).y, (manager.ui.mainCamera.transform.position - var_372_3.position).z)
				var_372_3.localEulerAngles.z = 0
				var_372_3.localEulerAngles.x = 0
				var_372_3.localEulerAngles = var_372_3.localEulerAngles
			end

			local var_372_5 = arg_369_1.actors_["2078ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.characterEffect2078ui_story == nil then
				arg_369_1.var_.characterEffect2078ui_story = var_372_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_6 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.characterEffect2078ui_story and not isNil(var_372_5) then
					arg_369_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_369_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_6)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.characterEffect2078ui_story then
				arg_369_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_369_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_372_7 = 0
			local var_372_8 = 0.35

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_9 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(317032092).content)

				arg_369_1.text_.text = var_372_9

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 14 <= 0 and var_372_8 or var_372_8 * (utf8.len(var_372_9) / 14)

				if (14 <= 0 and var_372_8 or var_372_8 * (utf8.len(var_372_9) / 14)) > 0 and var_372_8 < var_372_11 then
					arg_369_1.talkMaxDuration = var_372_11

					if var_372_11 + var_372_7 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_7
					end
				end

				arg_369_1.text_.text = var_372_9
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_8, arg_369_1.talkMaxDuration)

			if var_372_7 <= arg_369_1.time_ and arg_369_1.time_ < var_372_7 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_7) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_7 + var_372_12 and arg_369_1.time_ < var_372_7 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_369_1:InitPlayNodeList()
	end,
	Play317032093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 317032093
		arg_373_1.duration_ = 15.77

		local var_373_0 = {
			zh = 11.733,
			ja = 15.766
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play317032094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1015ui_story = arg_373_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).z)
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles = arg_373_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_373_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1015ui_story"].transform.position).z)
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1015ui_story"].transform.localEulerAngles = arg_373_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1015ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1015ui_story == nil then
				arg_373_1.var_.characterEffect1015ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect1015ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1015ui_story then
				arg_373_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_4 = 0
			local var_376_5 = 1.55

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:GetWordFromCfg(317032093)
				local var_376_7 = arg_373_1:FormatText(var_376_6.content)

				arg_373_1.text_.text = var_376_7

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_9 = 60 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 60)

				if (60 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 60)) > 0 and var_376_5 < var_376_9 then
					arg_373_1.talkMaxDuration = var_376_9

					if var_376_9 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_7
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032093", "story_v_out_317032.awb") ~= 0 then
					local var_376_10 = manager.audio:GetVoiceLength("story_v_out_317032", "317032093", "story_v_out_317032.awb") / 1000

					if var_376_10 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_4
					end

					if var_376_6.prefab_name ~= "" and arg_373_1.actors_[var_376_6.prefab_name] ~= nil then
						local var_376_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_6.prefab_name].transform, "story_v_out_317032", "317032093", "story_v_out_317032.awb")

						arg_373_1:RecordAudio("317032093", var_376_11)
						arg_373_1:RecordAudio("317032093", var_376_11)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_317032", "317032093", "story_v_out_317032.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_317032", "317032093", "story_v_out_317032.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_12 and arg_373_1.time_ < var_376_4 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play317032094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 317032094
		arg_377_1.duration_ = 7.8

		local var_377_0 = {
			zh = 4.2,
			ja = 7.8
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play317032095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1015ui_story = arg_377_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).z)
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles = arg_377_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1015ui_story"].transform.position).z)
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1015ui_story"].transform.localEulerAngles = arg_377_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1015ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1015ui_story == nil then
				arg_377_1.var_.characterEffect1015ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1015ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_2)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1015ui_story then
				arg_377_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_380_3 = arg_377_1.actors_["2078ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos2078ui_story = var_380_3.localPosition
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_3.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_377_1.time_ - 0) / var_380_4)
				var_380_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_3.position).x, (manager.ui.mainCamera.transform.position - var_380_3.position).y, (manager.ui.mainCamera.transform.position - var_380_3.position).z)
				var_380_3.localEulerAngles.z = 0
				var_380_3.localEulerAngles.x = 0
				var_380_3.localEulerAngles = var_380_3.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_380_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_3.position).x, (manager.ui.mainCamera.transform.position - var_380_3.position).y, (manager.ui.mainCamera.transform.position - var_380_3.position).z)
				var_380_3.localEulerAngles.z = 0
				var_380_3.localEulerAngles.x = 0
				var_380_3.localEulerAngles = var_380_3.localEulerAngles
			end

			local var_380_5 = arg_377_1.actors_["2078ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect2078ui_story == nil then
				arg_377_1.var_.characterEffect2078ui_story = var_380_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_6 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.characterEffect2078ui_story and not isNil(var_380_5) then
					arg_377_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_377_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_6)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.characterEffect2078ui_story then
				arg_377_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_377_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_380_7 = arg_377_1.actors_["2079ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos2079ui_story = var_380_7.localPosition
			end

			local var_380_8 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_8 then
				var_380_7.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_377_1.time_ - 0) / var_380_8)
				var_380_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_7.position).x, (manager.ui.mainCamera.transform.position - var_380_7.position).y, (manager.ui.mainCamera.transform.position - var_380_7.position).z)
				var_380_7.localEulerAngles.z = 0
				var_380_7.localEulerAngles.x = 0
				var_380_7.localEulerAngles = var_380_7.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_8 and arg_377_1.time_ < 0 + var_380_8 + arg_380_0 then
				var_380_7.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_380_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_7.position).x, (manager.ui.mainCamera.transform.position - var_380_7.position).y, (manager.ui.mainCamera.transform.position - var_380_7.position).z)
				var_380_7.localEulerAngles.z = 0
				var_380_7.localEulerAngles.x = 0
				var_380_7.localEulerAngles = var_380_7.localEulerAngles
			end

			local var_380_9 = arg_377_1.actors_["2079ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect2079ui_story == nil then
				arg_377_1.var_.characterEffect2079ui_story = var_380_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_10 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_10 and not isNil(var_380_9) then
				if arg_377_1.var_.characterEffect2079ui_story and not isNil(var_380_9) then
					arg_377_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_10 and arg_377_1.time_ < 0 + var_380_10 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect2079ui_story then
				arg_377_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_12 = 0
			local var_380_13 = 0.55

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_12 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_14 = arg_377_1:GetWordFromCfg(317032094)
				local var_380_15 = arg_377_1:FormatText(var_380_14.content)

				arg_377_1.text_.text = var_380_15

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_17 = 22 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 22)

				if (22 <= 0 and var_380_13 or var_380_13 * (utf8.len(var_380_15) / 22)) > 0 and var_380_13 < var_380_17 then
					arg_377_1.talkMaxDuration = var_380_17

					if var_380_17 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_12
					end
				end

				arg_377_1.text_.text = var_380_15
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032094", "story_v_out_317032.awb") ~= 0 then
					local var_380_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032094", "story_v_out_317032.awb") / 1000

					if var_380_18 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_18 + var_380_12
					end

					if var_380_14.prefab_name ~= "" and arg_377_1.actors_[var_380_14.prefab_name] ~= nil then
						local var_380_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_14.prefab_name].transform, "story_v_out_317032", "317032094", "story_v_out_317032.awb")

						arg_377_1:RecordAudio("317032094", var_380_19)
						arg_377_1:RecordAudio("317032094", var_380_19)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_317032", "317032094", "story_v_out_317032.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_317032", "317032094", "story_v_out_317032.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_20 = math.max(var_380_13, arg_377_1.talkMaxDuration)

			if var_380_12 <= arg_377_1.time_ and arg_377_1.time_ < var_380_12 + var_380_20 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_12) / var_380_20

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_12 + var_380_20 and arg_377_1.time_ < var_380_12 + var_380_20 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_377_1:InitPlayNodeList()
	end,
	Play317032095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 317032095
		arg_381_1.duration_ = 5.4

		local var_381_0 = {
			zh = 5.4,
			ja = 4.3
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play317032096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos2078ui_story = arg_381_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).z)
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles = arg_381_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_381_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["2078ui_story"].transform.position).z)
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["2078ui_story"].transform.localEulerAngles = arg_381_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["2078ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect2078ui_story == nil then
				arg_381_1.var_.characterEffect2078ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect2078ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect2078ui_story then
				arg_381_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_4 = arg_381_1.actors_["2079ui_story"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos2079ui_story = var_384_4.localPosition
			end

			local var_384_5 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_5 then
				var_384_4.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_381_1.time_ - 0) / var_384_5)
				var_384_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_4.position).x, (manager.ui.mainCamera.transform.position - var_384_4.position).y, (manager.ui.mainCamera.transform.position - var_384_4.position).z)
				var_384_4.localEulerAngles.z = 0
				var_384_4.localEulerAngles.x = 0
				var_384_4.localEulerAngles = var_384_4.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_5 and arg_381_1.time_ < 0 + var_384_5 + arg_384_0 then
				var_384_4.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_384_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_384_4.position).x, (manager.ui.mainCamera.transform.position - var_384_4.position).y, (manager.ui.mainCamera.transform.position - var_384_4.position).z)
				var_384_4.localEulerAngles.z = 0
				var_384_4.localEulerAngles.x = 0
				var_384_4.localEulerAngles = var_384_4.localEulerAngles
			end

			local var_384_6 = arg_381_1.actors_["2079ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_6) and arg_381_1.var_.characterEffect2079ui_story == nil then
				arg_381_1.var_.characterEffect2079ui_story = var_384_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_7 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 and not isNil(var_384_6) then
				if arg_381_1.var_.characterEffect2079ui_story and not isNil(var_384_6) then
					arg_381_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_381_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_7)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 and not isNil(var_384_6) and arg_381_1.var_.characterEffect2079ui_story then
				arg_381_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_381_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_384_8 = 0
			local var_384_9 = 0.55

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_10 = arg_381_1:GetWordFromCfg(317032095)
				local var_384_11 = arg_381_1:FormatText(var_384_10.content)

				arg_381_1.text_.text = var_384_11

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 22 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 22)

				if (22 <= 0 and var_384_9 or var_384_9 * (utf8.len(var_384_11) / 22)) > 0 and var_384_9 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_8
					end
				end

				arg_381_1.text_.text = var_384_11
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032095", "story_v_out_317032.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032095", "story_v_out_317032.awb") / 1000

					if var_384_14 + var_384_8 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_8
					end

					if var_384_10.prefab_name ~= "" and arg_381_1.actors_[var_384_10.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_10.prefab_name].transform, "story_v_out_317032", "317032095", "story_v_out_317032.awb")

						arg_381_1:RecordAudio("317032095", var_384_15)
						arg_381_1:RecordAudio("317032095", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_317032", "317032095", "story_v_out_317032.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_317032", "317032095", "story_v_out_317032.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_9, arg_381_1.talkMaxDuration)

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_8) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_8 + var_384_16 and arg_381_1.time_ < var_384_8 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play317032096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 317032096
		arg_385_1.duration_ = 2.93

		local var_385_0 = {
			zh = 2.766,
			ja = 2.933
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play317032097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1015ui_story = arg_385_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).z)
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles = arg_385_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_385_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1015ui_story"].transform.position).z)
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1015ui_story"].transform.localEulerAngles = arg_385_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1015ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1015ui_story == nil then
				arg_385_1.var_.characterEffect1015ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1015ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1015ui_story then
				arg_385_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_388_4 = arg_385_1.actors_["2078ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos2078ui_story = var_388_4.localPosition
			end

			local var_388_5 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_5 then
				var_388_4.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_5)
				var_388_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_4.position).x, (manager.ui.mainCamera.transform.position - var_388_4.position).y, (manager.ui.mainCamera.transform.position - var_388_4.position).z)
				var_388_4.localEulerAngles.z = 0
				var_388_4.localEulerAngles.x = 0
				var_388_4.localEulerAngles = var_388_4.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_5 and arg_385_1.time_ < 0 + var_388_5 + arg_388_0 then
				var_388_4.localPosition = Vector3.New(0, 100, 0)
				var_388_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_4.position).x, (manager.ui.mainCamera.transform.position - var_388_4.position).y, (manager.ui.mainCamera.transform.position - var_388_4.position).z)
				var_388_4.localEulerAngles.z = 0
				var_388_4.localEulerAngles.x = 0
				var_388_4.localEulerAngles = var_388_4.localEulerAngles
			end

			local var_388_6 = arg_385_1.actors_["2078ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_6) and arg_385_1.var_.characterEffect2078ui_story == nil then
				arg_385_1.var_.characterEffect2078ui_story = var_388_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_7 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 and not isNil(var_388_6) then
				if arg_385_1.var_.characterEffect2078ui_story and not isNil(var_388_6) then
					arg_385_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_385_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_7)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 and not isNil(var_388_6) and arg_385_1.var_.characterEffect2078ui_story then
				arg_385_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_385_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_388_8 = arg_385_1.actors_["2079ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos2079ui_story = var_388_8.localPosition
			end

			local var_388_9 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_9 then
				var_388_8.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_9)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_9 and arg_385_1.time_ < 0 + var_388_9 + arg_388_0 then
				var_388_8.localPosition = Vector3.New(0, 100, 0)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			local var_388_10 = arg_385_1.actors_["2079ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_10) and arg_385_1.var_.characterEffect2079ui_story == nil then
				arg_385_1.var_.characterEffect2079ui_story = var_388_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_11 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_11 and not isNil(var_388_10) then
				if arg_385_1.var_.characterEffect2079ui_story and not isNil(var_388_10) then
					arg_385_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_385_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_11)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_11 and arg_385_1.time_ < 0 + var_388_11 + arg_388_0 and not isNil(var_388_10) and arg_385_1.var_.characterEffect2079ui_story then
				arg_385_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_385_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_388_12 = 0
			local var_388_13 = 0.3

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_12 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_14 = arg_385_1:GetWordFromCfg(317032096)
				local var_388_15 = arg_385_1:FormatText(var_388_14.content)

				arg_385_1.text_.text = var_388_15

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_17 = 12 <= 0 and var_388_13 or var_388_13 * (utf8.len(var_388_15) / 12)

				if (12 <= 0 and var_388_13 or var_388_13 * (utf8.len(var_388_15) / 12)) > 0 and var_388_13 < var_388_17 then
					arg_385_1.talkMaxDuration = var_388_17

					if var_388_17 + var_388_12 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_17 + var_388_12
					end
				end

				arg_385_1.text_.text = var_388_15
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032096", "story_v_out_317032.awb") ~= 0 then
					local var_388_18 = manager.audio:GetVoiceLength("story_v_out_317032", "317032096", "story_v_out_317032.awb") / 1000

					if var_388_18 + var_388_12 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_18 + var_388_12
					end

					if var_388_14.prefab_name ~= "" and arg_385_1.actors_[var_388_14.prefab_name] ~= nil then
						local var_388_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_14.prefab_name].transform, "story_v_out_317032", "317032096", "story_v_out_317032.awb")

						arg_385_1:RecordAudio("317032096", var_388_19)
						arg_385_1:RecordAudio("317032096", var_388_19)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_317032", "317032096", "story_v_out_317032.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_317032", "317032096", "story_v_out_317032.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_20 = math.max(var_388_13, arg_385_1.talkMaxDuration)

			if var_388_12 <= arg_385_1.time_ and arg_385_1.time_ < var_388_12 + var_388_20 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_12) / var_388_20

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_12 + var_388_20 and arg_385_1.time_ < var_388_12 + var_388_20 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_385_1:InitPlayNodeList()
	end,
	Play317032097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 317032097
		arg_389_1.duration_ = 4.47

		local var_389_0 = {
			zh = 4.466,
			ja = 3.766
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play317032098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1015ui_story = arg_389_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).z)
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles = arg_389_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1015ui_story"].transform.position).z)
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1015ui_story"].transform.localEulerAngles = arg_389_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1015ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1015ui_story == nil then
				arg_389_1.var_.characterEffect1015ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1015ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_2)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1015ui_story then
				arg_389_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_392_3 = arg_389_1.actors_["2078ui_story"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos2078ui_story = var_392_3.localPosition
			end

			local var_392_4 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				var_392_3.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_389_1.time_ - 0) / var_392_4)
				var_392_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_3.position).x, (manager.ui.mainCamera.transform.position - var_392_3.position).y, (manager.ui.mainCamera.transform.position - var_392_3.position).z)
				var_392_3.localEulerAngles.z = 0
				var_392_3.localEulerAngles.x = 0
				var_392_3.localEulerAngles = var_392_3.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				var_392_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_392_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_3.position).x, (manager.ui.mainCamera.transform.position - var_392_3.position).y, (manager.ui.mainCamera.transform.position - var_392_3.position).z)
				var_392_3.localEulerAngles.z = 0
				var_392_3.localEulerAngles.x = 0
				var_392_3.localEulerAngles = var_392_3.localEulerAngles
			end

			local var_392_5 = arg_389_1.actors_["2078ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.characterEffect2078ui_story == nil then
				arg_389_1.var_.characterEffect2078ui_story = var_392_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_6 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_6 and not isNil(var_392_5) then
				if arg_389_1.var_.characterEffect2078ui_story and not isNil(var_392_5) then
					arg_389_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_6 and arg_389_1.time_ < 0 + var_392_6 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.characterEffect2078ui_story then
				arg_389_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_392_8 = 0
			local var_392_9 = 0.575

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:GetWordFromCfg(317032097)
				local var_392_11 = arg_389_1:FormatText(var_392_10.content)

				arg_389_1.text_.text = var_392_11

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_13 = 23 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 23)

				if (23 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_11) / 23)) > 0 and var_392_9 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_11
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032097", "story_v_out_317032.awb") ~= 0 then
					local var_392_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032097", "story_v_out_317032.awb") / 1000

					if var_392_14 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_8
					end

					if var_392_10.prefab_name ~= "" and arg_389_1.actors_[var_392_10.prefab_name] ~= nil then
						local var_392_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_10.prefab_name].transform, "story_v_out_317032", "317032097", "story_v_out_317032.awb")

						arg_389_1:RecordAudio("317032097", var_392_15)
						arg_389_1:RecordAudio("317032097", var_392_15)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_317032", "317032097", "story_v_out_317032.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_317032", "317032097", "story_v_out_317032.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_16 and arg_389_1.time_ < var_392_8 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_389_1:InitPlayNodeList()
	end,
	Play317032098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 317032098
		arg_393_1.duration_ = 7.3

		local var_393_0 = {
			zh = 5.566,
			ja = 7.3
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play317032099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1015ui_story = arg_393_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).z)
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles = arg_393_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_393_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1015ui_story"].transform.position).z)
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1015ui_story"].transform.localEulerAngles = arg_393_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1015ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1015ui_story == nil then
				arg_393_1.var_.characterEffect1015ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1015ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1015ui_story then
				arg_393_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_396_4 = arg_393_1.actors_["2078ui_story"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos2078ui_story = var_396_4.localPosition
			end

			local var_396_5 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_5 then
				var_396_4.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 0) / var_396_5)
				var_396_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_4.position).x, (manager.ui.mainCamera.transform.position - var_396_4.position).y, (manager.ui.mainCamera.transform.position - var_396_4.position).z)
				var_396_4.localEulerAngles.z = 0
				var_396_4.localEulerAngles.x = 0
				var_396_4.localEulerAngles = var_396_4.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_5 and arg_393_1.time_ < 0 + var_396_5 + arg_396_0 then
				var_396_4.localPosition = Vector3.New(0, 100, 0)
				var_396_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_4.position).x, (manager.ui.mainCamera.transform.position - var_396_4.position).y, (manager.ui.mainCamera.transform.position - var_396_4.position).z)
				var_396_4.localEulerAngles.z = 0
				var_396_4.localEulerAngles.x = 0
				var_396_4.localEulerAngles = var_396_4.localEulerAngles
			end

			local var_396_6 = arg_393_1.actors_["2078ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_6) and arg_393_1.var_.characterEffect2078ui_story == nil then
				arg_393_1.var_.characterEffect2078ui_story = var_396_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_7 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 and not isNil(var_396_6) then
				if arg_393_1.var_.characterEffect2078ui_story and not isNil(var_396_6) then
					arg_393_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_393_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_7)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 and not isNil(var_396_6) and arg_393_1.var_.characterEffect2078ui_story then
				arg_393_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_393_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_396_8 = 0
			local var_396_9 = 0.75

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_10 = arg_393_1:GetWordFromCfg(317032098)
				local var_396_11 = arg_393_1:FormatText(var_396_10.content)

				arg_393_1.text_.text = var_396_11

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_13 = 30 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 30)

				if (30 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 30)) > 0 and var_396_9 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_8
					end
				end

				arg_393_1.text_.text = var_396_11
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032098", "story_v_out_317032.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_317032", "317032098", "story_v_out_317032.awb") / 1000

					if var_396_14 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_8
					end

					if var_396_10.prefab_name ~= "" and arg_393_1.actors_[var_396_10.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_10.prefab_name].transform, "story_v_out_317032", "317032098", "story_v_out_317032.awb")

						arg_393_1:RecordAudio("317032098", var_396_15)
						arg_393_1:RecordAudio("317032098", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_317032", "317032098", "story_v_out_317032.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_317032", "317032098", "story_v_out_317032.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_9, arg_393_1.talkMaxDuration)

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_8) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_8 + var_396_16 and arg_393_1.time_ < var_396_8 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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

		arg_393_1:InitPlayNodeList()
	end,
	Play317032099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 317032099
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play317032100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1015ui_story"]) and arg_397_1.var_.characterEffect1015ui_story == nil then
				arg_397_1.var_.characterEffect1015ui_story = arg_397_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1015ui_story"]) then
				if arg_397_1.var_.characterEffect1015ui_story and not isNil(arg_397_1.actors_["1015ui_story"]) then
					arg_397_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1015ui_story"]) and arg_397_1.var_.characterEffect1015ui_story then
				arg_397_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 0.275

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(317032099).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 11 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 11)

				if (11 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 11)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play317032100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 317032100
		arg_401_1.duration_ = 1.7

		local var_401_0 = {
			zh = 0.999999999999,
			ja = 1.7
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play317032101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1015ui_story"]) and arg_401_1.var_.characterEffect1015ui_story == nil then
				arg_401_1.var_.characterEffect1015ui_story = arg_401_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1015ui_story"]) then
				if arg_401_1.var_.characterEffect1015ui_story and not isNil(arg_401_1.actors_["1015ui_story"]) then
					arg_401_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1015ui_story"]) and arg_401_1.var_.characterEffect1015ui_story then
				arg_401_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_404_2 = 0
			local var_404_3 = 0.075

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(317032100)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 3 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 3)

				if (3 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 3)) > 0 and var_404_3 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317032", "317032100", "story_v_out_317032.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_317032", "317032100", "story_v_out_317032.awb") / 1000

					if var_404_8 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_2
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_out_317032", "317032100", "story_v_out_317032.awb")

						arg_401_1:RecordAudio("317032100", var_404_9)
						arg_401_1:RecordAudio("317032100", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_317032", "317032100", "story_v_out_317032.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_317032", "317032100", "story_v_out_317032.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_10 and arg_401_1.time_ < var_404_2 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play317032101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 317032101
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
			arg_405_1.auto_ = false
		end

		function arg_405_1.playNext_(arg_407_0)
			arg_405_1.onStoryFinished_()
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1015ui_story"]) and arg_405_1.var_.characterEffect1015ui_story == nil then
				arg_405_1.var_.characterEffect1015ui_story = arg_405_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1015ui_story"]) then
				if arg_405_1.var_.characterEffect1015ui_story and not isNil(arg_405_1.actors_["1015ui_story"]) then
					arg_405_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1015ui_story"]) and arg_405_1.var_.characterEffect1015ui_story then
				arg_405_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.325

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(317032101).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 13 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 13)

				if (13 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 13)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K10f"
	},
	voices = {
		"story_v_out_317032.awb"
	}
}
