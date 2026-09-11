return {
	Play321211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST73 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_4_0.name = "ST73"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST73 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST73

				arg_1_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

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
			local var_4_15 = 0.225

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(321211001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 9)

				if (9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 9)) > 0 and var_4_15 < var_4_19 then
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
	Play321211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321211002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.55

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321211002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 62 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 62)

				if (62 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 62)) > 0 and var_12_0 < var_12_3 then
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
	Play321211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321211003
		arg_13_1.duration_ = 15.47

		local var_13_0 = {
			zh = 7.466,
			ja = 15.466
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
				arg_13_0:Play321211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10104ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10104ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10104ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10104ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10104ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10104ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10104ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10104ui_story then
				arg_13_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_8 = "1284ui_story"

			if arg_13_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_16_9 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_13_1.stage_.transform)

				var_16_9.name = var_16_8
				var_16_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_8] = var_16_9

				local var_16_10 = var_16_9:GetComponentInChildren(typeof(CharacterEffect))

				var_16_10.enabled = true

				local var_16_11 = GameObjectTools.GetOrAddComponent(var_16_9, typeof(DynamicBoneHelper))

				if var_16_11 then
					var_16_11:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_10.transform, false)

				arg_13_1.var_[var_16_8 .. "Animator"] = var_16_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_8 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_8 .. "LipSync"] = var_16_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_12 = arg_13_1.actors_["1284ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1284ui_story = var_16_12.localPosition
			end

			local var_16_13 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_13 then
				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_13)
				var_16_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_12.position).x, (manager.ui.mainCamera.transform.position - var_16_12.position).y, (manager.ui.mainCamera.transform.position - var_16_12.position).z)
				var_16_12.localEulerAngles.z = 0
				var_16_12.localEulerAngles.x = 0
				var_16_12.localEulerAngles = var_16_12.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_13 and arg_13_1.time_ < 0 + var_16_13 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(0, 100, 0)
				var_16_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_12.position).x, (manager.ui.mainCamera.transform.position - var_16_12.position).y, (manager.ui.mainCamera.transform.position - var_16_12.position).z)
				var_16_12.localEulerAngles.z = 0
				var_16_12.localEulerAngles.x = 0
				var_16_12.localEulerAngles = var_16_12.localEulerAngles
			end

			local var_16_14 = 0
			local var_16_15 = 1.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_16 = arg_13_1:GetWordFromCfg(321211003)
				local var_16_17 = arg_13_1:FormatText(var_16_16.content)

				arg_13_1.text_.text = var_16_17

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 43 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 43)

				if (43 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 43)) > 0 and var_16_15 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_17
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211003", "story_v_out_321211.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_321211", "321211003", "story_v_out_321211.awb") / 1000

					if var_16_20 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_14
					end

					if var_16_16.prefab_name ~= "" and arg_13_1.actors_[var_16_16.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_16.prefab_name].transform, "story_v_out_321211", "321211003", "story_v_out_321211.awb")

						arg_13_1:RecordAudio("321211003", var_16_21)
						arg_13_1:RecordAudio("321211003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321211", "321211003", "story_v_out_321211.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321211", "321211003", "story_v_out_321211.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_22 and arg_13_1.time_ < var_16_14 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321211004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) and arg_17_1.var_.characterEffect10104ui_story == nil then
				arg_17_1.var_.characterEffect10104ui_story = arg_17_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) then
				if arg_17_1.var_.characterEffect10104ui_story and not isNil(arg_17_1.actors_["10104ui_story"]) then
					arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10104ui_story"]) and arg_17_1.var_.characterEffect10104ui_story then
				arg_17_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(321211004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 14 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 14)

				if (14 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 14)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321211005
		arg_21_1.duration_ = 10.53

		local var_21_0 = {
			zh = 8.266,
			ja = 10.533
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
				arg_21_0:Play321211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) and arg_21_1.var_.characterEffect10104ui_story == nil then
				arg_21_1.var_.characterEffect10104ui_story = arg_21_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) then
				if arg_21_1.var_.characterEffect10104ui_story and not isNil(arg_21_1.actors_["10104ui_story"]) then
					arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10104ui_story"]) and arg_21_1.var_.characterEffect10104ui_story then
				arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_24_2 = 0
			local var_24_3 = 0.85

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(321211005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 34 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 34)

				if (34 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 34)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211005", "story_v_out_321211.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211005", "story_v_out_321211.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_321211", "321211005", "story_v_out_321211.awb")

						arg_21_1:RecordAudio("321211005", var_24_9)
						arg_21_1:RecordAudio("321211005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321211", "321211005", "story_v_out_321211.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321211", "321211005", "story_v_out_321211.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321211006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10104ui_story"]) and arg_25_1.var_.characterEffect10104ui_story == nil then
				arg_25_1.var_.characterEffect10104ui_story = arg_25_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10104ui_story"]) then
				if arg_25_1.var_.characterEffect10104ui_story and not isNil(arg_25_1.actors_["10104ui_story"]) then
					arg_25_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10104ui_story"]) and arg_25_1.var_.characterEffect10104ui_story then
				arg_25_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(321211006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 49 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 49)

				if (49 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 49)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321211007
		arg_29_1.duration_ = 2.1

		local var_29_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_29_0:Play321211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10104ui_story = arg_29_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).z)
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles = arg_29_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_29_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10104ui_story"].transform.position).z)
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10104ui_story"].transform.localEulerAngles = arg_29_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10104ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10104ui_story == nil then
				arg_29_1.var_.characterEffect10104ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10104ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10104ui_story then
				arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(321211007)
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

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211007", "story_v_out_321211.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211007", "story_v_out_321211.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_321211", "321211007", "story_v_out_321211.awb")

						arg_29_1:RecordAudio("321211007", var_32_11)
						arg_29_1:RecordAudio("321211007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321211", "321211007", "story_v_out_321211.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321211", "321211007", "story_v_out_321211.awb")
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
				actorName = "10104ui_story",
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
	Play321211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321211008
		arg_33_1.duration_ = 2.13

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_33_0:Play321211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10104ui_story = arg_33_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).z)
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles = arg_33_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10104ui_story"].transform.position).z)
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10104ui_story"].transform.localEulerAngles = arg_33_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1284ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1284ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0, -0.985, -6.22)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = arg_33_1.actors_["1284ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1284ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1284ui_story then
				arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_36_6 = arg_33_1.actors_["10104ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10104ui_story == nil then
				arg_33_1.var_.characterEffect10104ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 and not isNil(var_36_6) then
				if arg_33_1.var_.characterEffect10104ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_7)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10104ui_story then
				arg_33_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_8 = 0
			local var_36_9 = 0.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(321211008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 3 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 3)

				if (3 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 3)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211008", "story_v_out_321211.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211008", "story_v_out_321211.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_321211", "321211008", "story_v_out_321211.awb")

						arg_33_1:RecordAudio("321211008", var_36_15)
						arg_33_1:RecordAudio("321211008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321211", "321211008", "story_v_out_321211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321211", "321211008", "story_v_out_321211.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321211009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = arg_37_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) then
				if arg_37_1.var_.characterEffect1284ui_story and not isNil(arg_37_1.actors_["1284ui_story"]) then
					arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story then
				arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(321211009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 2 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 2)

				if (2 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 2)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321211010
		arg_41_1.duration_ = 5.4

		local var_41_0 = {
			zh = 5.4,
			ja = 3.666
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
				arg_41_0:Play321211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10104ui_story"]) and arg_41_1.var_.characterEffect10104ui_story == nil then
				arg_41_1.var_.characterEffect10104ui_story = arg_41_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10104ui_story"]) then
				if arg_41_1.var_.characterEffect10104ui_story and not isNil(arg_41_1.actors_["10104ui_story"]) then
					arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10104ui_story"]) and arg_41_1.var_.characterEffect10104ui_story then
				arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["10104ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = var_44_2.localPosition
			end

			local var_44_3 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_41_1.time_ - 0) / var_44_3)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			local var_44_4 = arg_41_1.actors_["1284ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1284ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(0, 100, 0)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["1284ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1284ui_story == nil then
				arg_41_1.var_.characterEffect1284ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 and not isNil(var_44_6) then
				if arg_41_1.var_.characterEffect1284ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_7)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1284ui_story then
				arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_8 = 0
			local var_44_9 = 0.475

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(321211010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 19 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 19)

				if (19 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 19)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211010", "story_v_out_321211.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211010", "story_v_out_321211.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_321211", "321211010", "story_v_out_321211.awb")

						arg_41_1:RecordAudio("321211010", var_44_15)
						arg_41_1:RecordAudio("321211010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321211", "321211010", "story_v_out_321211.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321211", "321211010", "story_v_out_321211.awb")
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
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321211011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play321211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = arg_45_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) then
				if arg_45_1.var_.characterEffect10104ui_story and not isNil(arg_45_1.actors_["10104ui_story"]) then
					arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10104ui_story"]) and arg_45_1.var_.characterEffect10104ui_story then
				arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(321211011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 15 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 15)

				if (15 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 15)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321211012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(321211012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 38 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 38)

				if (38 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 38)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321211013
		arg_53_1.duration_ = 3.7

		local var_53_0 = {
			zh = 2.766,
			ja = 3.7
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
				arg_53_0:Play321211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10104ui_story = arg_53_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).z)
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles = arg_53_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_53_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10104ui_story"].transform.position).z)
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10104ui_story"].transform.localEulerAngles = arg_53_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10104ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10104ui_story == nil then
				arg_53_1.var_.characterEffect10104ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10104ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10104ui_story then
				arg_53_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(321211013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)

				if (13 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 13)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211013", "story_v_out_321211.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211013", "story_v_out_321211.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_321211", "321211013", "story_v_out_321211.awb")

						arg_53_1:RecordAudio("321211013", var_56_11)
						arg_53_1:RecordAudio("321211013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321211", "321211013", "story_v_out_321211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321211", "321211013", "story_v_out_321211.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321211014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) and arg_57_1.var_.characterEffect10104ui_story == nil then
				arg_57_1.var_.characterEffect10104ui_story = arg_57_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) then
				if arg_57_1.var_.characterEffect10104ui_story and not isNil(arg_57_1.actors_["10104ui_story"]) then
					arg_57_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10104ui_story"]) and arg_57_1.var_.characterEffect10104ui_story then
				arg_57_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.65

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(321211014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 26 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 26)

				if (26 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 26)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321211015
		arg_61_1.duration_ = 13

		local var_61_0 = {
			zh = 7.5,
			ja = 13
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
				arg_61_0:Play321211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10104ui_story"]) and arg_61_1.var_.characterEffect10104ui_story == nil then
				arg_61_1.var_.characterEffect10104ui_story = arg_61_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10104ui_story"]) then
				if arg_61_1.var_.characterEffect10104ui_story and not isNil(arg_61_1.actors_["10104ui_story"]) then
					arg_61_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10104ui_story"]) and arg_61_1.var_.characterEffect10104ui_story then
				arg_61_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_64_2 = 0
			local var_64_3 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(321211015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 35 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 35)

				if (35 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 35)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211015", "story_v_out_321211.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211015", "story_v_out_321211.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_321211", "321211015", "story_v_out_321211.awb")

						arg_61_1:RecordAudio("321211015", var_64_9)
						arg_61_1:RecordAudio("321211015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321211", "321211015", "story_v_out_321211.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321211", "321211015", "story_v_out_321211.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321211016
		arg_65_1.duration_ = 16.93

		local var_65_0 = {
			zh = 11.5,
			ja = 16.933
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
				arg_65_0:Play321211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(321211016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 52 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 52)

				if (52 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 52)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211016", "story_v_out_321211.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211016", "story_v_out_321211.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_321211", "321211016", "story_v_out_321211.awb")

						arg_65_1:RecordAudio("321211016", var_68_6)
						arg_65_1:RecordAudio("321211016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321211", "321211016", "story_v_out_321211.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321211", "321211016", "story_v_out_321211.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321211017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) and arg_69_1.var_.characterEffect10104ui_story == nil then
				arg_69_1.var_.characterEffect10104ui_story = arg_69_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) then
				if arg_69_1.var_.characterEffect10104ui_story and not isNil(arg_69_1.actors_["10104ui_story"]) then
					arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10104ui_story"]) and arg_69_1.var_.characterEffect10104ui_story then
				arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(321211017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)

				if (15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)) > 0 and var_72_2 < var_72_5 then
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

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play321211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321211018
		arg_73_1.duration_ = 2.3

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_73_0:Play321211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10104ui_story = arg_73_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).z)
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles = arg_73_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_73_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10104ui_story"].transform.position).z)
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10104ui_story"].transform.localEulerAngles = arg_73_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10104ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10104ui_story == nil then
				arg_73_1.var_.characterEffect10104ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10104ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10104ui_story then
				arg_73_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_76_4 = 0
			local var_76_5 = 0.225

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(321211018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 9 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 9)

				if (9 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 9)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211018", "story_v_out_321211.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211018", "story_v_out_321211.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_321211", "321211018", "story_v_out_321211.awb")

						arg_73_1:RecordAudio("321211018", var_76_11)
						arg_73_1:RecordAudio("321211018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321211", "321211018", "story_v_out_321211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321211", "321211018", "story_v_out_321211.awb")
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

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321211019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play321211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10104ui_story"]) and arg_77_1.var_.characterEffect10104ui_story == nil then
				arg_77_1.var_.characterEffect10104ui_story = arg_77_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10104ui_story"]) then
				if arg_77_1.var_.characterEffect10104ui_story and not isNil(arg_77_1.actors_["10104ui_story"]) then
					arg_77_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10104ui_story"]) and arg_77_1.var_.characterEffect10104ui_story then
				arg_77_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 1.6

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(321211019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 64 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 64)

				if (64 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 64)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321211020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321211020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play321211021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(321211020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 11 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 11)

				if (11 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 11)) > 0 and var_84_0 < var_84_3 then
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
	Play321211021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321211021
		arg_85_1.duration_ = 13.43

		local var_85_0 = {
			zh = 9.466,
			ja = 13.433
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
				arg_85_0:Play321211022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10104ui_story"]) and arg_85_1.var_.characterEffect10104ui_story == nil then
				arg_85_1.var_.characterEffect10104ui_story = arg_85_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10104ui_story"]) then
				if arg_85_1.var_.characterEffect10104ui_story and not isNil(arg_85_1.actors_["10104ui_story"]) then
					arg_85_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10104ui_story"]) and arg_85_1.var_.characterEffect10104ui_story then
				arg_85_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_88_2 = 0
			local var_88_3 = 1.1

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(321211021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 44 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 44)

				if (44 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 44)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211021", "story_v_out_321211.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211021", "story_v_out_321211.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_321211", "321211021", "story_v_out_321211.awb")

						arg_85_1:RecordAudio("321211021", var_88_9)
						arg_85_1:RecordAudio("321211021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321211", "321211021", "story_v_out_321211.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321211", "321211021", "story_v_out_321211.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play321211022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321211022
		arg_89_1.duration_ = 13.53

		local var_89_0 = {
			zh = 8.1,
			ja = 13.533
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
				arg_89_0:Play321211023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.975

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(321211022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 39)

				if (39 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 39)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211022", "story_v_out_321211.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211022", "story_v_out_321211.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_321211", "321211022", "story_v_out_321211.awb")

						arg_89_1:RecordAudio("321211022", var_92_6)
						arg_89_1:RecordAudio("321211022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321211", "321211022", "story_v_out_321211.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321211", "321211022", "story_v_out_321211.awb")
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
	Play321211023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321211023
		arg_93_1.duration_ = 6.1

		local var_93_0 = {
			zh = 3.933,
			ja = 6.1
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
				arg_93_0:Play321211024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10104ui_story = arg_93_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).z)
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles = arg_93_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_93_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10104ui_story"].transform.position).z)
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10104ui_story"].transform.localEulerAngles = arg_93_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_96_1 = 0
			local var_96_2 = 0.575

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(321211023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 23 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 23)

				if (23 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 23)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211023", "story_v_out_321211.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_out_321211", "321211023", "story_v_out_321211.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_321211", "321211023", "story_v_out_321211.awb")

						arg_93_1:RecordAudio("321211023", var_96_8)
						arg_93_1:RecordAudio("321211023", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321211", "321211023", "story_v_out_321211.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321211", "321211023", "story_v_out_321211.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321211024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321211024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321211025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10104ui_story"]) and arg_97_1.var_.characterEffect10104ui_story == nil then
				arg_97_1.var_.characterEffect10104ui_story = arg_97_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10104ui_story"]) then
				if arg_97_1.var_.characterEffect10104ui_story and not isNil(arg_97_1.actors_["10104ui_story"]) then
					arg_97_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10104ui_story"]) and arg_97_1.var_.characterEffect10104ui_story then
				arg_97_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.475

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

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(321211024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 19 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 19)

				if (19 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 19)) > 0 and var_100_2 < var_100_5 then
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
	Play321211025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321211025
		arg_101_1.duration_ = 2.07

		local var_101_0 = {
			zh = 1.666,
			ja = 2.066
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
				arg_101_0:Play321211026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10104ui_story"]) and arg_101_1.var_.characterEffect10104ui_story == nil then
				arg_101_1.var_.characterEffect10104ui_story = arg_101_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10104ui_story"]) then
				if arg_101_1.var_.characterEffect10104ui_story and not isNil(arg_101_1.actors_["10104ui_story"]) then
					arg_101_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10104ui_story"]) and arg_101_1.var_.characterEffect10104ui_story then
				arg_101_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_104_2 = 0
			local var_104_3 = 0.175

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(321211025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 7 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 7)

				if (7 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 7)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211025", "story_v_out_321211.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211025", "story_v_out_321211.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_321211", "321211025", "story_v_out_321211.awb")

						arg_101_1:RecordAudio("321211025", var_104_9)
						arg_101_1:RecordAudio("321211025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321211", "321211025", "story_v_out_321211.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321211", "321211025", "story_v_out_321211.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321211026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321211026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321211027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10104ui_story"]) and arg_105_1.var_.characterEffect10104ui_story == nil then
				arg_105_1.var_.characterEffect10104ui_story = arg_105_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10104ui_story"]) then
				if arg_105_1.var_.characterEffect10104ui_story and not isNil(arg_105_1.actors_["10104ui_story"]) then
					arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10104ui_story"]) and arg_105_1.var_.characterEffect10104ui_story then
				arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(321211026).content)

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
	Play321211027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321211027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321211028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10104ui_story = arg_109_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).z)
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles = arg_109_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10104ui_story"].transform.position).z)
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10104ui_story"].transform.localEulerAngles = arg_109_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_112_1 = 0
			local var_112_2 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321211027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)

				if (14 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 14)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321211028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321211028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321211029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0.034000001847744 < arg_113_1.time_ and arg_113_1.time_ <= 0.034000001847744 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_data", "")
			end

			local var_116_1 = 0
			local var_116_2 = 1.5

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

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(321211028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 60 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 60)

				if (60 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 60)) > 0 and var_116_2 < var_116_5 then
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
	Play321211029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321211029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321211030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.05

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(321211029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 42 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 42)

				if (42 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 42)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321211030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321211030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play321211031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_124_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_121_1.bgmTxt_.text ~= var_124_2 and arg_121_1.bgmTxt_.text ~= "" then
						if arg_121_1.bgmTxt2_.text ~= "" then
							arg_121_1.bgmTxt_.text = arg_121_1.bgmTxt2_.text
						end

						arg_121_1.bgmTxt2_.text = var_124_2

						arg_121_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_121_1.bgmTxt_.text = var_124_2
						arg_121_1.bgmTxt2_.text = var_124_2
					end

					if arg_121_1.bgmTimer then
						arg_121_1.bgmTimer:Stop()

						arg_121_1.bgmTimer = nil
					end

					if arg_121_1.settingData.show_music_name == 1 then
						arg_121_1.musicController:SetSelectedState("show")
						arg_121_1.musicAnimator_:Play("open", 0, 0)

						if arg_121_1.settingData.music_time ~= 0 then
							arg_121_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_121_1.settingData.music_time), function()
								if arg_121_1 == nil or isNil(arg_121_1.bgmTxt_) then
									return
								end

								arg_121_1.musicController:SetSelectedState("hide")
								arg_121_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_124_3 = 0
			local var_124_4 = 0.45

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(321211030).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 18 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 18)

				if (18 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 18)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play321211031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 321211031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play321211032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.5

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(321211031).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 20 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 20)

				if (20 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 20)) > 0 and var_129_0 < var_129_3 then
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
	Play321211032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 321211032
		arg_130_1.duration_ = 5.33

		local var_130_0 = {
			zh = 5.333,
			ja = 4.666
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play321211033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if arg_130_1.bgs_.L15g == nil then
				local var_133_0 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15g")
				var_133_0.name = "L15g"
				var_133_0.transform.parent = arg_130_1.stage_.transform
				var_133_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_.L15g = var_133_0
			end

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= 2 + arg_133_0 then
				local var_133_1 = arg_130_1.bgs_.L15g

				arg_130_1.bgs_.L15g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_133_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_2 = var_133_1:GetComponent("SpriteRenderer")

				if var_133_2 and var_133_2.sprite then
					local var_133_3 = 2 * (var_133_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_133_1.transform.localScale = Vector3.New(var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "L15g" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_4 = 0

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			if arg_130_1.time_ >= var_133_4 + 0.3 and arg_130_1.time_ < var_133_4 + 0.3 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_5 = 0

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_6 = 2

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 then
				local var_133_7 = Color.New(0, 0, 0)

				var_133_7.a = Mathf.Lerp(0, 1, (arg_130_1.time_ - var_133_5) / var_133_6)
				arg_130_1.mask_.color = var_133_7
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 then
				local var_133_8 = Color.New(0, 0, 0)

				var_133_8.a = 1
				arg_130_1.mask_.color = var_133_8
			end

			local var_133_9 = 2

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_10 = 2

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_10 then
				local var_133_11 = Color.New(0, 0, 0)

				var_133_11.a = Mathf.Lerp(1, 0, (arg_130_1.time_ - var_133_9) / var_133_10)
				arg_130_1.mask_.color = var_133_11
			end

			if arg_130_1.time_ >= var_133_9 + var_133_10 and arg_130_1.time_ < var_133_9 + var_133_10 + arg_133_0 then
				local var_133_12 = Color.New(0, 0, 0)

				arg_130_1.mask_.enabled = false
				var_133_12.a = 0
				arg_130_1.mask_.color = var_133_12
			end

			local var_133_13 = "1011ui_story"

			if arg_130_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_133_14 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_130_1.stage_.transform)

				var_133_14.name = var_133_13
				var_133_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_[var_133_13] = var_133_14

				local var_133_15 = var_133_14:GetComponentInChildren(typeof(CharacterEffect))

				var_133_15.enabled = true

				local var_133_16 = GameObjectTools.GetOrAddComponent(var_133_14, typeof(DynamicBoneHelper))

				if var_133_16 then
					var_133_16:EnableDynamicBone(false)
				end

				arg_130_1:ShowWeapon(var_133_15.transform, false)

				arg_130_1.var_[var_133_13 .. "Animator"] = var_133_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_130_1.var_[var_133_13 .. "Animator"].applyRootMotion = true
				arg_130_1.var_[var_133_13 .. "LipSync"] = var_133_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_133_17 = arg_130_1.actors_["1011ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_17) and arg_130_1.var_.characterEffect1011ui_story == nil then
				arg_130_1.var_.characterEffect1011ui_story = var_133_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_18 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_18 and not isNil(var_133_17) then
				if arg_130_1.var_.characterEffect1011ui_story and not isNil(var_133_17) then
					arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_18 and arg_130_1.time_ < 0 + var_133_18 + arg_133_0 and not isNil(var_133_17) and arg_130_1.var_.characterEffect1011ui_story then
				arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_133_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_22 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_22

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_22
						arg_130_1.bgmTxt2_.text = var_133_22
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.83333333333333 < arg_130_1.time_ and arg_130_1.time_ <= 1.83333333333333 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_133_25 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_25 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_25

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_25
						arg_130_1.bgmTxt2_.text = var_133_25
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_26 = 3.9
			local var_133_27 = 0.1

			if 3.9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_28 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_28:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_130_1.dialogCg_.alpha = arg_136_0
				end))
				var_133_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_29 = arg_130_1:GetWordFromCfg(321211032)
				local var_133_30 = arg_130_1:FormatText(var_133_29.content)

				arg_130_1.text_.text = var_133_30

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_32 = 4 <= 0 and var_133_27 or var_133_27 * (utf8.len(var_133_30) / 4)

				if (4 <= 0 and var_133_27 or var_133_27 * (utf8.len(var_133_30) / 4)) > 0 and var_133_27 < var_133_32 then
					arg_130_1.talkMaxDuration = var_133_32
					var_133_26 = var_133_26 + 0.3

					if var_133_32 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_32 + var_133_26
					end
				end

				arg_130_1.text_.text = var_133_30
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211032", "story_v_out_321211.awb") ~= 0 then
					local var_133_33 = manager.audio:GetVoiceLength("story_v_out_321211", "321211032", "story_v_out_321211.awb") / 1000

					if var_133_33 + var_133_26 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_33 + var_133_26
					end

					if var_133_29.prefab_name ~= "" and arg_130_1.actors_[var_133_29.prefab_name] ~= nil then
						local var_133_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_29.prefab_name].transform, "story_v_out_321211", "321211032", "story_v_out_321211.awb")

						arg_130_1:RecordAudio("321211032", var_133_34)
						arg_130_1:RecordAudio("321211032", var_133_34)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_321211", "321211032", "story_v_out_321211.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_321211", "321211032", "story_v_out_321211.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_35 = var_133_26 + 0.3
			local var_133_36 = math.max(var_133_27, arg_130_1.talkMaxDuration)

			if var_133_26 + 0.3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_35 + var_133_36 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_35) / var_133_36

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_35 + var_133_36 and arg_130_1.time_ < var_133_35 + var_133_36 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play321211033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 321211033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play321211034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1011ui_story"]) and arg_138_1.var_.characterEffect1011ui_story == nil then
				arg_138_1.var_.characterEffect1011ui_story = arg_138_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1011ui_story"]) then
				if arg_138_1.var_.characterEffect1011ui_story and not isNil(arg_138_1.actors_["1011ui_story"]) then
					arg_138_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1011ui_story"]) and arg_138_1.var_.characterEffect1011ui_story then
				arg_138_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.9 < arg_138_1.time_ and arg_138_1.time_ <= 0.9 + arg_141_0 then
				arg_138_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_brake", "")
			end

			local var_141_2 = 0
			local var_141_3 = 1.525

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_4 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(321211033).content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 61 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_4) / 61)

				if (61 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_4) / 61)) > 0 and var_141_3 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_2
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_3, arg_138_1.talkMaxDuration)

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_2) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_2 + var_141_7 and arg_138_1.time_ < var_141_2 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play321211034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 321211034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play321211035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 1.025

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(321211034).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 41 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 41)

				if (41 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 41)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play321211035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 321211035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play321211036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.7

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(321211035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 28 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 28)

				if (28 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 28)) > 0 and var_149_0 < var_149_3 then
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
	Play321211036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 321211036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play321211037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 1.375

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(321211036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 55 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 55)

				if (55 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 55)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play321211037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 321211037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play321211038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.125

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(321211037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 45 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 45)

				if (45 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 45)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play321211038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 321211038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play321211039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.925

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(321211038).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 37 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 37)

				if (37 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 37)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play321211039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 321211039
		arg_162_1.duration_ = 2

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play321211040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1011ui_story = arg_162_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).z)
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles = arg_162_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_162_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1011ui_story"].transform.position).z)
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1011ui_story"].transform.localEulerAngles = arg_162_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["1011ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1011ui_story == nil then
				arg_162_1.var_.characterEffect1011ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect1011ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1011ui_story then
				arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_165_4 = 0
			local var_165_5 = 0.1

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(321211039)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 4 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 4)

				if (4 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 4)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211039", "story_v_out_321211.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211039", "story_v_out_321211.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_321211", "321211039", "story_v_out_321211.awb")

						arg_162_1:RecordAudio("321211039", var_165_11)
						arg_162_1:RecordAudio("321211039", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_321211", "321211039", "story_v_out_321211.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_321211", "321211039", "story_v_out_321211.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play321211040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 321211040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play321211041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1011ui_story"]) and arg_166_1.var_.characterEffect1011ui_story == nil then
				arg_166_1.var_.characterEffect1011ui_story = arg_166_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1011ui_story"]) then
				if arg_166_1.var_.characterEffect1011ui_story and not isNil(arg_166_1.actors_["1011ui_story"]) then
					arg_166_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1011ui_story"]) and arg_166_1.var_.characterEffect1011ui_story then
				arg_166_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.825

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(321211040).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 33 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 33)

				if (33 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 33)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play321211041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 321211041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play321211042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1011ui_story = arg_170_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_173_1 = 0
			local var_173_2 = 1.025

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(321211041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 41 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 41)

				if (41 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 41)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play321211042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 321211042
		arg_174_1.duration_ = 4.73

		local var_174_0 = {
			zh = 2.7,
			ja = 4.733
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play321211043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.3

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:GetWordFromCfg(321211042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 12 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 12)

				if (12 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 12)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211042", "story_v_out_321211.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211042", "story_v_out_321211.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_321211", "321211042", "story_v_out_321211.awb")

						arg_174_1:RecordAudio("321211042", var_177_6)
						arg_174_1:RecordAudio("321211042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_321211", "321211042", "story_v_out_321211.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_321211", "321211042", "story_v_out_321211.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play321211043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 321211043
		arg_178_1.duration_ = 7.13

		local var_178_0 = {
			zh = 7.133,
			ja = 6.1
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play321211044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1011ui_story = arg_178_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).z)
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles = arg_178_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_178_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1011ui_story"].transform.position).z)
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1011ui_story"].transform.localEulerAngles = arg_178_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1011ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1011ui_story == nil then
				arg_178_1.var_.characterEffect1011ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1011ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1011ui_story then
				arg_178_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			local var_181_4 = 0
			local var_181_5 = 0.975

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(321211043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 39 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 39)

				if (39 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 39)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211043", "story_v_out_321211.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211043", "story_v_out_321211.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_321211", "321211043", "story_v_out_321211.awb")

						arg_178_1:RecordAudio("321211043", var_181_11)
						arg_178_1:RecordAudio("321211043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_321211", "321211043", "story_v_out_321211.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_321211", "321211043", "story_v_out_321211.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play321211044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 321211044
		arg_182_1.duration_ = 5.4

		local var_182_0 = {
			zh = 3.3,
			ja = 5.4
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play321211045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if arg_182_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_185_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_182_1.stage_.transform)

				var_185_0.name = "404001ui_story"
				var_185_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.actors_["404001ui_story"] = var_185_0

				local var_185_1 = var_185_0:GetComponentInChildren(typeof(CharacterEffect))

				var_185_1.enabled = true

				local var_185_2 = GameObjectTools.GetOrAddComponent(var_185_0, typeof(DynamicBoneHelper))

				if var_185_2 then
					var_185_2:EnableDynamicBone(false)
				end

				arg_182_1:ShowWeapon(var_185_1.transform, false)

				arg_182_1.var_["404001ui_story" .. "Animator"] = var_185_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_182_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_182_1.var_["404001ui_story" .. "LipSync"] = var_185_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_185_3 = arg_182_1.actors_["404001ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos404001ui_story = var_185_3.localPosition
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_3.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_182_1.time_ - 0) / var_185_4)
				var_185_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_3.position).x, (manager.ui.mainCamera.transform.position - var_185_3.position).y, (manager.ui.mainCamera.transform.position - var_185_3.position).z)
				var_185_3.localEulerAngles.z = 0
				var_185_3.localEulerAngles.x = 0
				var_185_3.localEulerAngles = var_185_3.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_185_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_3.position).x, (manager.ui.mainCamera.transform.position - var_185_3.position).y, (manager.ui.mainCamera.transform.position - var_185_3.position).z)
				var_185_3.localEulerAngles.z = 0
				var_185_3.localEulerAngles.x = 0
				var_185_3.localEulerAngles = var_185_3.localEulerAngles
			end

			local var_185_5 = arg_182_1.actors_["1011ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1011ui_story = var_185_5.localPosition
			end

			local var_185_6 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_6 then
				var_185_5.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_6)
				var_185_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_5.position).x, (manager.ui.mainCamera.transform.position - var_185_5.position).y, (manager.ui.mainCamera.transform.position - var_185_5.position).z)
				var_185_5.localEulerAngles.z = 0
				var_185_5.localEulerAngles.x = 0
				var_185_5.localEulerAngles = var_185_5.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_6 and arg_182_1.time_ < 0 + var_185_6 + arg_185_0 then
				var_185_5.localPosition = Vector3.New(0, 100, 0)
				var_185_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_5.position).x, (manager.ui.mainCamera.transform.position - var_185_5.position).y, (manager.ui.mainCamera.transform.position - var_185_5.position).z)
				var_185_5.localEulerAngles.z = 0
				var_185_5.localEulerAngles.x = 0
				var_185_5.localEulerAngles = var_185_5.localEulerAngles
			end

			local var_185_7 = arg_182_1.actors_["404001ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_7) and arg_182_1.var_.characterEffect404001ui_story == nil then
				arg_182_1.var_.characterEffect404001ui_story = var_185_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_8 and not isNil(var_185_7) then
				if arg_182_1.var_.characterEffect404001ui_story and not isNil(var_185_7) then
					arg_182_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_8 and arg_182_1.time_ < 0 + var_185_8 + arg_185_0 and not isNil(var_185_7) and arg_182_1.var_.characterEffect404001ui_story then
				arg_182_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_185_10 = arg_182_1.actors_["1011ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect1011ui_story == nil then
				arg_182_1.var_.characterEffect1011ui_story = var_185_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_11 and not isNil(var_185_10) then
				if arg_182_1.var_.characterEffect1011ui_story and not isNil(var_185_10) then
					arg_182_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_11)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_11 and arg_182_1.time_ < 0 + var_185_11 + arg_185_0 and not isNil(var_185_10) and arg_182_1.var_.characterEffect1011ui_story then
				arg_182_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_185_12 = 0
			local var_185_13 = 0.4

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(321211044)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 16 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 16)

				if (16 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 16)) > 0 and var_185_13 < var_185_17 then
					arg_182_1.talkMaxDuration = var_185_17

					if var_185_17 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_17 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211044", "story_v_out_321211.awb") ~= 0 then
					local var_185_18 = manager.audio:GetVoiceLength("story_v_out_321211", "321211044", "story_v_out_321211.awb") / 1000

					if var_185_18 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_12
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_321211", "321211044", "story_v_out_321211.awb")

						arg_182_1:RecordAudio("321211044", var_185_19)
						arg_182_1:RecordAudio("321211044", var_185_19)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_321211", "321211044", "story_v_out_321211.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_321211", "321211044", "story_v_out_321211.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_20 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_20 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_20

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_20 and arg_182_1.time_ < var_185_12 + var_185_20 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play321211045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 321211045
		arg_186_1.duration_ = 3.37

		local var_186_0 = {
			zh = 2.666,
			ja = 3.366
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play321211046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos404001ui_story = arg_186_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).z)
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles = arg_186_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).z)
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles = arg_186_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1011ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1011ui_story = var_189_1.localPosition
			end

			local var_189_2 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 then
				var_189_1.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_186_1.time_ - 0) / var_189_2)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 then
				var_189_1.localPosition = Vector3.New(0, -0.71, -6)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			local var_189_3 = arg_186_1.actors_["1011ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect1011ui_story == nil then
				arg_186_1.var_.characterEffect1011ui_story = var_189_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_4 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 and not isNil(var_189_3) then
				if arg_186_1.var_.characterEffect1011ui_story and not isNil(var_189_3) then
					arg_186_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect1011ui_story then
				arg_186_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_189_6 = arg_186_1.actors_["404001ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect404001ui_story == nil then
				arg_186_1.var_.characterEffect404001ui_story = var_189_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_7 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 and not isNil(var_189_6) then
				if arg_186_1.var_.characterEffect404001ui_story and not isNil(var_189_6) then
					arg_186_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_186_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_7)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect404001ui_story then
				arg_186_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_186_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			local var_189_8 = 0
			local var_189_9 = 0.4

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:GetWordFromCfg(321211045)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 16 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 16)

				if (16 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 16)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211045", "story_v_out_321211.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211045", "story_v_out_321211.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_out_321211", "321211045", "story_v_out_321211.awb")

						arg_186_1:RecordAudio("321211045", var_189_15)
						arg_186_1:RecordAudio("321211045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_321211", "321211045", "story_v_out_321211.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_321211", "321211045", "story_v_out_321211.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play321211046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 321211046
		arg_190_1.duration_ = 6.3

		local var_190_0 = {
			zh = 4.466,
			ja = 6.3
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play321211047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1011ui_story"]) and arg_190_1.var_.characterEffect1011ui_story == nil then
				arg_190_1.var_.characterEffect1011ui_story = arg_190_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1011ui_story"]) then
				if arg_190_1.var_.characterEffect1011ui_story and not isNil(arg_190_1.actors_["1011ui_story"]) then
					arg_190_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1011ui_story"]) and arg_190_1.var_.characterEffect1011ui_story then
				arg_190_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.625

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(321211046)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_6 = 25 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_4) / 25)

				if (25 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_4) / 25)) > 0 and var_193_2 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211046", "story_v_out_321211.awb") ~= 0 then
					local var_193_7 = manager.audio:GetVoiceLength("story_v_out_321211", "321211046", "story_v_out_321211.awb") / 1000

					if var_193_7 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_1
					end

					if var_193_3.prefab_name ~= "" and arg_190_1.actors_[var_193_3.prefab_name] ~= nil then
						local var_193_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_3.prefab_name].transform, "story_v_out_321211", "321211046", "story_v_out_321211.awb")

						arg_190_1:RecordAudio("321211046", var_193_8)
						arg_190_1:RecordAudio("321211046", var_193_8)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_321211", "321211046", "story_v_out_321211.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_321211", "321211046", "story_v_out_321211.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_9 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_9 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_9

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_9 and arg_190_1.time_ < var_193_1 + var_193_9 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play321211047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 321211047
		arg_194_1.duration_ = 2.9

		local var_194_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play321211048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["404001ui_story"]) and arg_194_1.var_.characterEffect404001ui_story == nil then
				arg_194_1.var_.characterEffect404001ui_story = arg_194_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["404001ui_story"]) then
				if arg_194_1.var_.characterEffect404001ui_story and not isNil(arg_194_1.actors_["404001ui_story"]) then
					arg_194_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["404001ui_story"]) and arg_194_1.var_.characterEffect404001ui_story then
				arg_194_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_197_2 = arg_194_1.actors_["404001ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos404001ui_story = var_197_2.localPosition
			end

			local var_197_3 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 then
				var_197_2.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_194_1.time_ - 0) / var_197_3)
				var_197_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_2.position).x, (manager.ui.mainCamera.transform.position - var_197_2.position).y, (manager.ui.mainCamera.transform.position - var_197_2.position).z)
				var_197_2.localEulerAngles.z = 0
				var_197_2.localEulerAngles.x = 0
				var_197_2.localEulerAngles = var_197_2.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 then
				var_197_2.localPosition = Vector3.New(0, -1.55, -5.5)
				var_197_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_2.position).x, (manager.ui.mainCamera.transform.position - var_197_2.position).y, (manager.ui.mainCamera.transform.position - var_197_2.position).z)
				var_197_2.localEulerAngles.z = 0
				var_197_2.localEulerAngles.x = 0
				var_197_2.localEulerAngles = var_197_2.localEulerAngles
			end

			local var_197_4 = arg_194_1.actors_["1011ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1011ui_story = var_197_4.localPosition
			end

			local var_197_5 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_5 then
				var_197_4.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_5)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_5 and arg_194_1.time_ < 0 + var_197_5 + arg_197_0 then
				var_197_4.localPosition = Vector3.New(0, 100, 0)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			local var_197_6 = arg_194_1.actors_["1011ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1011ui_story == nil then
				arg_194_1.var_.characterEffect1011ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_7 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 and not isNil(var_197_6) then
				if arg_194_1.var_.characterEffect1011ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_7)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1011ui_story then
				arg_194_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_8 = 0
			local var_197_9 = 0.125

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_8 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_10 = arg_194_1:GetWordFromCfg(321211047)
				local var_197_11 = arg_194_1:FormatText(var_197_10.content)

				arg_194_1.text_.text = var_197_11

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_13 = 5 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 5)

				if (5 <= 0 and var_197_9 or var_197_9 * (utf8.len(var_197_11) / 5)) > 0 and var_197_9 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_8
					end
				end

				arg_194_1.text_.text = var_197_11
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211047", "story_v_out_321211.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211047", "story_v_out_321211.awb") / 1000

					if var_197_14 + var_197_8 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_8
					end

					if var_197_10.prefab_name ~= "" and arg_194_1.actors_[var_197_10.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_10.prefab_name].transform, "story_v_out_321211", "321211047", "story_v_out_321211.awb")

						arg_194_1:RecordAudio("321211047", var_197_15)
						arg_194_1:RecordAudio("321211047", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_321211", "321211047", "story_v_out_321211.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_321211", "321211047", "story_v_out_321211.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_9, arg_194_1.talkMaxDuration)

			if var_197_8 <= arg_194_1.time_ and arg_194_1.time_ < var_197_8 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_8) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_8 + var_197_16 and arg_194_1.time_ < var_197_8 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play321211048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 321211048
		arg_198_1.duration_ = 9.7

		local var_198_0 = {
			zh = 7.133,
			ja = 9.7
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play321211049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["404001ui_story"]) and arg_198_1.var_.characterEffect404001ui_story == nil then
				arg_198_1.var_.characterEffect404001ui_story = arg_198_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["404001ui_story"]) then
				if arg_198_1.var_.characterEffect404001ui_story and not isNil(arg_198_1.actors_["404001ui_story"]) then
					arg_198_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_198_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["404001ui_story"]) and arg_198_1.var_.characterEffect404001ui_story then
				arg_198_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_198_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.975

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:GetWordFromCfg(321211048)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 39 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_4) / 39)

				if (39 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_4) / 39)) > 0 and var_201_2 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211048", "story_v_out_321211.awb") ~= 0 then
					local var_201_7 = manager.audio:GetVoiceLength("story_v_out_321211", "321211048", "story_v_out_321211.awb") / 1000

					if var_201_7 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_1
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_321211", "321211048", "story_v_out_321211.awb")

						arg_198_1:RecordAudio("321211048", var_201_8)
						arg_198_1:RecordAudio("321211048", var_201_8)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_321211", "321211048", "story_v_out_321211.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_321211", "321211048", "story_v_out_321211.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_9 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_9 and arg_198_1.time_ < var_201_1 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play321211049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 321211049
		arg_202_1.duration_ = 10.63

		local var_202_0 = {
			zh = 5.8,
			ja = 10.633
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play321211050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.85

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(321211049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 34 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 34)

				if (34 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 34)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211049", "story_v_out_321211.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211049", "story_v_out_321211.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_321211", "321211049", "story_v_out_321211.awb")

						arg_202_1:RecordAudio("321211049", var_205_6)
						arg_202_1:RecordAudio("321211049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_321211", "321211049", "story_v_out_321211.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_321211", "321211049", "story_v_out_321211.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play321211050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 321211050
		arg_206_1.duration_ = 3.67

		local var_206_0 = {
			zh = 2,
			ja = 3.666
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play321211051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) and arg_206_1.var_.characterEffect404001ui_story == nil then
				arg_206_1.var_.characterEffect404001ui_story = arg_206_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) then
				if arg_206_1.var_.characterEffect404001ui_story and not isNil(arg_206_1.actors_["404001ui_story"]) then
					arg_206_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) and arg_206_1.var_.characterEffect404001ui_story then
				arg_206_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_209_2 = 0
			local var_209_3 = 0.275

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(321211050)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 11)

				if (11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 11)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211050", "story_v_out_321211.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211050", "story_v_out_321211.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_321211", "321211050", "story_v_out_321211.awb")

						arg_206_1:RecordAudio("321211050", var_209_9)
						arg_206_1:RecordAudio("321211050", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_321211", "321211050", "story_v_out_321211.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_321211", "321211050", "story_v_out_321211.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play321211051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 321211051
		arg_210_1.duration_ = 7.57

		local var_210_0 = {
			zh = 6.933,
			ja = 7.566
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play321211052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos404001ui_story = arg_210_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).z)
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles = arg_210_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).z)
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles = arg_210_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1011ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1011ui_story = var_213_1.localPosition
			end

			local var_213_2 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_210_1.time_ - 0) / var_213_2)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0, -0.71, -6)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			local var_213_3 = arg_210_1.actors_["1011ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect1011ui_story == nil then
				arg_210_1.var_.characterEffect1011ui_story = var_213_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_4 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 and not isNil(var_213_3) then
				if arg_210_1.var_.characterEffect1011ui_story and not isNil(var_213_3) then
					arg_210_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect1011ui_story then
				arg_210_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_213_6 = arg_210_1.actors_["404001ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect404001ui_story == nil then
				arg_210_1.var_.characterEffect404001ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_7 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 and not isNil(var_213_6) then
				if arg_210_1.var_.characterEffect404001ui_story and not isNil(var_213_6) then
					arg_210_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_210_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_7)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect404001ui_story then
				arg_210_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_210_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_8 = 0
			local var_213_9 = 0.8

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:GetWordFromCfg(321211051)
				local var_213_11 = arg_210_1:FormatText(var_213_10.content)

				arg_210_1.text_.text = var_213_11

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 32 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 32)

				if (32 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 32)) > 0 and var_213_9 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_11
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211051", "story_v_out_321211.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211051", "story_v_out_321211.awb") / 1000

					if var_213_14 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_8
					end

					if var_213_10.prefab_name ~= "" and arg_210_1.actors_[var_213_10.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_10.prefab_name].transform, "story_v_out_321211", "321211051", "story_v_out_321211.awb")

						arg_210_1:RecordAudio("321211051", var_213_15)
						arg_210_1:RecordAudio("321211051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_321211", "321211051", "story_v_out_321211.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_321211", "321211051", "story_v_out_321211.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_16 and arg_210_1.time_ < var_213_8 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play321211052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 321211052
		arg_214_1.duration_ = 1.9

		local var_214_0 = {
			zh = 1.6,
			ja = 1.9
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play321211053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos404001ui_story = arg_214_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).z)
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles = arg_214_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["404001ui_story"].transform.position).z)
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["404001ui_story"].transform.localEulerAngles = arg_214_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1011ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1011ui_story == nil then
				arg_214_1.var_.characterEffect1011ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1011ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_2)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1011ui_story then
				arg_214_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_217_3 = 0
			local var_217_4 = 0.2

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_3 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_5 = arg_214_1:GetWordFromCfg(321211052)
				local var_217_6 = arg_214_1:FormatText(var_217_5.content)

				arg_214_1.text_.text = var_217_6

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_8 = 8 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_6) / 8)

				if (8 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_6) / 8)) > 0 and var_217_4 < var_217_8 then
					arg_214_1.talkMaxDuration = var_217_8

					if var_217_8 + var_217_3 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_3
					end
				end

				arg_214_1.text_.text = var_217_6
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211052", "story_v_out_321211.awb") ~= 0 then
					local var_217_9 = manager.audio:GetVoiceLength("story_v_out_321211", "321211052", "story_v_out_321211.awb") / 1000

					if var_217_9 + var_217_3 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_3
					end

					if var_217_5.prefab_name ~= "" and arg_214_1.actors_[var_217_5.prefab_name] ~= nil then
						local var_217_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_5.prefab_name].transform, "story_v_out_321211", "321211052", "story_v_out_321211.awb")

						arg_214_1:RecordAudio("321211052", var_217_10)
						arg_214_1:RecordAudio("321211052", var_217_10)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_321211", "321211052", "story_v_out_321211.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_321211", "321211052", "story_v_out_321211.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_11 = math.max(var_217_4, arg_214_1.talkMaxDuration)

			if var_217_3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_3 + var_217_11 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_3) / var_217_11

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_3 + var_217_11 and arg_214_1.time_ < var_217_3 + var_217_11 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play321211053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 321211053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play321211054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_9000

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["404001ui_story"]) and arg_218_1.var_.characterEffect404001ui_story == nil then
				arg_218_1.var_.characterEffect404001ui_story = arg_218_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["404001ui_story"]) then
				if arg_218_1.var_.characterEffect404001ui_story and not isNil(arg_218_1.actors_["404001ui_story"]) then
					arg_218_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_218_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["404001ui_story"]) and arg_218_1.var_.characterEffect404001ui_story then
				arg_218_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_218_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_218_1.time_ and arg_218_1.time_ <= 0.034000001847744 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			local var_221_2 = arg_218_1.actors_["404001ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos404001ui_story = var_221_2.localPosition
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_3)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, 100, 0)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				local var_221_4 = arg_218_1.var_.effect444

				if not arg_218_1.var_.effect444 then
					var_221_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_221_4.name = "444"
					arg_218_1.var_.effect444 = var_221_4
				else
					var_221_4.transform:SetParent(var_221_9000)
				end

				var_221_4.transform.localPosition = Vector3.New(0, 0, -4.81)
				var_221_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_221_7 = var_221_4.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_221_0, iter_221_1 in ipairs((var_221_7:ToTable())) do
					iter_221_1.transform.localScale = Vector3.New(iter_221_1.transform.localScale.x / var_221_6 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_221_7 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_221_1.transform.localScale.y / var_221_6, iter_221_1.transform.localScale.z)
				end
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				local var_221_9 = arg_218_1.bgs_.L15g

				arg_218_1.bgs_.L15g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_221_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_221_10 = var_221_9:GetComponent("SpriteRenderer")

				if var_221_10 and var_221_10.sprite then
					local var_221_11 = 2 * (var_221_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_221_9.transform.localScale = Vector3.New(var_221_11 / var_221_10.sprite.bounds.size.y < var_221_11 * manager.ui.mainCameraCom_.aspect / var_221_10.sprite.bounds.size.x and var_221_11 * manager.ui.mainCameraCom_.aspect / var_221_10.sprite.bounds.size.x or var_221_11 / var_221_10.sprite.bounds.size.y, var_221_11 / var_221_10.sprite.bounds.size.y < var_221_11 * manager.ui.mainCameraCom_.aspect / var_221_10.sprite.bounds.size.x and var_221_11 * manager.ui.mainCameraCom_.aspect / var_221_10.sprite.bounds.size.x or var_221_11 / var_221_10.sprite.bounds.size.y, 0)
				end

				for iter_221_2, iter_221_3 in pairs(arg_218_1.bgs_) do
					if iter_221_2 ~= "L15g" then
						iter_221_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_221_12 = arg_218_1.actors_["1011ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1011ui_story = var_221_12.localPosition
			end

			local var_221_13 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_13 then
				var_221_12.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_13)
				var_221_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_12.position).x, (manager.ui.mainCamera.transform.position - var_221_12.position).y, (manager.ui.mainCamera.transform.position - var_221_12.position).z)
				var_221_12.localEulerAngles.z = 0
				var_221_12.localEulerAngles.x = 0
				var_221_12.localEulerAngles = var_221_12.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_13 and arg_218_1.time_ < 0 + var_221_13 + arg_221_0 then
				var_221_12.localPosition = Vector3.New(0, 100, 0)
				var_221_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_12.position).x, (manager.ui.mainCamera.transform.position - var_221_12.position).y, (manager.ui.mainCamera.transform.position - var_221_12.position).z)
				var_221_12.localEulerAngles.z = 0
				var_221_12.localEulerAngles.x = 0
				var_221_12.localEulerAngles = var_221_12.localEulerAngles
			end

			local var_221_14 = 0
			local var_221_15 = 0.95

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_14 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_16 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(321211053).content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_18 = 38 <= 0 and var_221_15 or var_221_15 * (utf8.len(var_221_16) / 38)

				if (38 <= 0 and var_221_15 or var_221_15 * (utf8.len(var_221_16) / 38)) > 0 and var_221_15 < var_221_18 then
					arg_218_1.talkMaxDuration = var_221_18

					if var_221_18 + var_221_14 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_18 + var_221_14
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_19 = math.max(var_221_15, arg_218_1.talkMaxDuration)

			if var_221_14 <= arg_218_1.time_ and arg_218_1.time_ < var_221_14 + var_221_19 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_14) / var_221_19

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_14 + var_221_19 and arg_218_1.time_ < var_221_14 + var_221_19 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play321211054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 321211054
		arg_222_1.duration_ = 7.83

		local var_222_0 = {
			zh = 6.56633333333333,
			ja = 7.83333333333333
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play321211055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if arg_222_1.bgs_.L12f == nil then
				local var_225_0 = Object.Instantiate(arg_222_1.paintGo_)

				var_225_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L12f")
				var_225_0.name = "L12f"
				var_225_0.transform.parent = arg_222_1.stage_.transform
				var_225_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.bgs_.L12f = var_225_0
			end

			if 2 < arg_222_1.time_ and arg_222_1.time_ <= 2 + arg_225_0 then
				local var_225_1 = arg_222_1.bgs_.L12f

				arg_222_1.bgs_.L12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_225_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_2 = var_225_1:GetComponent("SpriteRenderer")

				if var_225_2 and var_225_2.sprite then
					local var_225_3 = 2 * (var_225_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_225_1.transform.localScale = Vector3.New(var_225_3 / var_225_2.sprite.bounds.size.y < var_225_3 * manager.ui.mainCameraCom_.aspect / var_225_2.sprite.bounds.size.x and var_225_3 * manager.ui.mainCameraCom_.aspect / var_225_2.sprite.bounds.size.x or var_225_3 / var_225_2.sprite.bounds.size.y, var_225_3 / var_225_2.sprite.bounds.size.y < var_225_3 * manager.ui.mainCameraCom_.aspect / var_225_2.sprite.bounds.size.x and var_225_3 * manager.ui.mainCameraCom_.aspect / var_225_2.sprite.bounds.size.x or var_225_3 / var_225_2.sprite.bounds.size.y, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "L12f" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_4 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_4 + 0.3 and arg_222_1.time_ < var_225_4 + 0.3 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_5 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_6 = 2

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_6 then
				local var_225_7 = Color.New(0, 0, 0)

				var_225_7.a = Mathf.Lerp(0, 1, (arg_222_1.time_ - var_225_5) / var_225_6)
				arg_222_1.mask_.color = var_225_7
			end

			if arg_222_1.time_ >= var_225_5 + var_225_6 and arg_222_1.time_ < var_225_5 + var_225_6 + arg_225_0 then
				local var_225_8 = Color.New(0, 0, 0)

				var_225_8.a = 1
				arg_222_1.mask_.color = var_225_8
			end

			local var_225_9 = 2

			if 2 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_10 = 2

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 then
				local var_225_11 = Color.New(0, 0, 0)

				var_225_11.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - var_225_9) / var_225_10)
				arg_222_1.mask_.color = var_225_11
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 then
				local var_225_12 = Color.New(0, 0, 0)

				arg_222_1.mask_.enabled = false
				var_225_12.a = 0
				arg_222_1.mask_.color = var_225_12
			end

			local var_225_13 = arg_222_1.actors_["404001ui_story"].transform

			if 1.988 < arg_222_1.time_ and arg_222_1.time_ <= 1.988 + arg_225_0 then
				arg_222_1.var_.moveOldPos404001ui_story = var_225_13.localPosition
			end

			local var_225_14 = 0.001

			if 1.988 <= arg_222_1.time_ and arg_222_1.time_ < 1.988 + var_225_14 then
				var_225_13.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 1.988) / var_225_14)
				var_225_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_13.position).x, (manager.ui.mainCamera.transform.position - var_225_13.position).y, (manager.ui.mainCamera.transform.position - var_225_13.position).z)
				var_225_13.localEulerAngles.z = 0
				var_225_13.localEulerAngles.x = 0
				var_225_13.localEulerAngles = var_225_13.localEulerAngles
			end

			if arg_222_1.time_ >= 1.988 + var_225_14 and arg_222_1.time_ < 1.988 + var_225_14 + arg_225_0 then
				var_225_13.localPosition = Vector3.New(0, 100, 0)
				var_225_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_13.position).x, (manager.ui.mainCamera.transform.position - var_225_13.position).y, (manager.ui.mainCamera.transform.position - var_225_13.position).z)
				var_225_13.localEulerAngles.z = 0
				var_225_13.localEulerAngles.x = 0
				var_225_13.localEulerAngles = var_225_13.localEulerAngles
			end

			if 2 < arg_222_1.time_ and arg_222_1.time_ <= 2 + arg_225_0 then
				if arg_222_1.var_.effect444 then
					Object.Destroy(arg_222_1.var_.effect444)

					arg_222_1.var_.effect444 = nil
				end
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_16 = 3.93333333333333
			local var_225_17 = 0.275

			if 3.93333333333333 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_18 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_18:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_19 = arg_222_1:GetWordFromCfg(321211054)
				local var_225_20 = arg_222_1:FormatText(var_225_19.content)

				arg_222_1.text_.text = var_225_20

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_22 = 11 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_20) / 11)

				if (11 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_20) / 11)) > 0 and var_225_17 < var_225_22 then
					arg_222_1.talkMaxDuration = var_225_22
					var_225_16 = var_225_16 + 0.3

					if var_225_22 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_16
					end
				end

				arg_222_1.text_.text = var_225_20
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211054", "story_v_out_321211.awb") ~= 0 then
					local var_225_23 = manager.audio:GetVoiceLength("story_v_out_321211", "321211054", "story_v_out_321211.awb") / 1000

					if var_225_23 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_16
					end

					if var_225_19.prefab_name ~= "" and arg_222_1.actors_[var_225_19.prefab_name] ~= nil then
						local var_225_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_19.prefab_name].transform, "story_v_out_321211", "321211054", "story_v_out_321211.awb")

						arg_222_1:RecordAudio("321211054", var_225_24)
						arg_222_1:RecordAudio("321211054", var_225_24)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_321211", "321211054", "story_v_out_321211.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_321211", "321211054", "story_v_out_321211.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_25 = var_225_16 + 0.3
			local var_225_26 = math.max(var_225_17, arg_222_1.talkMaxDuration)

			if var_225_16 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_25 + var_225_26 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_25) / var_225_26

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_25 + var_225_26 and arg_222_1.time_ < var_225_25 + var_225_26 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.988,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play321211055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 321211055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play321211056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if arg_228_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_231_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_228_1.stage_.transform)

				var_231_0.name = "1156ui_story"
				var_231_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.actors_["1156ui_story"] = var_231_0

				local var_231_1 = var_231_0:GetComponentInChildren(typeof(CharacterEffect))

				var_231_1.enabled = true

				local var_231_2 = GameObjectTools.GetOrAddComponent(var_231_0, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(false)
				end

				arg_228_1:ShowWeapon(var_231_1.transform, false)

				arg_228_1.var_["1156ui_story" .. "Animator"] = var_231_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_228_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_228_1.var_["1156ui_story" .. "LipSync"] = var_231_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_231_3 = arg_228_1.actors_["1156ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect1156ui_story == nil then
				arg_228_1.var_.characterEffect1156ui_story = var_231_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_4 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 and not isNil(var_231_3) then
				if arg_228_1.var_.characterEffect1156ui_story and not isNil(var_231_3) then
					arg_228_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_4)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect1156ui_story then
				arg_228_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_231_5 = 0
			local var_231_6 = 1.175

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(321211055).content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 47 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_7) / 47)

				if (47 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_7) / 47)) > 0 and var_231_6 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_5) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_5 + var_231_10 and arg_228_1.time_ < var_231_5 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play321211056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 321211056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play321211057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.45

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(321211056).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 58 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 58)

				if (58 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 58)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play321211057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 321211057
		arg_236_1.duration_ = 5.4

		local var_236_0 = {
			zh = 3.633,
			ja = 5.4
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play321211058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.475

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(321211057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 19 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 19)

				if (19 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 19)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211057", "story_v_out_321211.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211057", "story_v_out_321211.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_321211", "321211057", "story_v_out_321211.awb")

						arg_236_1:RecordAudio("321211057", var_239_6)
						arg_236_1:RecordAudio("321211057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_321211", "321211057", "story_v_out_321211.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_321211", "321211057", "story_v_out_321211.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play321211058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 321211058
		arg_240_1.duration_ = 4.67

		local var_240_0 = {
			zh = 3.633,
			ja = 4.666
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play321211059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if arg_240_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_243_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_240_1.stage_.transform)

				var_243_0.name = "2078ui_story"
				var_243_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["2078ui_story"] = var_243_0

				local var_243_1 = var_243_0:GetComponentInChildren(typeof(CharacterEffect))

				var_243_1.enabled = true

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_0, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end

				arg_240_1:ShowWeapon(var_243_1.transform, false)

				arg_240_1.var_["2078ui_story" .. "Animator"] = var_243_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_240_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_240_1.var_["2078ui_story" .. "LipSync"] = var_243_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_243_3 = arg_240_1.actors_["2078ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos2078ui_story = var_243_3.localPosition
			end

			local var_243_4 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				var_243_3.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_240_1.time_ - 0) / var_243_4)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				var_243_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_243_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_3.position).x, (manager.ui.mainCamera.transform.position - var_243_3.position).y, (manager.ui.mainCamera.transform.position - var_243_3.position).z)
				var_243_3.localEulerAngles.z = 0
				var_243_3.localEulerAngles.x = 0
				var_243_3.localEulerAngles = var_243_3.localEulerAngles
			end

			local var_243_5 = arg_240_1.actors_["2078ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect2078ui_story == nil then
				arg_240_1.var_.characterEffect2078ui_story = var_243_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_6 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_6 and not isNil(var_243_5) then
				if arg_240_1.var_.characterEffect2078ui_story and not isNil(var_243_5) then
					arg_240_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_6 and arg_240_1.time_ < 0 + var_243_6 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect2078ui_story then
				arg_240_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_8 = 0
			local var_243_9 = 0.45

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1175].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_10 = arg_240_1:GetWordFromCfg(321211058)
				local var_243_11 = arg_240_1:FormatText(var_243_10.content)

				arg_240_1.text_.text = var_243_11

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 18 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 18)

				if (18 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 18)) > 0 and var_243_9 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_11
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211058", "story_v_out_321211.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_321211", "321211058", "story_v_out_321211.awb") / 1000

					if var_243_14 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_8
					end

					if var_243_10.prefab_name ~= "" and arg_240_1.actors_[var_243_10.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_10.prefab_name].transform, "story_v_out_321211", "321211058", "story_v_out_321211.awb")

						arg_240_1:RecordAudio("321211058", var_243_15)
						arg_240_1:RecordAudio("321211058", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_321211", "321211058", "story_v_out_321211.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_321211", "321211058", "story_v_out_321211.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
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

		arg_240_1:InitPlayNodeList()
	end,
	Play321211059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 321211059
		arg_244_1.duration_ = 7.07

		local var_244_0 = {
			zh = 5.5,
			ja = 7.066
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play321211060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["2078ui_story"]) and arg_244_1.var_.characterEffect2078ui_story == nil then
				arg_244_1.var_.characterEffect2078ui_story = arg_244_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["2078ui_story"]) then
				if arg_244_1.var_.characterEffect2078ui_story and not isNil(arg_244_1.actors_["2078ui_story"]) then
					arg_244_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_244_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["2078ui_story"]) and arg_244_1.var_.characterEffect2078ui_story then
				arg_244_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_244_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.625

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(321211059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_6 = 25 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 25)

				if (25 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 25)) > 0 and var_247_2 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211059", "story_v_out_321211.awb") ~= 0 then
					local var_247_7 = manager.audio:GetVoiceLength("story_v_out_321211", "321211059", "story_v_out_321211.awb") / 1000

					if var_247_7 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_1
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_321211", "321211059", "story_v_out_321211.awb")

						arg_244_1:RecordAudio("321211059", var_247_8)
						arg_244_1:RecordAudio("321211059", var_247_8)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_321211", "321211059", "story_v_out_321211.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_321211", "321211059", "story_v_out_321211.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_9 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_9

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_9 and arg_244_1.time_ < var_247_1 + var_247_9 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play321211060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 321211060
		arg_248_1.duration_ = 7.63

		local var_248_0 = {
			zh = 3.8,
			ja = 7.633
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play321211061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.425

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1179].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:GetWordFromCfg(321211060)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 17 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 17)

				if (17 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 17)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211060", "story_v_out_321211.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211060", "story_v_out_321211.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_321211", "321211060", "story_v_out_321211.awb")

						arg_248_1:RecordAudio("321211060", var_251_6)
						arg_248_1:RecordAudio("321211060", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_321211", "321211060", "story_v_out_321211.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_321211", "321211060", "story_v_out_321211.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play321211061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 321211061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play321211062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos2078ui_story = arg_252_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).z)
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles = arg_252_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["2078ui_story"].transform.position).z)
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["2078ui_story"].transform.localEulerAngles = arg_252_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_255_1 = 0
			local var_255_2 = 1.6

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(321211061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 64 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 64)

				if (64 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 64)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play321211062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 321211062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play321211063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.875

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(321211062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 35 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 35)

				if (35 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 35)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play321211063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 321211063
		arg_260_1.duration_ = 2.1

		local var_260_0 = {
			zh = 1.6,
			ja = 2.1
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play321211064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1156ui_story"]) and arg_260_1.var_.characterEffect1156ui_story == nil then
				arg_260_1.var_.characterEffect1156ui_story = arg_260_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1156ui_story"]) then
				if arg_260_1.var_.characterEffect1156ui_story and not isNil(arg_260_1.actors_["1156ui_story"]) then
					arg_260_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1156ui_story"]) and arg_260_1.var_.characterEffect1156ui_story then
				arg_260_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_263_2 = 0
			local var_263_3 = 0.225

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_4 = arg_260_1:GetWordFromCfg(321211063)
				local var_263_5 = arg_260_1:FormatText(var_263_4.content)

				arg_260_1.text_.text = var_263_5

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_7 = 9 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 9)

				if (9 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_5) / 9)) > 0 and var_263_3 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_5
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211063", "story_v_out_321211.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211063", "story_v_out_321211.awb") / 1000

					if var_263_8 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_2
					end

					if var_263_4.prefab_name ~= "" and arg_260_1.actors_[var_263_4.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_4.prefab_name].transform, "story_v_out_321211", "321211063", "story_v_out_321211.awb")

						arg_260_1:RecordAudio("321211063", var_263_9)
						arg_260_1:RecordAudio("321211063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_321211", "321211063", "story_v_out_321211.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_321211", "321211063", "story_v_out_321211.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_10 and arg_260_1.time_ < var_263_2 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play321211064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 321211064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play321211065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1156ui_story"]) and arg_264_1.var_.characterEffect1156ui_story == nil then
				arg_264_1.var_.characterEffect1156ui_story = arg_264_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1156ui_story"]) then
				if arg_264_1.var_.characterEffect1156ui_story and not isNil(arg_264_1.actors_["1156ui_story"]) then
					arg_264_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_0)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1156ui_story"]) and arg_264_1.var_.characterEffect1156ui_story then
				arg_264_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_264_1.time_ and arg_264_1.time_ <= 0.034000001847744 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap02", "")
			end

			local var_267_2 = 0
			local var_267_3 = 1.2

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(321211064).content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_6 = 48 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_4) / 48)

				if (48 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_4) / 48)) > 0 and var_267_3 < var_267_6 then
					arg_264_1.talkMaxDuration = var_267_6

					if var_267_6 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_6 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_7 and arg_264_1.time_ < var_267_2 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play321211065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 321211065
		arg_268_1.duration_ = 14.43

		local var_268_0 = {
			zh = 9.233,
			ja = 14.433
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play321211066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1156ui_story = arg_268_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).z)
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles = arg_268_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_268_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1156ui_story"].transform.position).z)
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1156ui_story"].transform.localEulerAngles = arg_268_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_271_1 = arg_268_1.actors_["1156ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1156ui_story == nil then
				arg_268_1.var_.characterEffect1156ui_story = var_271_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 and not isNil(var_271_1) then
				if arg_268_1.var_.characterEffect1156ui_story and not isNil(var_271_1) then
					arg_268_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1156ui_story then
				arg_268_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_271_4 = 0
			local var_271_5 = 1.275

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(321211065)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_9 = 51 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 51)

				if (51 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 51)) > 0 and var_271_5 < var_271_9 then
					arg_268_1.talkMaxDuration = var_271_9

					if var_271_9 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_4
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211065", "story_v_out_321211.awb") ~= 0 then
					local var_271_10 = manager.audio:GetVoiceLength("story_v_out_321211", "321211065", "story_v_out_321211.awb") / 1000

					if var_271_10 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_4
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_out_321211", "321211065", "story_v_out_321211.awb")

						arg_268_1:RecordAudio("321211065", var_271_11)
						arg_268_1:RecordAudio("321211065", var_271_11)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_321211", "321211065", "story_v_out_321211.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_321211", "321211065", "story_v_out_321211.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_5, arg_268_1.talkMaxDuration)

			if var_271_4 <= arg_268_1.time_ and arg_268_1.time_ < var_271_4 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_4) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_4 + var_271_12 and arg_268_1.time_ < var_271_4 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play321211066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 321211066
		arg_272_1.duration_ = 10

		local var_272_0 = {
			zh = 6.4,
			ja = 10
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play321211067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.9

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(321211066)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 36 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 36)

				if (36 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 36)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211066", "story_v_out_321211.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211066", "story_v_out_321211.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_321211", "321211066", "story_v_out_321211.awb")

						arg_272_1:RecordAudio("321211066", var_275_6)
						arg_272_1:RecordAudio("321211066", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_321211", "321211066", "story_v_out_321211.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_321211", "321211066", "story_v_out_321211.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play321211067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 321211067
		arg_276_1.duration_ = 5.83

		local var_276_0 = {
			zh = 5.5,
			ja = 5.833
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play321211068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_2")
			end

			local var_279_0 = 0
			local var_279_1 = 0.775

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_2 = arg_276_1:GetWordFromCfg(321211067)
				local var_279_3 = arg_276_1:FormatText(var_279_2.content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 31 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 31)

				if (31 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 31)) > 0 and var_279_1 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211067", "story_v_out_321211.awb") ~= 0 then
					local var_279_6 = manager.audio:GetVoiceLength("story_v_out_321211", "321211067", "story_v_out_321211.awb") / 1000

					if var_279_6 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_0
					end

					if var_279_2.prefab_name ~= "" and arg_276_1.actors_[var_279_2.prefab_name] ~= nil then
						local var_279_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_2.prefab_name].transform, "story_v_out_321211", "321211067", "story_v_out_321211.awb")

						arg_276_1:RecordAudio("321211067", var_279_7)
						arg_276_1:RecordAudio("321211067", var_279_7)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_321211", "321211067", "story_v_out_321211.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_321211", "321211067", "story_v_out_321211.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play321211068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 321211068
		arg_280_1.duration_ = 4.3

		local var_280_0 = {
			zh = 4.3,
			ja = 3.8
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play321211069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.45

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:GetWordFromCfg(321211068)
				local var_283_2 = arg_280_1:FormatText(var_283_1.content)

				arg_280_1.text_.text = var_283_2

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 18 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 18)

				if (18 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 18)) > 0 and var_283_0 < var_283_4 then
					arg_280_1.talkMaxDuration = var_283_4

					if var_283_4 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_4 + 0
					end
				end

				arg_280_1.text_.text = var_283_2
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211068", "story_v_out_321211.awb") ~= 0 then
					local var_283_5 = manager.audio:GetVoiceLength("story_v_out_321211", "321211068", "story_v_out_321211.awb") / 1000

					if var_283_5 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + 0
					end

					if var_283_1.prefab_name ~= "" and arg_280_1.actors_[var_283_1.prefab_name] ~= nil then
						local var_283_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_1.prefab_name].transform, "story_v_out_321211", "321211068", "story_v_out_321211.awb")

						arg_280_1:RecordAudio("321211068", var_283_6)
						arg_280_1:RecordAudio("321211068", var_283_6)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_321211", "321211068", "story_v_out_321211.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_321211", "321211068", "story_v_out_321211.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play321211069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321211069
		arg_284_1.duration_ = 3.37

		local var_284_0 = {
			zh = 3.19966666666667,
			ja = 3.36666666666667
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play321211070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1156ui_story = arg_284_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).z)
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles = arg_284_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_284_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1156ui_story"].transform.position).z)
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1156ui_story"].transform.localEulerAngles = arg_284_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_287_1 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_1 + 0.683333333333333 and arg_284_1.time_ < var_287_1 + 0.683333333333333 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_2 = 0.566666666666667
			local var_287_3 = 0.25

			if 0.566666666666667 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_4 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_4:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:GetWordFromCfg(321211069)
				local var_287_6 = arg_284_1:FormatText(var_287_5.content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_8 = 10 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_6) / 10)

				if (10 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_6) / 10)) > 0 and var_287_3 < var_287_8 then
					arg_284_1.talkMaxDuration = var_287_8
					var_287_2 = var_287_2 + 0.3

					if var_287_8 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211069", "story_v_out_321211.awb") ~= 0 then
					local var_287_9 = manager.audio:GetVoiceLength("story_v_out_321211", "321211069", "story_v_out_321211.awb") / 1000

					if var_287_9 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_2
					end

					if var_287_5.prefab_name ~= "" and arg_284_1.actors_[var_287_5.prefab_name] ~= nil then
						local var_287_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_5.prefab_name].transform, "story_v_out_321211", "321211069", "story_v_out_321211.awb")

						arg_284_1:RecordAudio("321211069", var_287_10)
						arg_284_1:RecordAudio("321211069", var_287_10)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_321211", "321211069", "story_v_out_321211.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_321211", "321211069", "story_v_out_321211.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_11 = var_287_2 + 0.3
			local var_287_12 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_11 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_11) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_11 + var_287_12 and arg_284_1.time_ < var_287_11 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play321211070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 321211070
		arg_290_1.duration_ = 5.98

		local var_290_0 = {
			zh = 5.97500000298023,
			ja = 5.774999999999
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play321211071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 2 < arg_290_1.time_ and arg_290_1.time_ <= 2 + arg_293_0 then
				local var_293_0 = arg_290_1.bgs_.L12f

				arg_290_1.bgs_.L12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_1 = var_293_0:GetComponent("SpriteRenderer")

				if var_293_1 and var_293_1.sprite then
					local var_293_2 = 2 * (var_293_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_0.transform.localScale = Vector3.New(var_293_2 / var_293_1.sprite.bounds.size.y < var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x and var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x or var_293_2 / var_293_1.sprite.bounds.size.y, var_293_2 / var_293_1.sprite.bounds.size.y < var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x and var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x or var_293_2 / var_293_1.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "L12f" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_3 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_3 + 0.3 and arg_290_1.time_ < var_293_3 + 0.3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_4 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_5 = 2

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_5 then
				local var_293_6 = Color.New(0, 0, 0)

				var_293_6.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_4) / var_293_5)
				arg_290_1.mask_.color = var_293_6
			end

			if arg_290_1.time_ >= var_293_4 + var_293_5 and arg_290_1.time_ < var_293_4 + var_293_5 + arg_293_0 then
				local var_293_7 = Color.New(0, 0, 0)

				var_293_7.a = 1
				arg_290_1.mask_.color = var_293_7
			end

			local var_293_8 = 2

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_9 = 2

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_9 then
				local var_293_10 = Color.New(0, 0, 0)

				var_293_10.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_8) / var_293_9)
				arg_290_1.mask_.color = var_293_10
			end

			if arg_290_1.time_ >= var_293_8 + var_293_9 and arg_290_1.time_ < var_293_8 + var_293_9 + arg_293_0 then
				local var_293_11 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_11.a = 0
				arg_290_1.mask_.color = var_293_11
			end

			local var_293_12 = arg_290_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_290_1.time_ and arg_290_1.time_ <= 1.96599999815226 + arg_293_0 then
				arg_290_1.var_.moveOldPos1156ui_story = var_293_12.localPosition
			end

			local var_293_13 = 0.001

			if 1.96599999815226 <= arg_290_1.time_ and arg_290_1.time_ < 1.96599999815226 + var_293_13 then
				var_293_12.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_290_1.time_ - 1.96599999815226) / var_293_13)
				var_293_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_12.position).x, (manager.ui.mainCamera.transform.position - var_293_12.position).y, (manager.ui.mainCamera.transform.position - var_293_12.position).z)
				var_293_12.localEulerAngles.z = 0
				var_293_12.localEulerAngles.x = 0
				var_293_12.localEulerAngles = var_293_12.localEulerAngles
			end

			if arg_290_1.time_ >= 1.96599999815226 + var_293_13 and arg_290_1.time_ < 1.96599999815226 + var_293_13 + arg_293_0 then
				var_293_12.localPosition = Vector3.New(0, 100, 0)
				var_293_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_12.position).x, (manager.ui.mainCamera.transform.position - var_293_12.position).y, (manager.ui.mainCamera.transform.position - var_293_12.position).z)
				var_293_12.localEulerAngles.z = 0
				var_293_12.localEulerAngles.x = 0
				var_293_12.localEulerAngles = var_293_12.localEulerAngles
			end

			local var_293_14 = arg_290_1.actors_["1011ui_story"].transform

			if 3.775 < arg_290_1.time_ and arg_290_1.time_ <= 3.775 + arg_293_0 then
				arg_290_1.var_.moveOldPos1011ui_story = var_293_14.localPosition
			end

			local var_293_15 = 0.001

			if 3.775 <= arg_290_1.time_ and arg_290_1.time_ < 3.775 + var_293_15 then
				var_293_14.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_290_1.time_ - 3.775) / var_293_15)
				var_293_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_14.position).x, (manager.ui.mainCamera.transform.position - var_293_14.position).y, (manager.ui.mainCamera.transform.position - var_293_14.position).z)
				var_293_14.localEulerAngles.z = 0
				var_293_14.localEulerAngles.x = 0
				var_293_14.localEulerAngles = var_293_14.localEulerAngles
			end

			if arg_290_1.time_ >= 3.775 + var_293_15 and arg_290_1.time_ < 3.775 + var_293_15 + arg_293_0 then
				var_293_14.localPosition = Vector3.New(0, -0.71, -6)
				var_293_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_14.position).x, (manager.ui.mainCamera.transform.position - var_293_14.position).y, (manager.ui.mainCamera.transform.position - var_293_14.position).z)
				var_293_14.localEulerAngles.z = 0
				var_293_14.localEulerAngles.x = 0
				var_293_14.localEulerAngles = var_293_14.localEulerAngles
			end

			local var_293_16 = arg_290_1.actors_["1011ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_16) and arg_290_1.var_.characterEffect1011ui_story == nil then
				arg_290_1.var_.characterEffect1011ui_story = var_293_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_17 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_17 and not isNil(var_293_16) then
				if arg_290_1.var_.characterEffect1011ui_story and not isNil(var_293_16) then
					arg_290_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_17 and arg_290_1.time_ < 0 + var_293_17 + arg_293_0 and not isNil(var_293_16) and arg_290_1.var_.characterEffect1011ui_story then
				arg_290_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_293_19 = arg_290_1.actors_["1156ui_story"]

			if 3.775 < arg_290_1.time_ and arg_290_1.time_ <= 3.775 + arg_293_0 and not isNil(var_293_19) and arg_290_1.var_.characterEffect1156ui_story == nil then
				arg_290_1.var_.characterEffect1156ui_story = var_293_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_20 = 0.200000002980232

			if 3.775 <= arg_290_1.time_ and arg_290_1.time_ < 3.775 + var_293_20 and not isNil(var_293_19) then
				if arg_290_1.var_.characterEffect1156ui_story and not isNil(var_293_19) then
					arg_290_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 3.775) / var_293_20)
				end
			end

			if arg_290_1.time_ >= 3.775 + var_293_20 and arg_290_1.time_ < 3.775 + var_293_20 + arg_293_0 and not isNil(var_293_19) and arg_290_1.var_.characterEffect1156ui_story then
				arg_290_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 3.775 < arg_290_1.time_ and arg_290_1.time_ <= 3.775 + arg_293_0 then
				arg_290_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 3.775 < arg_290_1.time_ and arg_290_1.time_ <= 3.775 + arg_293_0 then
				arg_290_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_21 = 3.97500000298023
			local var_293_22 = 0.225

			if 3.97500000298023 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_23 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_23:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_24 = arg_290_1:GetWordFromCfg(321211070)
				local var_293_25 = arg_290_1:FormatText(var_293_24.content)

				arg_290_1.text_.text = var_293_25

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_27 = 9 <= 0 and var_293_22 or var_293_22 * (utf8.len(var_293_25) / 9)

				if (9 <= 0 and var_293_22 or var_293_22 * (utf8.len(var_293_25) / 9)) > 0 and var_293_22 < var_293_27 then
					arg_290_1.talkMaxDuration = var_293_27
					var_293_21 = var_293_21 + 0.3

					if var_293_27 + var_293_21 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_27 + var_293_21
					end
				end

				arg_290_1.text_.text = var_293_25
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211070", "story_v_out_321211.awb") ~= 0 then
					local var_293_28 = manager.audio:GetVoiceLength("story_v_out_321211", "321211070", "story_v_out_321211.awb") / 1000

					if var_293_28 + var_293_21 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_28 + var_293_21
					end

					if var_293_24.prefab_name ~= "" and arg_290_1.actors_[var_293_24.prefab_name] ~= nil then
						local var_293_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_24.prefab_name].transform, "story_v_out_321211", "321211070", "story_v_out_321211.awb")

						arg_290_1:RecordAudio("321211070", var_293_29)
						arg_290_1:RecordAudio("321211070", var_293_29)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_321211", "321211070", "story_v_out_321211.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_321211", "321211070", "story_v_out_321211.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_30 = var_293_21 + 0.3
			local var_293_31 = math.max(var_293_22, arg_290_1.talkMaxDuration)

			if var_293_21 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_30 + var_293_31 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_30) / var_293_31

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_30 + var_293_31 and arg_290_1.time_ < var_293_30 + var_293_31 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.775,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play321211071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 321211071
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play321211072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1011ui_story"]) and arg_296_1.var_.characterEffect1011ui_story == nil then
				arg_296_1.var_.characterEffect1011ui_story = arg_296_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1011ui_story"]) then
				if arg_296_1.var_.characterEffect1011ui_story and not isNil(arg_296_1.actors_["1011ui_story"]) then
					arg_296_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_0)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1011ui_story"]) and arg_296_1.var_.characterEffect1011ui_story then
				arg_296_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_299_1 = arg_296_1.actors_["1011ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1011ui_story = var_299_1.localPosition
			end

			local var_299_2 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 then
				var_299_1.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_2)
				var_299_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_1.position).x, (manager.ui.mainCamera.transform.position - var_299_1.position).y, (manager.ui.mainCamera.transform.position - var_299_1.position).z)
				var_299_1.localEulerAngles.z = 0
				var_299_1.localEulerAngles.x = 0
				var_299_1.localEulerAngles = var_299_1.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 then
				var_299_1.localPosition = Vector3.New(0, 100, 0)
				var_299_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_1.position).x, (manager.ui.mainCamera.transform.position - var_299_1.position).y, (manager.ui.mainCamera.transform.position - var_299_1.position).z)
				var_299_1.localEulerAngles.z = 0
				var_299_1.localEulerAngles.x = 0
				var_299_1.localEulerAngles = var_299_1.localEulerAngles
			end

			local var_299_3 = 0
			local var_299_4 = 1.375

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_3 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_5 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(321211071).content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 55 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_5) / 55)

				if (55 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_5) / 55)) > 0 and var_299_4 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_3 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_3
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_8 = math.max(var_299_4, arg_296_1.talkMaxDuration)

			if var_299_3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_3 + var_299_8 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_3) / var_299_8

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_3 + var_299_8 and arg_296_1.time_ < var_299_3 + var_299_8 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play321211072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321211072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321211073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1011ui_story = arg_300_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).z)
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles = arg_300_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1011ui_story"].transform.position).z)
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1011ui_story"].transform.localEulerAngles = arg_300_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_303_1 = 0
			local var_303_2 = 1.375

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_3 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(321211072).content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 55 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 55)

				if (55 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 55)) > 0 and var_303_2 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_6 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_6 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_6

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_6 and arg_300_1.time_ < var_303_1 + var_303_6 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play321211073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321211073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play321211074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0.566666666666667 < arg_304_1.time_ and arg_304_1.time_ <= 0.566666666666667 + arg_307_0 then
				arg_304_1:AudioAction("play", "effect", "se_story_140", "se_story_140_metal shake", "")
			end

			local var_307_1 = 0
			local var_307_2 = 0.775

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(321211073).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 31 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 31)

				if (31 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 31)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play321211074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321211074
		arg_308_1.duration_ = 1.5

		local var_308_0 = {
			zh = 0.999999999999,
			ja = 1.5
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321211075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["404001ui_story"]) and arg_308_1.var_.characterEffect404001ui_story == nil then
				arg_308_1.var_.characterEffect404001ui_story = arg_308_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["404001ui_story"]) then
				if arg_308_1.var_.characterEffect404001ui_story and not isNil(arg_308_1.actors_["404001ui_story"]) then
					arg_308_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["404001ui_story"]) and arg_308_1.var_.characterEffect404001ui_story then
				arg_308_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_311_2 = 0
			local var_311_3 = 0.125

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_4 = arg_308_1:GetWordFromCfg(321211074)
				local var_311_5 = arg_308_1:FormatText(var_311_4.content)

				arg_308_1.text_.text = var_311_5

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_7 = 5 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 5)

				if (5 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_5) / 5)) > 0 and var_311_3 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_2
					end
				end

				arg_308_1.text_.text = var_311_5
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211074", "story_v_out_321211.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211074", "story_v_out_321211.awb") / 1000

					if var_311_8 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_2
					end

					if var_311_4.prefab_name ~= "" and arg_308_1.actors_[var_311_4.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_4.prefab_name].transform, "story_v_out_321211", "321211074", "story_v_out_321211.awb")

						arg_308_1:RecordAudio("321211074", var_311_9)
						arg_308_1:RecordAudio("321211074", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321211", "321211074", "story_v_out_321211.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321211", "321211074", "story_v_out_321211.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_3, arg_308_1.talkMaxDuration)

			if var_311_2 <= arg_308_1.time_ and arg_308_1.time_ < var_311_2 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_2) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_2 + var_311_10 and arg_308_1.time_ < var_311_2 + var_311_10 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play321211075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321211075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play321211076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["404001ui_story"]) and arg_312_1.var_.characterEffect404001ui_story == nil then
				arg_312_1.var_.characterEffect404001ui_story = arg_312_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["404001ui_story"]) then
				if arg_312_1.var_.characterEffect404001ui_story and not isNil(arg_312_1.actors_["404001ui_story"]) then
					arg_312_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_312_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["404001ui_story"]) and arg_312_1.var_.characterEffect404001ui_story then
				arg_312_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_312_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_315_1 = 0
			local var_315_2 = 0.9

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_3 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(321211075).content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 36 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 36)

				if (36 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 36)) > 0 and var_315_2 < var_315_5 then
					arg_312_1.talkMaxDuration = var_315_5

					if var_315_5 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_6 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_6 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_6

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_6 and arg_312_1.time_ < var_315_1 + var_315_6 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play321211076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321211076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play321211077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone04", "")
			end

			local var_319_1 = manager.ui.mainCamera.transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.shakeOldPos = var_319_1.localPosition
			end

			local var_319_2 = 0.833333333333333

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 then
				local var_319_3, var_319_4 = math.modf((arg_316_1.time_ - 0) / 0.066)

				var_319_1.localPosition = Vector3.New(var_319_4 * 0.13, var_319_4 * 0.13, var_319_4 * 0.13) + arg_316_1.var_.shakeOldPos
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 then
				var_319_1.localPosition = arg_316_1.var_.shakeOldPos
			end

			local var_319_5 = 0
			local var_319_6 = 0.975

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_7 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(321211076).content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_9 = 39 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_7) / 39)

				if (39 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_7) / 39)) > 0 and var_319_6 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_5
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_6, arg_316_1.talkMaxDuration)

			if var_319_5 <= arg_316_1.time_ and arg_316_1.time_ < var_319_5 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_5) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_5 + var_319_10 and arg_316_1.time_ < var_319_5 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321211077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321211077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321211078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.7

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(321211077).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 28 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 28)

				if (28 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 28)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321211078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321211078
		arg_324_1.duration_ = 4.53

		local var_324_0 = {
			zh = 4.033,
			ja = 4.533
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321211079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1011ui_story"]) and arg_324_1.var_.characterEffect1011ui_story == nil then
				arg_324_1.var_.characterEffect1011ui_story = arg_324_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1011ui_story"]) then
				if arg_324_1.var_.characterEffect1011ui_story and not isNil(arg_324_1.actors_["1011ui_story"]) then
					arg_324_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1011ui_story"]) and arg_324_1.var_.characterEffect1011ui_story then
				arg_324_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_327_2 = 0
			local var_327_3 = 0.45

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_4 = arg_324_1:GetWordFromCfg(321211078)
				local var_327_5 = arg_324_1:FormatText(var_327_4.content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 18 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 18)

				if (18 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 18)) > 0 and var_327_3 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321211", "321211078", "story_v_out_321211.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_321211", "321211078", "story_v_out_321211.awb") / 1000

					if var_327_8 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_2
					end

					if var_327_4.prefab_name ~= "" and arg_324_1.actors_[var_327_4.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_4.prefab_name].transform, "story_v_out_321211", "321211078", "story_v_out_321211.awb")

						arg_324_1:RecordAudio("321211078", var_327_9)
						arg_324_1:RecordAudio("321211078", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_321211", "321211078", "story_v_out_321211.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_321211", "321211078", "story_v_out_321211.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_10 and arg_324_1.time_ < var_327_2 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play321211079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321211079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
			arg_328_1.auto_ = false
		end

		function arg_328_1.playNext_(arg_330_0)
			arg_328_1.onStoryFinished_()
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1011ui_story"]) and arg_328_1.var_.characterEffect1011ui_story == nil then
				arg_328_1.var_.characterEffect1011ui_story = arg_328_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1011ui_story"]) then
				if arg_328_1.var_.characterEffect1011ui_story and not isNil(arg_328_1.actors_["1011ui_story"]) then
					arg_328_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_0)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1011ui_story"]) and arg_328_1.var_.characterEffect1011ui_story then
				arg_328_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_328_1.time_ and arg_328_1.time_ <= 0.034000001847744 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor02", "")
			end

			if 0.584 < arg_328_1.time_ and arg_328_1.time_ <= 0.584 + arg_331_0 then
				arg_328_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_cardoor02", "")
			end

			local var_331_3 = 0
			local var_331_4 = 0.825

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_5 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(321211079).content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 33 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_5) / 33)

				if (33 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_5) / 33)) > 0 and var_331_4 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_3
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_4, arg_328_1.talkMaxDuration)

			if var_331_3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_3 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_3) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_3 + var_331_8 and arg_328_1.time_ < var_331_3 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/L15g",
		"TextureConfig/Background/L12f"
	},
	voices = {
		"story_v_out_321211.awb"
	}
}
